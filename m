Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268030AbTBMNBG>; Thu, 13 Feb 2003 08:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268031AbTBMNBG>; Thu, 13 Feb 2003 08:01:06 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:9111 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S268030AbTBMNBC>; Thu, 13 Feb 2003 08:01:02 -0500
From: "Sowmya Adiga" <sowmya.adiga@wipro.com>
To: <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK]AIM9 benchmark result for kernel 2.5.60.
Date: Thu, 13 Feb 2003 18:40:35 +0530
Message-ID: <003901c2d361$4bd2f480$6009720a@wipro.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Importance: Normal
X-OriginalArrivalTime: 13 Feb 2003 13:10:35.0935 (UTC) FILETIME=[4BF3C2F0:01C2D361]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 Here are the AIM9 benchmark result for kernel 2.5.60.when compared with
kernel 2.5.59 showed difference in system memory allocations/second.

========================================================================

 Test         Elapsed      Iteration    Iteration        Operation
 Name         Time (sec)   Count        Rate(loops/sec)  Rate (ops/sec)
------------------------------------------------------------------------
1.System Memory Allocations/second
brk_test           
[linux-2.5.59]  60.00       2661        44.35000        753950.00 
[linux-2.5.60]  60.01       2481        41.34311        702832.86 
========================================================================
*There is no much significant difference in other test result.

------------------------------------------------------------------------
----
					linux-2.5.60
------------------------------------------------------------------------
----
 
Machine's name                                    : access1
Machine's configuration                           : PIII/868MHZ/128MB
Number of seconds to run each test [2 to 1000]    : 60
Path to disk files                                : /tmp 


------------------------------------------------------------------------
----
 TestTest      Elapsed       Iteration   Iteration         Operation
NumberName     Time (sec)    Count       Rate (loops/sec)  Rate(ops/sec)
------------------------------------------------------------------------
----
1 add_double    60.07         716         11.91943         214549.69
Thousand Double Precision Additions/second

2 add_float     60.00         1073        17.88333         214600.00
Thousand Single Precision Additions/second

3 add_long      60.00         1766        29.43333         1766000.00
Thousand Long Integer Additions/second

4 add_int       60.04         1767        29.43038         1765822.78
Thousand Integer Additions/second

5 add_short     60.00         4415        73.58333         1766000.00
Thousand Short Integer Additions/second

6 creat-clo     60.01         5706        95.08415         95084.15 
File Creations and Closes/second

7 page_test     60.01         6834        113.88102        193597.73 
System Allocations & Pages/second

8 brk_test      60.01         2481        41.34311         702832.86 
System Memory Allocations/second

9 jmp_test      60.00         322013      5366.88333       5366883.33 
Non-local gotos/second

10 signal_test  60.00         11195       186.58333        186583.33 
Signal Traps/second

11 exec_test    60.02         2705        45.06831         225.34 
Program Loads/second

12 fork_test    60.02         1243        20.70976         2070.98 
Task Creations/second

13 link_test    60.00         28909       481.81667        30354.45
Link/Unlink Pairs/second

14 disk_rr      60.04         443         7.37841          37777.48
Random Disk Reads (K)/second

15 disk_rw      60.15         361         6.00166          30728.51 
Random Disk Writes (K)/second

16 disk_rd      60.02         2551        42.50250         217612.80
Sequential Disk Reads (K)/second

17 disk_wrt     60.03         565         9.41196          48189.24
Sequential Disk Writes (K)/second

18 disk_cp      60.11         451         7.50291          38414.91 
Disk Copies (K)/second

19sync_disk_rw  92.97          2          0.02151          55.07 
Sync Random Disk Writes (K)/second

20sync_disk_wrt 68.65          2          0.02913          74.58 
Sync Sequential Disk Writes (K)/second

21sync_disk_cp  68.59          2          0.02916          74.65
Sync Disk Copies (K)/second

22 disk_src     60.01          18506      308.38194        23128.65
Directory Searches/second

23 div_double   60.01          1321       22.01300         66038.99 
Thousand Double Precision Divides/second

24 div_float    60.02          1321       22.00933         66027.99 
Thousand Single Precision Divides/second

25 div_long     60.01          1590       26.49558         23846.03 
Thousand Long Integer Divides/second

26 div_int      60.01          1590       26.49558         23846.03 
Thousand Integer Divides/second

27 div_short    60.02          1590       26.49117         23842.05 
Thousand Short Integer Divides/second

28 fun_cal      60.01          4713       78.53691         40210898.18
Function Calls (no arguments)/second

29 fun_cal1     60.00          10333      172.21667        88174933.33
Function Calls (1 argument)/second

30 fun_cal2     60.00          7492       124.86667        63931733.33
Function Calls (2 arguments)/second

31 fun_cal15    60.02          2452       40.85305         20916761.08
Function Calls (15 arguments)/second

32 sieve        60.73          41         0.67512          3.38 
Integer Sieves/second

33 mul_double   60.01          835        13.91435         166972.17
Thousand Double Precision Multiplies/second

34 mul_float    60.01          835        13.91435         166972.17
Thousand Single Precision Multiplies/second

35 mul_long     60.00          75792      1263.20000       303168.00
Thousand Long Integer Multiplies/second

36 mul_int      60.00          75661      1261.01667       302644.00
Thousand Integer Multiplies/second

37 mul_short    60.00          60612      1010.20000       303060.00
Thousand Short Integer Multiplies/second

38 num_rtns_1   60.00          36683      611.38333        61138.33 
Numeric Functions/second

39 new_raph     60.00          82840      1380.66667       276133.33 
Zeros Found/second

40 trig_rtns    60.01          2210       36.82720         368271.95
Trigonometric Functions/second

41 matrix_rtns  60.00          366577     6109.61667       610961.67 
Point Transformations/second

42 array_rtns   60.02          1002       16.69444         333.89 
Linear Systems Solved/second

43 string_rtns  60.07          532        8.85633          885.63 
String Manipulations/second

44 mem_rtns_1   60.02          2853       47.53416         1426024.66
Dynamic Memory Operations/second

45 mem_rtns_2   60.00          131065     2184.41667       218441.67 
Block Memory Operations/second

46 sort_rtns_1  60.00          2505       41.75000         417.50 
Sort Operations/second

47 misc_rtns_1  60.01          49967      832.64456        8326.45 
Auxiliary Loops/second

48 dir_rtns_1   60.00          11899      198.31667        1983166.67
Directory Operations/second

49 shell_rtns_1 60.01          3211       53.50775         53.51 
Shell Scripts/second

50 shell_rtns_2 60.00          3224       53.73333         53.73 
Shell Scripts/second

51 shell_rtns_3 60.01          3231       53.84103         53.84 
Shell Scripts/second

52 series_1     60.00          1470643    24510.71667      2451071.67 
Series Evaluations/second

53shared_memory 60.00          153576     2559.60000       255960.00 
Shared Memory Operations/second

54 tcp_test     60.00          29314      488.56667        43971.00 
TCP/IP Messages/second

55 udp_test     60.00          65248      1087.46667       108746.67 
UDP/IP DataGrams/second

56 fifo_test    60.00          84788      1413.13333       141313.33 
FIFO Messages/second

57 stream_pipe  60.00          136492     2274.86667       227486.67 
Stream Pipe Messages/second

58 dgram_pipe   60.00          134249     2237.48333       223748.33
DataGram Pipe Messages/second

59 pipe_cpy     60.00          186996     3116.60000       311660.00
Pipe Messages/second

60 ram_copy     60.00          1553370    25889.50000      647755290.00
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

