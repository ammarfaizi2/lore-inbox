Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267980AbTAMGy0>; Mon, 13 Jan 2003 01:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267983AbTAMGy0>; Mon, 13 Jan 2003 01:54:26 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:14041 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S267980AbTAMGyW>; Mon, 13 Jan 2003 01:54:22 -0500
From: "Sowmya Adiga" <sowmya.adiga@wipro.com>
To: <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK]AIM benchmark result for kernel 2.5.56
Date: Mon, 13 Jan 2003 12:32:59 +0530
Message-ID: <00e101c2bad1$ce5fc7f0$6009720a@wipro.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Importance: Normal
X-OriginalArrivalTime: 13 Jan 2003 07:02:59.0123 (UTC) FILETIME=[CE431830:01C2BAD1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 Here are the AIM benchmark result for kernel 2.5.56.Kernel 2.5.56 when
compared with kernel 2.5.55 showed difference of performance in
following tests:- 
Kernel 2.5.56 showed poor performance in Dynamic memory operations

========================================================================

Test        Elapsed      Iteration    Iteration        Operation
Name        Time (sec)   Count        Rate(loops/sec)  Rate (ops/sec)
------------------------------------------------------------------------
1 System Memory Allocations/second
 brk_test     
 [2.5.56]    60.01        3483         58.04033         986685.55 
 [2.5.55]    60.02        3417         56.93102         967827.39

2 Dynamic Memory Operations/second
 mem_rtns_1   
 [2.5.56]    60.00        1707         28.45000         853500.00 
 [2.5.55]    60.01        1838         30.62823         918846.86
========================================================================
*There is no much significant difference in other test result.

	
------------------------------------------------------------------------
----
					kernel-2.5.56
------------------------------------------------------------------------
----
Machine's name                                    : access1
Machine's configuration                           : PIII/868MHZ/128MB
Number of seconds to run each test [2 to 1000]    : 60
Path to disk files                                : /tmp 

------------------------------------------------------------------------
----
 TestTest      Elapsed      Iteration    Iteration         Operation
NumberName     Time (sec)   Count        Rate (loops/sec)  Rate
(ops/sec)
------------------------------------------------------------------------
----
1 add_double    60.01        716          11.93134         214764.21 
Thousand Double Precision Additions/second

2 add_float     60.05        1075         17.90175         214820.98
Thousand Single Precision Additions/second

3 add_long      60.01        1768         29.46176         1767705.38
Thousand Long Integer Additions/second

4 add_int       60.01        1768         29.46176         1767705.38
Thousand Integer Additions/second

5 add_short     60.02        4418         73.60880         1766611.13
Thousand Short Integer Additions/second

6 creat-clo     60.02        2161         36.00467         36004.67 
File Creations and Closes/second

7 page_test     60.00        8494         141.56667        240663.33 
System Allocations & Pages/second

8 brk_test      60.01        3483         58.04033         986685.55 
System Memory Allocations/second

9 jmp_test      60.00        318209       5303.48333       5303483.33
Non-local gotos/second

10 signal_test  60.00        9972         166.20000        166200.00 
Signal Traps/second

11 exec_test    60.00        2064         34.40000         172.00
Program Loads/second

12 fork_test    60.04        1112         18.52099         1852.10 
Task Creations/second

13 link_test    60.00        10097        168.28333        10601.85
Link/Unlink Pairs/second

14 disk_rr      60.10        488          8.11980          41573.38
Random Disk Reads (K)/second

15 disk_rw      60.10        387          6.43927          32969.05 
Random Disk Writes (K)/second

16 disk_rd      60.02        2830         47.15095         241412.86
Sequential Disk Reads (K)/second

17 disk_wrt     60.02        617          10.27991         52633.12
Sequential Disk Writes (K)/second

18 disk_cp      60.11        486          8.08518          41396.11 
Disk Copies (K)/second 

19sync_disk_rw  60.52        1            0.01652          42.30 
Sync Random Disk Writes (K)/second

20sync_disk_wrt 76.05        2            0.02630          67.32
Sync Sequential Disk Writes (K)/second

21sync_disk_cp  77.48        2            0.02581          66.08 
Sync Disk Copies (K)/second

22 disk_src     60.01        10699        178.28695        13371.52
Directory Searches/second

23 div_double   60.00        1322         22.03333         66100.00 
Thousand Double Precision Divides/second

24 div_float    60.00        1322         22.03333         66100.00 
Thousand Single Precision Divides/second

25 div_long     60.01        1591         26.51225         23861.02 
Thousand Long Integer Divides/second

26 div_int      60.03        1592         26.52007         23868.07 
Thousand Integer Divides/second

27 div_short    60.03        1592         26.52007         23868.07
Thousand Short Integer Divides/second

28 fun_cal      60.00        4362         72.70000         37222400.00
Function Calls (no arguments)/second

29 fun_cal1     60.00        10230        170.50000        87296000.00
Function Calls (1 argument)/second

30 fun_cal2     60.01        7971         132.82786        68007865.36
Function Calls (2 arguments)/second

31 fun_cal15    60.02        2455         40.90303         20942352.55
Function Calls (15 arguments)/second

32 sieve        60.54        41           0.67724          3.39 
Integer Sieves/second

33 mul_double   60.06        837          13.93606         167232.77
Thousand Double Precision Multiplies/second

34 mul_float    60.00        833          13.88333         166600.00
Thousand Single Precision Multiplies/second

35 mul_long     60.00        75697        1261.61667       302788.00
Thousand Long Integer Multiplies/second

36 mul_int      60.00        76023        1267.05000       304092.00
Thousand Integer Multiplies/second

37 mul_short    60.00        60563        1009.38333       302815.00
Thousand Short Integer Multiplies/second

38 num_rtns_1   60.00        32608        543.46667        54346.67
Numeric Functions/second

39 new_raph     60.00        79914        1331.90000       266380.00 
Zeros Found/second

40 trig_rtns    60.02        2163         36.03799         360379.87
Trigonometric Functions/second

41 matrix_rtns  60.00        349593       5826.55000       582655.00 
Point Transformations/second

42 array_rtns   60.04        959          15.97268         319.45
Linear Systems Solved/second

43 string_rtns  60.01        851          14.18097         1418.10 
String Manipulations/second

44 mem_rtns_1   60.00        1707         28.45000         853500.00 
Dynamic Memory Operations/second

45 mem_rtns_2   60.00        131019       2183.65000       218365.00
Block Memory Operations/second

46 sort_rtns_1  60.01        2425         40.40993         404.10 
Sort Operations/second

47 misc_rtns_1  60.00        31786        529.76667        5297.67
Auxiliary Loops/second

48 dir_rtns_1   60.01        13082        217.99700        2179970.00
Directory Operations/second

49 shell_rtns_1 60.00        2557         42.61667         42.62 
Shell Scripts/second

50 shell_rtns_2 60.02        2565         42.73575         42.74 
Shell Scripts/second

51 shell_rtns_3 60.00        2567         42.78333         42.78
Shell Scripts/second

52 series_1     60.00        1464518      24408.63333      2440863.33 
Series Evaluations/second

53shared_memory 60.00        164960       2749.33333       274933.33 
Shared Memory Operations/second

54 tcp_test     60.00        15798        263.30000        23697.00 
TCP/IP Messages/second

55 udp_test     60.00        49019        816.98333        81698.33 
UDP/IP DataGrams/second

56 fifo_test    60.00        88304        1471.73333       147173.33 
FIFO Messages/second

57 stream_pipe  60.00        75192        1253.20000       125320.00 
Stream Pipe Messages/second

58 dgram_pipe   60.00        73650        1227.50000       122750.00
DataGram Pipe Messages/second

59 pipe_cpy     60.00        251474       4191.23333       419123.33 
Pipe Messages/second

60 ram_copy     60.00        1496414      24940.23333      624004638.00
Memory to Memory Copy/second
------------------------------------------------------------------------
----
Regards
 
Sowmya Adiga
Project Engineer
Wipro Technologies
53/1,Hosur Road,Madivala
Bangalore-560 068,INDIA
Tel: +91-80-5502001 Extn.5086
sowmya.adiga@wipro.com

