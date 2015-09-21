//
//  ViewController.swift
//  demo2
//
//  Created by 潘新宇 on 15/8/19.
//  Copyright (c) 2015年 潘新宇. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var tag:String!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = tag
        
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        println(tag)
        
        /**
        画图表
        */
        setChart()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
    画图方法
    */
    func setChart(){
        switch self.tag{
        case "折线图" :
            println(tag)
            setLineChart()
        case "柱形图" :
            println(tag)
            setBarChart()
        case "圆形图" :
            println(tag)
            setCircleChart()
        case "饼状图" :
            println(tag)
            setPieChart()
        default:
            break
        }
        
    }

    /**
    画折线图
    */
    func  setLineChart(){
        
        /// 定义一个lineChart
        
        var lineChart = PNLineChart(frame: CGRectMake(0, self.view.frame.height/4, self.view.frame.width, self.view.frame.height/2))
        //不要用下面的方法，Width 不好计算，只设置数据的话宽度会自动设定*********************
        //lineChart.setXLabels(["A","B","C","D","E","F"], withWidth: 50)
        lineChart.xLabels = ["A","B","C","D","E","F"]
        lineChart.axisColor = UIColor.blackColor()
        lineChart.showCoordinateAxis = true
        
        /// 设置第一根折线
        var dataArray = [1,4,9,20,8,9]
        var lineChartData = PNLineChartData()
        //lineChartData.lineWidth = 20
        lineChartData.itemCount = UInt(dataArray.count)
        lineChartData.color = UIColor.greenColor()
        lineChartData.getData = ({(index:UInt) -> PNLineChartDataItem in
            var y = dataArray[Int(index)]
            return PNLineChartDataItem(y: CGFloat(y))
        })
        //为数据源设置Title
        lineChartData.dataTitle = "Swift"
        
        /// 设置第二根折线
        var dataArray2 = [5,19,9,3,5]
        var lineChartData2 = PNLineChartData()
        //lineChartData.lineWidth = 20
        lineChartData2.itemCount = UInt(dataArray2.count)
        lineChartData2.color = UIColor.redColor()
        lineChartData2.getData = ({(index:UInt) -> PNLineChartDataItem in
            var y = dataArray2[Int(index)]
            return PNLineChartDataItem(y: CGFloat(y))
        })
        
        
        //把折线加入到lineChart中，开始画图
        lineChart.chartData = [lineChartData,lineChartData2]
        lineChart.strokeChart()
        
        self.view.addSubview(lineChart)
        
    /// 为图表设置标签，****要在画图之后添加****
        //为数据源2设置Title
        lineChartData2.dataTitle = "OC"
        //选择标签风格
        lineChart.legendStyle = PNLegendItemStyle.Serial
        //获取标签
        var legend = lineChart.getLegendWithMaxWidth(self.view.frame.width)
        //设置标签位置
        legend.frame = CGRectMake(50, lineChart.frame.origin.y + lineChart.frame.height + 10, legend.frame.width, legend.frame.height)
        
        self.view.addSubview(legend)
        
        lineChart.delegate = self
    }
    
    
    /**
    画条形图
    */
    func setBarChart(){
        //直接初始化一个PNBarChart，不要数据源
        var barChart = PNBarChart(frame: CGRectMake(0, 200, self.view.frame.width, 350))
        barChart.xLabels = ["A","B","C","D","E"]
        //barChart.xLabelWidth = 55
        barChart.yValues = [1,3,6,-7,15]
        //显示图表边界
        barChart.showChartBorder = true
        //允许负数
        barChart.showLevelLine = false
        
        //barChart.strokeColor = UIColor.redColor()
        barChart.barRadius = 2
        //设置文字颜色，**********设置不了************
        barChart.labelTextColor = UIColor.redColor()
        
        //开始画图
        barChart.strokeChart()
        self.view.addSubview(barChart)
    }
    
    /**
    画圆形图
    */
    func setCircleChart(){
        //直接初始化一个PNCircleChart ，不要数据源之类的
        var circelChart = PNCircleChart(frame: CGRectMake(self.view.frame.width/2 - self.view.frame.width/4, 200, self.view.frame.width/2, 200), total: 100, current: 60, clockwise: false, shadow: true, shadowColor: UIColor.grayColor())
        circelChart.current = 60
        circelChart.total = 100
        //circelChart.strokeColor = UIColor.greenColor()
        
        circelChart.strokeChart()
        self.view.addSubview(circelChart)
    }
    
    
    /**
    画饼状图
    */
    func setPieChart(){
        //先定义一个PNPieChartDataItem数组，116	202	33      72	114	224
        var items = [PNPieChartDataItem(value: 50, color: UIColor(red: 116/255, green: 202/255, blue: 33/255, alpha: 1) , description: "Swift"),PNPieChartDataItem(value: 20, color: UIColor(red: 72/255, green: 114/255, blue: 224/255, alpha: 1) , description: "OC")]
        
        var pieChart = PNPieChart(frame: CGRectMake(self.view.frame.width/2 - self.view.frame.width/3, 200, self.view.frame.width/1.5, 200), items: items)
        
        pieChart.descriptionTextFont = UIFont.systemFontOfSize(15)
        
        pieChart.strokeChart()
        self.view.addSubview(pieChart)
        
        //选择标签风格
        pieChart.legendStyle = PNLegendItemStyle.Serial
        //获取标签
        var legend = pieChart.getLegendWithMaxWidth(self.view.frame.width)
        //设置标签位置
        legend.frame = CGRectMake(50, pieChart.frame.origin.y + pieChart.frame.height + 10, legend.frame.width, legend.frame.height)
        
        self.view.addSubview(legend)

        
    }
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - PNChartDelegate 相关

extension ViewController:PNChartDelegate{
    func userClickedOnLinePoint(point: CGPoint, lineIndex: Int) {
        println("You clicked \(point)")
    }
    func userClickedOnLineKeyPoint(point: CGPoint, lineIndex: Int, pointIndex: Int) {
        println("You clicked line \(lineIndex) point \(pointIndex)")
    }
    
}
