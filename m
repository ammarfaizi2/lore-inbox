Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264931AbSLBFhV>; Mon, 2 Dec 2002 00:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264943AbSLBFhV>; Mon, 2 Dec 2002 00:37:21 -0500
Received: from wiprom2mx2.wipro.com ([203.197.164.42]:23699 "EHLO
	wiprom2mx2.wipro.com") by vger.kernel.org with ESMTP
	id <S264931AbSLBFhQ>; Mon, 2 Dec 2002 00:37:16 -0500
From: "Sowmya Adiga" <sowmya.adiga@wipro.com>
To: <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK RESULT]AIM benchmark Results for Kernel 2.5.49 and 2.5.50
Date: Mon, 2 Dec 2002 11:14:28 +0530
Organization: Wipro Technologies
Message-ID: <003501c299c5$e1304800$6009720a@wipro.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
X-OriginalArrivalTime: 02 Dec 2002 05:44:28.0535 (UTC) FILETIME=[E12EE870:01C299C5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are the AIM benchmark Results for Kernel 2.5.49 and 2.5.50.Result
showed
Kernel 2.5.50 performed better than 2.5.49



AIM Independent Resource Benchmark - Suite IX v1.1, January 22, 1996
Copyright (c) 1996 - 2001 Caldera International, Inc. All Rights
Reserved

Machine's name                                    : access1
Machine's configuration                           : PIII/868MHZ/128MB
Number of seconds to run each test [2 to 1000]    : 60
Path to disk files                                : /tmp


------------------------------------------------------------------------

  Test Name       Elapsed   Iteration     Iteration          Operation
  and number    Time (sec)    Count    Rate (loops/sec)    Rate
(ops/sec)
------------------------------------------------------------------------

1 add_double         Thousand Double Precision Additions/second
linux-2.5.49         60.02        716      11.92936        214728.42 
linux-2.5.50         60.04        716      11.92538        214656.90 


2 add_float          Thousand Single Precision Additions/second
linux-2.5.49         60.05        1075     17.90175        214820.98 
linux-2.5.50         60.06        1075     17.89877        214785.21



3 add_long            Thousand Long Integer Additions/second
linux-2.5.49         60.01        1768     29.46176        1767705.38 
linux-2.5.50         60.01        1768     29.46176        1767705.38


4 add_int             Thousand Integer Additions/second
linux-2.5.49         60.00        1767     29.45000        1767000.00 
linux-2.5.50         60.01        1768     29.46176        1767705.38


5 add_short           Thousand Short Integer Additions/second
linux-2.5.49         60.01        4419     73.63773        1767305.45 
linux-2.5.50         60.00        4419     73.65000        1767600.00


6 creat-clo           File Creations and Closes/second
linux-2.5.49         60.03        1667     27.76945        27769.45 
linux-2.5.50         60.03        1715     28.56905        28569.05



7 page_test           System Allocations & Pages/second
linux-2.5.49         60.00        8390     139.83333       237716.67 
linux-2.5.50         60.00        8751     145.85000       247945.00


8 brk_test            System Memory Allocations/second
linux-2.5.49         60.01        3401     56.67389        963456.09 
linux-2.5.50         60.01        3403     56.70722        964022.66


9 jmp_test            Non-local gotos/second
linux-2.5.49          60.00       318158   5302.63333      5302633.33 
linux-2.5.50          60.00       318176   5302.93333      5302933.33


10 signal_test         Signal Traps/second
linux-2.5.49          60.00       8231     137.18333       137183.33 
linux-2.5.50          60.00       8543     142.38333       142383.33


11 exec_test           Program Loads/second
linux-2.5.49          60.02       2016     33.58880        167.94 
linux-2.5.50          60.00       2041     34.01667        170.08


12 fork_test           Task Creations/second
linux-2.5.49          60.04       1006     16.75550        1675.55 
linux-2.5.50          60.06       1154     19.21412        1921.41 


13 link_test           Link/Unlink Pairs/second
linux-2.5.49          60.01       9819     163.62273       10308.23 
linux-2.5.50          60.00       9921     165.35000       10417.05


14 disk_rr             Random Disk Reads (K)/second
linux-2.5.49          60.07       490      8.15715         41764.61 
linux-2.5.50          60.09       499      8.30421         42517.56


15 disk_rw             Random Disk Writes (K)/second
linux-2.5.49          60.04       384      6.39574         32746.17 
linux-2.5.50          60.14       397      6.60126         33798.47


16 disk_rd            Sequential Disk Reads (K)/second
linux-2.5.49          60.01       2783     46.37560        237443.09 
linux-2.5.50          60.00       2836     47.26667        242005.33


17 disk_wrt           Sequential Disk Writes (K)/second 
linux-2.5.49          60.04        625     10.40973        53297.80 
linux-2.5.50          60.04        656     10.92605        55941.37


18 disk_cp            Disk Copies (K)/second
linux-2.5.49          60.11        489     8.13509         41651.64 
linux-2.5.50          60.01        523     8.71521         44621.90 


19 sync_disk_rw       Sync Random Disk Writes (K)/second
linux-2.5.49          61.37        1       0.01629         41.71 
linux-2.5.50          61.09        1       0.01637         41.91 


20 sync_disk_wrt      Sync Sequential Disk Writes (K)/second 
linux-2.5.49          77.11        2       0.02594         66.40 
linux-2.5.50          77.37        2       0.02585         66.18 


21 sync_disk_cp       Sync Disk Copies (K)/second
linux-2.5.49          77.46        2       0.02582         66.10 
linux-2.5.50          77.52        2       0.02580         66.05 


22 disk_src           Directory Searches/second
linux-2.5.49          60.01        10603   176.68722       13251.54 
linux-2.5.50          60.00        10764   179.40000       13455.00


23 div_double          Thousand Double Precision Divides/second
linux-2.5.49          60.03        1322    22.02232        66066.97 
linux-2.5.50          60.01        1322    22.02966        66088.99


24 div_float          Thousand Single Precision Divides/second
linux-2.5.49          60.02        1322    22.02599        66077.97 
linux-2.5.50          60.00        1322    22.03333        66100.00 


25 div_long            Thousand Long Integer Divides/second
linux-2.5.49           60.03       1592    26.52007        23868.07 
linux-2.5.50           60.03       1592    26.52007        23868.07


26 div_int             Thousand Integer Divides/second
linux-2.5.49           60.03       1592    26.52007        23868.07 
linux-2.5.50           60.03       1592    26.52007        23868.07


27 div_short           Thousand Short Integer Divides/second
linux-2.5.49           60.03       1592    26.52007        23868.07 
linux-2.5.50           60.03       1592    26.52007        23868.07


28 fun_cal             Function Calls (no arguments)/second
linux-2.5.49           60.01       4362    72.68789        37216197.30 
linux-2.5.50           60.00       4362    72.70000        37222400.00 


29 fun_cal1            Function Calls (1 argument)/second
linux-2.5.49           60.00       10231   170.51667       87304533.33 
linux-2.5.50           60.01       10231   170.48825       87289985.00 


30 fun_cal2            Function Calls (2 arguments)/second
linux-2.5.49           60.00       7971    132.85000       68019200.00 
linux-2.5.50           60.00       7968    132.80000       67993600.00


31 fun_cal15           Function Calls (15 arguments)/second
linux-2.5.49           60.03       2455    40.89622        20938863.90 
linux-2.5.50           60.02       2455    40.90303        20942352.55 


32 sieve               Integer Sieves/second
linux-2.5.49           60.51       41      0.67757         3.39 
linux-2.5.50           60.61       41      0.67646         3.38


33 mul_double          Thousand Double Precision Multiplies/second
linux-2.5.49           60.04       835     13.90740        166888.74 
linux-2.5.50           60.05       837     13.93838        167260.62


34 mul_float           Thousand Single Precision Multiplies/second
linux-2.5.49           60.04       836     13.92405        167088.61 
linux-2.5.50           60.06       837     13.93606        167232.77


35 mul_long            Thousand Long Integer Multiplies/second
linux-2.5.49           60.00       75690   1261.50000      302760.00 
linux-2.5.50           60.00       75683   1261.38333      302732.00


36 mul_int             Thousand Integer Multiplies/second
linux-2.5.49           60.00       76004   1266.73333      304016.00 
linux-2.5.50           60.00       76000   1266.66667      304000.00


37 mul_short           Thousand Short Integer Multiplies/second
linux-2.5.49           60.00       60559   1009.31667      302795.00 
linux-2.5.50           60.00       60555   1009.25000      302775.00 


38 num_rtns_1          Numeric Functions/second
linux-2.5.49           60.00       32597   543.28333       54328.33 
linux-2.5.50           60.00       32602   543.36667       54336.67


39 new_raph            Zeros Found/second
linux-2.5.49           60.00       79902   1331.70000      266340.00 
linux-2.5.50           60.00       79902   1331.70000      266340.00


40 trig_rtns           Trigonometric Functions/second
linux-2.5.49           60.01       2167    36.11065        361106.48 
linux-2.5.50           60.02       2171    36.17128        361712.76 


41 matrix_rtns         Point Transformations/second
linux-2.5.49           60.00       349544  5825.73333      582573.33 
linux-2.5.50           60.00       349545  5825.75000      582575.00 


42 array_rtns          Linear Systems Solved/second
linux-2.5.49           60.06       960     15.98402        319.68 
linux-2.5.50           60.04       960     15.98934        319.79 


43 string_rtns         String Manipulations/second
linux-2.5.49           60.01       851     14.18097        1418.10 
linux-2.5.50           60.05       852     14.18818        1418.82


44 mem_rtns_1          Dynamic Memory Operations/second
linux-2.5.49           60.02       1705    28.40720        852215.93 
linux-2.5.50           60.02       1901    31.67278        950183.27


45 mem_rtns_2          Block Memory Operations/second
linux-2.5.49           60.00       131049  2184.15000      218415.00 
linux-2.5.50           60.00       131060  2184.33333      218433.33


46 sort_rtns_1         Sort Operations/second
linux-2.5.49           60.01       2424    40.39327        403.93 
linux-2.5.50           60.01       2425    40.40993        404.10


47 misc_rtns_1         Auxiliary Loops/second
linux-2.5.49           60.00       31126   518.76667       5187.67 
linux-2.5.50           60.00       30013   500.21667       5002.17 

48 dir_rtns_1          Directory Operations/second
linux-2.5.49           60.01       8810    146.80887       1468088.65 
linux-2.5.50           60.01       8772    146.17564       1461756.37


49 shell_rtns_1        Shell Scripts/second
linux-2.5.49           60.02       2446    40.75308        40.75 
linux-2.5.50           60.01       2464    41.05982        41.06 


50 shell_rtns_2        Shell Scripts/second
linux-2.5.49           60.02       2454    40.88637        40.89 
linux-2.5.50           60.02       2465    41.06964        41.07 


51 shell_rtns_3        Shell Scripts/second
linux-2.5.49           60.02       2454    40.88637        40.89 
linux-2.5.50           60.02       2464    41.05298        41.05


52 series_1            Series Evaluations/second
linux-2.5.49           60.00      1464217  24403.61667     2440361.67 
linux-2.5.50           60.00      1464215  24403.58333     2440358.33


53 shared_memory       Shared Memory Operations/second
linux-2.5.49           60.00      154841   2580.68333      258068.33 
linux-2.5.50           60.00      157628   2627.13333      262713.33


54 tcp_test            TCP/IP Messages/second
linux-2.5.49           60.00      11032    183.86667       16548.00 
linux-2.5.50           60.00      11063    184.38333       16594.50


55 udp_test            UDP/IP DataGrams/second
linux-2.5.49           60.00      46444    774.06667       77406.67 
linux-2.5.50           60.00      47577    792.95000       79295.00


56 fifo_test           FIFO Messages/second
linux-2.5.49           60.00      83959    1399.31667      139931.67 
linux-2.5.50           60.00      91304    1521.73333      152173.33


57 stream_pipe         Stream Pipe Messages/second
linux-2.5.49           60.00      69034    1150.56667      115056.67 
linux-2.5.50           60.00      69939    1165.65000      116565.00


58 dgram_pipe          DataGram Pipe Messages/second
linux-2.5.49           60.00      67150    1119.16667      111916.67 
linux-2.5.50           60.00      68568    1142.80000      114280.00


59 pipe_cpy            Pipe Messages/second
linux-2.5.49           60.00      246488   4108.13333      410813.33 
linux-2.5.50           60.00      241821   4030.35000      403035.00 


60 ram_copy            Memory to Memory Copy/second
linux-2.5.49            60.00     1495904  24931.73333     623791968.00 
linux-2.5.50            60.00     1495548  24925.80000     623643516.00
------------------------------------------------------------------------

Sowmya Adiga
Project Engineer
Wipro Technologies
53/1, Hosur road, Madivala
Bangalore - 68.
sowmya.adiga@wipro.com
Phone Off: +91-80-5502001-8 extn: 5086.
------------------------------------------------------------------------
   

