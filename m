Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267715AbSLTDui>; Thu, 19 Dec 2002 22:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267717AbSLTDui>; Thu, 19 Dec 2002 22:50:38 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:25516 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S267715AbSLTDuf>; Thu, 19 Dec 2002 22:50:35 -0500
From: "Sowmya Adiga" <sowmya.adiga@wipro.com>
To: <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK]AIM benchmark result for kernel 2.5.52 with mm2 patch
Date: Fri, 20 Dec 2002 09:28:23 +0530
Organization: Wipro Technologies
Message-ID: <000701c2a7dc$0a8901f0$6009720a@wipro.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
x-mimeole: Produced By Microsoft MimeOLE V6.00.2462.0000
Importance: Normal
X-OriginalArrivalTime: 20 Dec 2002 03:58:24.0003 (UTC) FILETIME=[0B0FE530:01C2A7DC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are the AIM benchmark result for kernel 2.5.52 with mm2 patch.
Kernel 2.5.52 with mm2 patch when compared with kernel 2.5.52 showed
difference of performance in following tests:-
========================================================================
===
 Test Test     Elapsed     Iteration    Iteration        Operation
NumberName     Time (sec)    Count      Rate (loops/sec) Rate (ops/sec)
------------------------------------------------------------------------
----                                                   
1 System Memory Allocations/second
brk_test[2.5.52]   60.00   3365        56.08333         953416.67

brk_test[2.5.52mm2]60.00   3308        55.13333         937266.67

2 Sequential Disk Writes (K)/second
disk_wrt[2.5.52]   60.03   648         10.79460         55268.37
disk_wrt[2.5.52mm2]60.09   608         10.11816         51804.96

3 Disk Copies (K)/second
disk_cp[2.5.52]    60.09   517         8.60376          44051.26
disk_cp[2.5.52mm2] 60.04   490         8.16123          41785.48 

4 Dynamic Memory Operations/second
mem_rtns_1[2.5.52]   60.01  1617       26.94551         808365.27
mem_rtns_1[2.5.52mm2]60.01  1826       30.42826         912847.86
========================================================================
==
*There is no much significant difference in other test result.




------------------------------------------------------------------------
----              
                        kernel 2.5.52 with mm2 patch
------------------------------------------------------------------------
----

Machine's name                                    : access1
Machine's configuration                           : PIII/868MHZ/128MB
Number of seconds to run each test [2 to 1000]    : 60
Path to disk files                                : /tmp


------------------------------------------------------------------------
---
 Test Test     Elapsed     Iteration    Iteration        Operation
NumberName     Time (sec)    Count      Rate (loops/sec) Rate (ops/sec)
------------------------------------------------------------------------
----
1 add_double    60.02       716        11.92936         214728.42 
Thousand Double Precision Additions/second

2 add_float     60.00       1074       17.90000         214800.00 
Thousand Single Precision Additions/second

3 add_long      60.01       1768       29.46176         1767705.38
Thousand Long Integer Additions/second

4 add_int       60.02       1768       29.45685         1767410.86
Thousand Integer Additions/second

5 add_short     60.00       4419       73.65000         1767600.00
Thousand Short Integer Additions/second

6 creat-clo     60.03       2135       35.56555         35565.55 
File Creations and Closes/second

7 page_test     60.00       8659       144.31667        245338.33
System Allocations & Pages/second

8 brk_test      60.00       3308       55.13333         937266.67
System Memory Allocations/second

9 jmp_test      60.00       318157     5302.61667       5302616.67
Non-local gotos/second

10 signal_test  60.00       9828       163.80000        163800.00
Signal Traps/second

11 exec_test    60.03       2047       34.09962         170.50 
Program Loads/second

12 fork_test    60.01       1141       19.01350         1901.35
Task Creations/second

13 link_test    60.00       9817       163.61667        10307.85
Link/Unlink Pairs/second

14 disk_rr      60.02       474        7.89737          40434.52
Random Disk Reads (K)/second

15 disk_rw      60.08       369        6.14181          31446.07 
Random Disk Writes (K)/second

16 disk_rd      60.01       2819       46.97550         240514.58
Sequential Disk Reads (K)/second

17 disk_wrt     60.09       608        10.11816         51804.96
Sequential Disk Writes (K)/second

18 disk_cp      60.04       490        8.16123          41785.48 
Disk Copies (K)/second

19 sync_disk_rw 60.26       1          0.01659          42.48
Sync Random Disk Writes (K)/second

20 sync_disk_wrt 76.69      2          0.02608          66.76
Sync Sequential Disk Writes (K)/second

21 sync_disk_cp  76.71      2          0.02607          66.74 
Sync Disk Copies (K)/second

22 disk_src      60.00      10623      177.05000        13278.75 
Directory Searches/second

23 div_double    60.01      1322       22.02966         66088.99 
Thousand Double Precision Divides/second

24 div_float     60.01      1322       22.02966         66088.99
Thousand Single Precision Divides/second

25 div_long      60.03      1592       26.52007         23868.07 
Thousand Long Integer Divides/second

26 div_int       60.03      1592       26.52007         23868.07 
Thousand Integer Divides/second

27 div_short     60.02      1591       26.50783         23857.05 
Thousand Short Integer Divides/second

28 fun_cal       60.00      4362       72.70000         37222400.00
Function Calls (no arguments)/second

29 fun_cal1      60.01      10230      170.47159        87281453.09
Function Calls (1 argument)/second

30 fun_cal2      60.00      7970       132.83333        68010666.67 
Function Calls (2 arguments)/second

31 fun_cal15     60.02      2455       40.90303         20942352.55
Function Calls (15 arguments)/second

32 sieve         60.28      41         0.68016          3.40
Integer Sieves/second

33 mul_double    60.03      838        13.95969         167516.24
Thousand Double Precision Multiplies/second

34 mul_float     60.06      837        13.93606         167232.77
Thousand Single Precision Multiplies/second

35 mul_long      60.00      75693      1261.55000       302772.00
Thousand Long Integer Multiplies/second

36 mul_int       60.00      75999      1266.65000       303996.00
Thousand Integer Multiplies/second

37 mul_short     60.00      60533      1008.88333       302665.00
Thousand Short Integer Multiplies/second

38 num_rtns_1    60.00      32604       543.40000       54340.00 
Numeric Functions/second

39 new_raph      60.00      79903       1331.71667      266343.33 
Zeros Found/second

40 trig_rtns     60.03      2168        36.11528        361152.76
Trigonometric Functions/second

41 matrix_rtns   60.00      349550      5825.83333      582583.33 
Point Transformations/second

42 array_rtns    60.06      959         15.96737        319.35 
Linear Systems Solved/second

43 string_rtns   60.06      852         14.18581        1418.58
String Manipulations/second

44 mem_rtns_1    60.01      1826        30.42826        912847.86
Dynamic Memory Operations/second

45 mem_rtns_2    60.00      131042      2184.03333      218403.33 
Block Memory Operations/second

46 sort_rtns_1   60.02      2426        40.41986        404.20 
Sort Operations/second

47 misc_rtns_1   60.00      32127       535.45000       5354.50 
Auxiliary Loops/second

48 dir_rtns_1    60.01      13168       219.43009       2194300.95 
Directory Operations/second

49 shell_rtns_1  60.01       2400       39.99333        39.99 
Shell Scripts/second

50 shell_rtns_2  60.01       2403       40.04333        40.04
Shell Scripts/second

51 shell_rtns_3  60.01       2403       40.04333        40.04
Shell Scripts/second

52 series_1      60.00       1464228    24403.80000     2440380.00
Series Evaluations/second

53 shared_memory  60.00      163393     2723.21667      272321.67
Shared Memory Operations/second

54 tcp_test       60.00      10996      183.26667       16494.00 
TCP/IP Messages/second

55 udp_test       60.00      46736      778.93333       77893.33 
UDP/IP DataGrams/second

56 fifo_test      60.00      88065      1467.75000      146775.00
FIFO Messages/second

57 stream_pipe    60.00      69669      1161.15000      116115.00 
Stream Pipe Messages/second

58 dgram_pipe     60.00      65903      1098.38333      109838.33 
DataGram Pipe Messages/second

59 pipe_cpy       60.00      254365     4239.41667      423941.67
Pipe Messages/second

60 ram_copy       60.00      1496042    24934.03333     623849514.00
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
 
 

