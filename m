Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264839AbSL0IXk>; Fri, 27 Dec 2002 03:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264844AbSL0IXj>; Fri, 27 Dec 2002 03:23:39 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:13483 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S264839AbSL0IXg>; Fri, 27 Dec 2002 03:23:36 -0500
From: "Sowmya Adiga" <sowmya.adiga@wipro.com>
To: <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK]AIM benchmark result for kernel 2.5.53mm1.
Date: Fri, 27 Dec 2002 14:01:38 +0530
Organization: Wipro Technologies
Message-ID: <000e01c2ad82$60088500$6009720a@wipro.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
x-mimeole: Produced By Microsoft MimeOLE V6.00.2462.0000
Importance: Normal
X-OriginalArrivalTime: 27 Dec 2002 08:31:38.0687 (UTC) FILETIME=[5FF264F0:01C2AD82]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

   Here are the AIM benchmark result for kernel 2.5.53mm1.Kernel
2.5.53mm1 when compared with kernel 2.5.53 showed difference of
performance in following tests:-
========================================================================
==
 Test Test     Elapsed     Iteration    Iteration        Operation
NumberName     Time (sec)    Count      Rate (loops/sec) Rate (ops/sec)
------------------------------------------------------------------------
1 Signal Traps/second
  signal_test
[2.5.53mm1]    60.00        9904        165.06667          165066.67 
[2.5.53]       60.01        9277        154.59090          154590.90

2 Task Creations/second
  fork_test    
[2.5.53mm1]    60.01        1091        18.18030           1818.03
[2.5.53]       60.02        1148        19.12696           1912.70

3 Dynamic Memory Operations/second
  mem_rtns_1   
[2.5.53mm1]    60.01        1796        29.92835           897850.36 
[2.5.53]       60.00        1643        27.38333           821500.00 

4 FIFO Messages/second
  fifo_test    
[2.5.53mm1]    60.00        86324       1438.73333         143873.33
[2.5.53]       60.00        92619       1543.65000         154365.00

========================================================================
*There is no much significant difference in other test result.

------------------------------------------------------------------------
---
				kernel 2.5.53mm1
------------------------------------------------------------------------
----
Machine's name                                    : access1
Machine's configuration                           : PIII/868MHZ/128MB
Number of seconds to run each test [2 to 1000]    : 60
Path to disk files                                : /tmp


------------------------------------------------------------------------
----
TestTest     Elapsed     Iteration    Iteration           Operation
NumberName   Time (sec)   Count       Rate (loops/sec)    Rate (ops/sec)
------------------------------------------------------------------------
----
1 add_double    60.02        716         11.92936           214728.42
Thousand Double Precision Additions/second

2 add_float     60.05        1075        17.90175           214820.98
Thousand Single Precision Additions/second

3 add_long      60.01        1768        29.46176           1767705.38
Thousand Long Integer Additions/second

4 add_int       60.03        1768        29.45194           1767116.44
Thousand Integer Additions/second

5 add_short     60.00        4419        73.65000           1767600.00
Thousand Short Integer Additions/second

6 creat-clo     60.00        2155        35.91667           35916.67 
File Creations and Closes/second

7 page_test     60.00        8762        146.03333          248256.67
System Allocations & Pages/second

8 brk_test      60.00        3342        55.70000           946900.00
System Memory Allocations/second

9 jmp_test      60.00        318151      5302.51667         5302516.67
Non-local gotos/second

10 signal_test  60.00        9904        165.06667          165066.67 
Signal Traps/second

11 exec_test    60.00        2047        34.11667           170.58
Program Loads/second

12 fork_test    60.01        1091        18.18030           1818.03
Task Creations/second

13 link_test    60.00        9326        155.43333          9792.30
Link/Unlink Pairs/second

14 disk_rr      60.03        487         8.11261            41536.57 
Random Disk Reads (K)/second

15 disk_rw      60.07        382         6.35925            32559.35 
Random Disk Writes (K)/second

16 disk_rd      60.01        2797        46.60890           238637.56
Sequential Disk Reads (K)/second

17 disk_wrt     60.03        626         10.42812           53391.97
Sequential Disk Writes (K)/second

18 disk_cp      60.11        493         8.20163            41992.35 
Disk Copies (K)/second

19sync_disk_rw  61.38        1           0.01629            41.71 
Sync Random Disk Writes (K)/second

20sync_disk_wrt 76.44        2           0.02616            66.98
Sync Sequential Disk Writes (K)/second

21 sync_disk_cp 77.71        2           0.02574            65.89 
Sync Disk Copies (K)/second

22 disk_src     60.00        10736       178.93333          13420.00
Directory Searches/second

23 div_double   60.01        1322        22.02966           66088.99
Thousand Double Precision Divides/second

24 div_float    60.03        1322        22.02232           66066.97
Thousand Single Precision Divides/second

25 div_long     60.03        1592        26.52007           23868.07
Thousand Long Integer Divides/second

26 div_int      60.03        1592        26.52007           23868.07
Thousand Integer Divides/second

27 div_short    60.03        1592        26.52007           23868.07
Thousand Short Integer Divides/second

28 fun_cal      60.00        4362        72.70000           37222400.00
Function Calls (no arguments)/second

29 fun_cal1     60.00        10230       170.50000          87296000.00
Function Calls (1 argument)/second

30 fun_cal2     60.01        7971        132.82786          68007865.36
Function Calls (2 arguments)/second

31 fun_cal15    60.02        2455        40.90303           20942352.55
Function Calls (15 arguments)/second

32 sieve        60.65        41          0.67601            3.38 
Integer Sieves/second

33 mul_double   60.03        834         13.89305           166716.64
Thousand Double Precision Multiplies/second

34 mul_float    60.06        836         13.91941           167032.97
Thousand Single Precision Multiplies/second

35 mul_long     60.00        75674       1261.23333         302696.00
Thousand Long Integer Multiplies/second

36 mul_int      60.00        75997       1266.61667         303988.00
Thousand Integer Multiplies/second

37 mul_short    60.00        60551       1009.18333         302755.00
Thousand Short Integer Multiplies/second

38 num_rtns_1   60.00        32598       543.30000          54330.00
Numeric Functions/second

39 new_raph     60.00        79893       1331.55000         266310.00 
Zeros Found/second

40 trig_rtns    60.00        2167        36.11667           361166.67
Trigonometric Functions/second

41 matrix_rtns  60.00        349544      5825.73333         582573.33
Point Transformations/second

42 array_rtns   60.06        941         15.66767           313.35
Linear Systems Solved/second

43 string_rtns  60.03        851         14.17625           1417.62
String Manipulations/second

44 mem_rtns_1   60.01        1796        29.92835           897850.36
Dynamic Memory Operations/second

45 mem_rtns_2   60.00        131034      2183.90000         218390.00
Block Memory Operations/second

46 sort_rtns_1  60.02        2425        40.40320           404.03
Sort Operations/second

47 misc_rtns_1  60.00        32272       537.86667          5378.67
Auxiliary Loops/second

48 dir_rtns_1   60.00        13161       219.35000          2193500.00
Directory Operations/second

49 shell_rtns_1 60.02        2374        39.55348           39.55
Shell Scripts/second

50 shell_rtns_2 60.02        2386        39.75342           39.75
Shell Scripts/second

51 shell_rtns_3 60.00        2392        39.86667           39.87
Shell Scripts/second

52 series_1     60.00        1464193     24403.21667        2440321.67
Series Evaluations/second

53shared_memory 60.00        163308      2721.80000         272180.00
Shared Memory Operations/second

54 tcp_test     60.00        10829       180.48333          16243.50 
TCP/IP Messages/second

55 udp_test     60.00        46204       770.06667          77006.67
UDP/IP DataGrams/second

56 fifo_test    60.00        86324       1438.73333         143873.33
FIFO Messages/second

57 stream_pipe  60.00        69778       1162.96667         116296.67 
Stream Pipe Messages/second

58 dgram_pipe   60.00        66385       1106.41667         110641.67
DataGram Pipe Messages/second

59 pipe_cpy     60.00        249004      4150.06667         415006.67 
Pipe Messages/second

60 ram_copy     60.00        1495468     24924.46667        623610156.00
Memory to Memory Copy/second
------------------------------------------------------------------------
---
Regards
 
Sowmya Adiga
Project Engineer
Wipro Technologies
53/1,Hosur Road,Madivala
Bangalore-560 068,INDIA
Tel: +91-80-5502001 Extn.5086
sowmya.adiga@wipro.com

