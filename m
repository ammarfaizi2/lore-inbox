Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263800AbTDUKFr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 06:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263801AbTDUKFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 06:05:47 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:55962 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id S263800AbTDUKFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 06:05:42 -0400
Reply-To: <sowmya.adiga@wipro.com>
From: "Sowmya Adiga" <sowmya.adiga@wipro.com>
To: <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK]AIM9 benchmark result for kernel 2.5.68
Date: Mon, 21 Apr 2003 15:47:29 +0530
Organization: Wipro
Message-ID: <014101c307ef$3719ed10$6009720a@wipro.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Importance: Normal
X-OriginalArrivalTime: 21 Apr 2003 10:17:29.0946 (UTC) FILETIME=[3718DBA0:01C307EF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	AIM9 benchmark result for kernel 2.5.68.when compared with
kernel 2.5.67 showed following differences. 
========================================================================
 Test          Elapsed      Iteration   Iteration         Operation
 Name          Time(sec)    Count       Rate(loops/sec)   Rate (ops/sec)
------------------------------------------------------------------------
Dynamic Memory Operations/second
mem_rtns_1   
[linux-2.5.68]  60.01        2643        44.04266          1321279.79
[linux-2.5.67]  60.01        2759        45.97567          1379270.12

Directory Operations/second
dir_rtns_1   
[linux-2.5.68]  60.00        16432       273.86667         2738666.67 
[linux-2.5.67]  60.00        16357       272.61667         2726166.67
========================================================================
*There is no much significant difference in other test result.	

------------------------------------------------------------------------
--
					kernel-2.5.68
------------------------------------------------------------------------
--
AIM Independent Resource Benchmark - Suite IX v1.1, January 22, 1996
Copyright (c) 1996 - 2001 Caldera International, Inc.
All Rights Reserved

Machine's name                                    : access1
Machine's configuration                           : PIII/868MHZ/128MB
Number of seconds to run each test [2 to 1000]    : 60
Path to disk files                                : /tmp

------------------------------------------------------------------------
--
Test  Test     Elapsed     Iteration    Iteration          Operation
NumberName     Time(sec)   Count        Rate(loops/sec)    Rate(ops/sec)
------------------------------------------------------------------------
--
1 add_double    60.07        716         11.91943          214549.69
Thousand Double Precision Additions/second

2 add_float     60.01        1073        17.88035          214564.24
Thousand Single Precision Additions/second

3 add_long      60.01        1766        29.42843          1765705.72
Thousand Long Integer Additions/second

4 add_int       60.01        1766        29.42843          1765705.72
Thousand Integer Additions/second

5 add_short     60.00        4414        73.56667          1765600.00
Thousand Short Integer Additions/second

6 creat-clo     60.01        10467       174.42093         174420.93 
File Creations and Closes/second

7 page_test     60.00        7457        124.28333         211281.67
System Allocations & Pages/second

8 brk_test      60.00        3587        59.78333          1016316.67
System Memory Allocations/second

9 jmp_test      60.00        321924      5365.40000        5365400.00
Non-local gotos/second

10 signal_test  60.00        11692       194.86667         194866.67
Signal Traps/second

11 exec_test    60.02        2982        49.68344          248.42 
Program Loads/second

12 fork_test    60.03        1549        25.80376          2580.38 
Task Creations/second

13 link_test    60.00        50325       838.75000         52841.25
Link/Unlink Pairs/second

14 disk_rr      60.07        712         11.85284          60686.53
Random Disk Reads (K)/second

15 disk_rw      60.07        578         9.62211           49265.19 
Random Disk Writes (K)/second

16 disk_rd      60.01        2605        43.40943          222256.29
Sequential Disk Reads (K)/second

17 disk_wrt     60.02        1085        18.07731          92555.81
Sequential Disk Writes (K)/second

18 disk_cp      60.03        770         12.82692          65673.83 
Disk Copies (K)/second

19sync_disk_rw  66.00        4           0.06061           155.15
Sync Random Disk Writes (K)/second

20sync_disk_wrt 65.85        9           0.13667           349.89 
Sync Sequential Disk Writes (K)/second

21 sync_disk_cp 65.52        9           0.13736           351.65 
Sync Disk Copies (K)/second

22 disk_src     60.00        26020       433.66667         32525.00
Directory Searches/second

23 div_double   60.02        1321        22.00933          66027.99
Thousand Double Precision Divides/second

24 div_float    60.02        1321        22.00933          66027.99
Thousand Single Precision Divides/second

25 div_long     60.02        1590        26.49117          23842.05
thousand Long Integer Divides/second

26 div_int      60.02        1590        26.49117          23842.05
Thousand Integer Divides/second

27 div_short    60.03        1590        26.48676          23838.08
Thousand Short Integer Divides/second

28 fun_cal      60.01        4712        78.52025          40202366.27
Function Calls (no arguments)/second

29 fun_cal1     60.00        10332       172.20000         88166400.00
Function Calls (1 argument)/second

30 fun_cal2     60.00        7491        124.85000         63923200.00
Function Calls (2 arguments)/second

31 fun_cal15    60.01        2451        40.84319          20911714.71
Function Calls (15 arguments)/second

32 sieve        60.41        41          0.67870           3.39 
Integer Sieves/second

33 mul_double   60.03        835         13.90971          166916.54
Thousand Double Precision Multiplies/second

34 mul_float    60.02        835         13.91203          166944.35
Thousand Single Precision Multiplies/second

35 mul_long     60.00        75934       1265.56667        303736.00
Thousand Long Integer Multiplies/second

36 mul_int      60.00        75710       1261.83333        302840.00
Thousand Integer Multiplies/second

37 mul_short    60.00        60626       1010.43333        303130.00
Thousand Short Integer Multiplies/second

38 num_rtns_1   60.00        36909       615.15000         61515.00
Numeric Functions/second

39 new_raph     60.00        82821       1380.35000        276070.00 
Zeros Found/second

40 trig_rtns    60.01        2210        36.82720          368271.95
Trigonometric Functions/second

41 matrix_rtns  60.00        366494      6108.23333        610823.33
Point Transformations/second

42 array_rtns   60.03        1002        16.69165          333.83 
Linear Systems Solved/second

43 string_rtns  60.06        532         8.85781           885.78 
String Manipulations/second

44 mem_rtns_1   60.01        2643        44.04266          1321279.79
Dynamic Memory Operations/second

45 mem_rtns_2   60.00        131070      2184.50000        218450.00
Block Memory Operations/second

46 sort_rtns_1  60.01        2505        41.74304          417.43
Sort Operations/second

47 misc_rtns_1  60.00        47982       799.70000         7997.00
Auxiliary Loops/second

48 dir_rtns_1   60.00        16432       273.86667         2738666.67
Directory Operations/second

49shell_rtns_1  60.01        3527        58.77354          58.77
Shell Scripts/second

50 shell_rtns_2 60.01        3526        58.75687          58.76
Shell Scripts/second

51 shell_rtns_3 60.01        3527        58.77354          58.77 
Shell Scripts/second

52 series_1     60.00        1470783     24513.05000       2451305.00
Series Evaluations/second

53shared_memory 60.00        153872      2564.53333        256453.33
Shared Memory Operations/second

54 tcp_test     60.00        35435       590.58333         53152.50 
TCP/IP Messages/second

55 udp_test     60.00        67153       1119.21667        111921.67 
UDP/IP DataGrams/second

56 fifo_test    60.00        164349      2739.15000        273915.00 
FIFO Messages/second

57 stream_pipe  60.00        139901      2331.68333        233168.33 
Stream Pipe Messages/second

58 dgram_pipe   60.00        140712      2345.20000        234520.00
DataGram Pipe Messages/second

59 pipe_cpy     60.00        188291      3138.18333        313818.33 
Pipe Messages/second

60 ram_copy     60.00        1552446     25874.10000       647369982.00
Memory to Memory Copy/second
------------------------------------------------------------------------
--
Regards
 
Sowmya Adiga
Project Engineer
Wipro Technologies
53/1,Hosur Road,Madivala
Bangalore-560 068,INDIA
Tel: +91-80-5502001 Extn.5086

