Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262568AbTEFLa4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 07:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262569AbTEFLa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 07:30:56 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:27532 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id S262568AbTEFLas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 07:30:48 -0400
Reply-To: <sowmya.adiga@wipro.com>
From: "Sowmya Adiga" <sowmya.adiga@wipro.com>
To: <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK]AIM9 benchmark result for kernel 2.5.69
Date: Tue, 6 May 2003 17:13:07 +0530
Organization: Wipro
Message-ID: <008101c313c4$a9531ce0$4e07740a@wipro.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Importance: Normal
X-OriginalArrivalTime: 06 May 2003 11:43:06.0621 (UTC) FILETIME=[A8FD82D0:01C313C4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	AIM9 benchmark result for kernel 2.5.69.when compared with
kernel 2.5.68 showed following differences. 
========================================================================
 Test          Elapsed      Iteration   Iteration         Operation
 Name          Time(sec)    Count       Rate(loops/sec)   Rate (ops/sec)
------------------------------------------------------------------------
System Memory Allocations/second
brk_test      
[linux-2.5.69]  60.02       3393        56.53116          961029.66 
[linux-2.5.68]  60.00       3587        59.78333          1016316.67

Signal Traps/second
signal_test   
[linux-2.5.69]   60.01       11188      186.43559         186435.59 
[linux-2.5.68]   60.00       11692      194.86667         194866.67

Dynamic Memory Operations/second
mem_rtns_1    
[linux-2.5.69]   60.01       2788        46.45892         1393767.71 
[linux-2.5.68]   60.01       2643        44.04266         1321279.79
========================================================================
*There is no much significant difference in other test result.	

------------------------------------------------------------------------
--
				kernel-2.5.69
------------------------------------------------------------------------
--
AIM Independent Resource Benchmark - Suite IX v1.1, January 22, 1996
Copyright (c) 1996 - 2001 Caldera International, Inc. All Rights
Reserved

Machine's name                                    : access1
Machine's configuration                           : PIII/868MHZ/128MB
Number of seconds to run each test [2 to 1000]    : 60
Path to disk files                                : /tmp
------------------------------------------------------------------------
--
Test  Test     Elapsed     Iteration    Iteration         Operation
NumberName     Time(sec)   Count        Rate(loops/sec)   Rate (ops/sec)
------------------------------------------------------------------------
--
1 add_double     60.07       716         11.91943          214549.69
Thousand Double Precision Additions/second

2 add_float      60.06       1074        17.88212          214585.41
Thousand Single Precision Additions/second

3 add_long       60.04       1767        29.43038          1765822.78
Thousand Long Integer Additions/second

4 add_int        60.03       1767        29.43528          1766116.94
Thousand Integer Additions/second

5 add_short      60.01       4415        73.57107          1765705.72
Thousand Short Integer Additions/second

6 creat-clo      60.02       10736       178.87371         178873.71 
File Creations and Closes/second

7 page_test      60.01       7409        123.46276         209886.69
System Allocations & Pages/second

8 brk_test       60.02       3393        56.53116          961029.66
System Memory Allocations/second

9 jmp_test       60.01       322028      5366.23896        5366238.96
Non-local gotos/second

10signal_test    60.01       11188       186.43559         186435.59
Signal Traps/second

11 exec_test     60.02       3018        50.28324          251.42 
Program Loads/second

12 fork_test     60.04       1479        24.63358          2463.36 
Task Creations/second

13 link_test     60.01       52385       872.93784         54995.08
Link/Unlink Pairs/second

14 disk_rr       60.02       721         12.01266          61504.83 
Random Disk Reads (K)/second

15 disk_rw       60.05       585         9.74188           49878.43 
Random Disk Writes (K)/second

16 disk_rd       60.02       2683        44.70177          228873.04
Sequential Disk Reads (K)/second

17 disk_wrt      60.04       1105        18.40440          94230.51
Sequential Disk Writes (K)/second

18 disk_cp       60.08       783         13.03262          66727.03 
Disk Copies (K)/second

19sync_disk_rw   65.37       4           0.06119           156.65 
Sync Random Disk Writes (K)/second

20sync_disk_wrt  65.73       9           0.13692           350.52 
Sync Sequential Disk Writes (K)/second

21sync_disk_cp   65.54       9           0.13732           351.54 
Sync Disk Copies (K)/second

22 disk_src      60.01       25899       431.57807         32368.36
Directory Searches/second

23 div_double    60.02       1321        22.00933          66027.99
Thousand Double Precision Divides/second

24 div_float     60.02       1321        22.00933          66027.99
Thousand Single Precision Divides/second

25 div_long      60.02       1590        26.49117          23842.05
Thousand Long Integer Divides/second

26 div_int       60.02       1590        26.49117          23842.05
Thousand Integer Divides/second

27 div_short     60.02       1590        26.49117          23842.05
Thousand Short Integer Divides/second

28 fun_cal       60.01       4713        78.53691          40210898.18
Function Calls (no arguments)/second

29 fun_cal1      60.02       10333       172.15928         88145551.48
Function Calls (1 argument)/second

30 fun_cal2      60.01       7492  	     124.84586
63921079.82 Function Calls (2 arguments)/second

31 fun_cal15     60.03       2452        40.84624          20913276.69
Function Calls (15 arguments)/second

32 sieve         60.78       42          0.69102           3.46 
Integer Sieves/second

33 mul_double    60.01       835         13.91435          166972.17
Thousand Double Precision Multiplies/second

34 mul_float     60.02       835         13.91203          166944.35
Thousand Single Precision Multiplies/second

35 mul_long      60.01       75885       1264.53924        303489.42
Thousand Long Integer Multiplies/second

36 mul_int       60.01       75698       1261.42310        302741.54
Thousand Integer Multiplies/second

37 mul_short     60.01       60645       1010.58157        303174.47
Thousand Short Integer Multiplies/second

38 num_rtns_1    60.01       36917       615.18080         61518.08
Numeric Functions/second

39 new_raph      60.01       82850       1380.60323        276120.65
Zeros Found/second

40 trig_rtns     60.02       2210        36.82106          368210.60
Trigonometric Functions/second

41 matrix_rtns   60.01       366551      6108.16531        610816.53
Point Transformations/second

42 array_rtns    60.06       1002        16.68332          333.67 
Linear Systems Solved/second

43 string_rtns   60.07       532         8.85633           885.63 
String Manipulations/second

44 mem_rtns_1    60.01       2788        46.45892          1393767.71
Dynamic Memory Operations/second

45 mem_rtns_2    60.01       131122      2185.00250        218500.25
Block Memory Operations/second

46 sort_rtns_1   60.03       2505        41.72914          417.29
Sort Operations/second

47 misc_rtns_1   60.01       50089       834.67755         8346.78
Auxiliary Loops/second

48 dir_rtns_1    60.01       16428       273.75437         2737543.74
Directory Operations/second

49 shell_rtns_1  60.02       3566        59.41353          59.41 
Shell Scripts/second

50 shell_rtns_2  60.03       3559        59.28702          59.29
Shell Scripts/second

51 shell_rtns_3  60.02       3555        59.23026          59.23 
Shell Scripts/second

52 series_1      60.01       1471131     24514.76421       2451476.42
Series Evaluations/second

53shared_memory  60.01       152530      2541.74304        254174.30
Shared Memory Operations/second

54 tcp_test      60.01       36440       607.23213         54650.89 
TCP/IP Messages/second

55 udp_test      60.01       63893       1064.70588        106470.59 
UDP/IP DataGrams/second

56 fifo_test     60.01       162952      2715.41410        271541.41 
FIFO Messages/second

57 stream_pipe   60.01       131843      2197.01716        219701.72
Stream Pipe Messages/second

58 dgram_pipe    60.01       131142      2185.33578        218533.58
DataGram Pipe Messages/second

59 pipe_cpy      60.01       185198      3086.11898        308611.90 
Pipe Messages/second

60 ram_copy      60.01       1551939     25861.33978       647050721.21
Memory to Memory Copy/second
------------------------------------------------------------------------
--
Regards

Sowmya Adiga
Project Engineer
Wipro Technologies
53/1,Hosur Road,Madivala
Bangalore-560 068,INDIA

