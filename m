Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262788AbTDIFpP (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 01:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262811AbTDIFpP (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 01:45:15 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:36590 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id S262788AbTDIFpI (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 01:45:08 -0400
From: "Sowmya Adiga" <sowmya.adiga@wipro.com>
To: <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK]AIM9 benchmark result for kernel 2.5.67
Date: Wed, 9 Apr 2003 11:26:32 +0530
Message-ID: <001201c2fe5c$c5ac6090$6009720a@wipro.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
X-OriginalArrivalTime: 09 Apr 2003 05:56:32.0686 (UTC) FILETIME=[C5AF94E0:01C2FE5C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	 AIM9 benchmark result for kernel 2.5.67.when compared with
kernel 2.5.66 showed following differences. 
========================================================================
 Test          Elapsed      Iteration    Iteration        Operation
 Name          Time(sec)    Count        Rate(loops/sec)  Rate (ops/sec)
------------------------------------------------------------------------
File Creations and Closes/second
creat-clo     
[Linux-2.5.67]  60.01       10284        171.37144        171371.44 
[Linux-2.6.66]  60.00       9862         164.36667        164366.67

Signal Traps/second
signal_test
[Linux-2.5.67]  60.00       11686       194.76667         194766.67 
[Linux-2.5.66]  60.00       11372       189.53333         189533.33 

FIFO Messages/second
fifo_test     
[Linux-2.5.67]   60.00      160258       2670.96667        267096.67 
[Linux-2.5.66]   60.00      168527       2808.78333        280878.33

========================================================================
*There is no much significant difference in other test result.	

------------------------------------------------------------------------
--
					kernel-2.5.67
------------------------------------------------------------------------
--
Machine's name                                    : access1
Machine's configuration                           : PIII/868MHZ/128MB
Number of seconds to run each test [2 to 1000]    : 60
Path to disk files                                : /tmp

------------------------------------------------------------------------
--
Test  Test      Elapsed      Iteration    Iteration         Operation
NumberName      Time(sec)    Count        Rate(loops/sec)
Rate(ops/sec)
------------------------------------------------------------------------
--
1 add_double      60.07       716         11.91943          214549.69
Thousand Double Precision Additions/second

2 add_float       60.00       1073        17.88333          214600.00
Thousand Single Precision Additions/second

3 add_long        60.01       1766        29.42843          1765705.72
Thousand Long Integer Additions/second

4 add_int         60.01       1766        29.42843          1765705.72
Thousand Integer Additions/second

5 add_short       60.01       4415        73.57107          1765705.72
Thousand Short Integer Additions/second

6 creat-clo       60.01       10284       171.37144         171371.44 
File Creations and Closes/second

7 page_test       60.00       7329        122.15000         207655.00
System Allocations & Pages/second

8 brk_test        60.00       3580        59.66667          1014333.33
System Memory Allocations/second

9 jmp_test        60.00       321955      5365.91667        5365916.67
Non-local gotos/second

10signal_test     60.00       11686       194.76667         194766.67
Signal Traps/second

11 exec_test      60.01       2933        48.87519          244.38 
Program Loads/second

12 fork_test      60.03       1638        27.28636          2728.64 
Task Creations/second

13 link_test      60.00       49489       824.81667         51963.45
Link/Unlink Pairs/second

14 disk_rr        60.02       710         11.82939          60566.48
Random Disk Reads (K)/second

15 disk_rw        60.03       577         9.61186           49212.73
Random Disk Writes (K)/second

16 disk_rd        60.01       2590        43.15947          220976.50
Sequential Disk Reads (K)/second

17 disk_wrt       60.04       1096        18.25450          93463.02
Sequential Disk Writes (K)/second

18 disk_cp        60.07       771         12.83503          65715.33 
Disk Copies (K)/second

19sync_disk_rw    65.85       4           0.06074           155.50 
Sync Random Disk Writes (K)/second

20sync_disk_wrt   65.84       9           0.13670           349.94 
Sync Sequential Disk Writes (K)/second

21sync_disk_cp    65.51       9           0.13738           351.70 
Sync Disk Copies (K)/second

22 disk_src       60.00       26050       434.16667         32562.50
Directory Searches/second

23 div_double     60.02       1321        22.00933          66027.99
Thousand Double Precision Divides/second

24 div_float      60.02       1321        22.00933          66027.99
Thousand Single Precision Divides/second

25 div_long       60.02       1590        26.49117          23842.05
Thousand Long Integer Divides/second

26 div_int        60.02       1590        26.49117          23842.05
Thousand Integer Divides/second

27 div_short      60.02       1590        26.49117          23842.05
Thousand Short Integer Divides/second

28 fun_cal        60.00       4712        78.53333          40209066.67
Function Calls (no arguments)/second 

29 fun_cal1       60.01       10331       172.15464         88143176.14
Function Calls (1 argument)/second

30 fun_cal2       60.00       7491        124.85000         63923200.00
Function Calls (2 arguments)/second

31 fun_cal15      60.00       2451        40.85000          20915200.00
Function Calls (15 arguments)/second

32 sieve          60.45       41          0.67825           3.39 
Integer Sieves/second

33 mul_double     60.02       835         13.91203          166944.35
Thousand Double Precision Multiplies/second

34 mul_float      60.02       835         13.91203          166944.35
Thousand Single Precision Multiplies/second

35 mul_long       60.00       75680       1261.33333        302720.00
Thousand Long Integer Multiplies/second

36 mul_int        60.00       75835       1263.91667        303340.00
Thousand Integer Multiplies/second

37 mul_short      60.00       60640       1010.66667        303200.00
Thousand Short Integer Multiplies/second

38 num_rtns_1     60.00       36915       615.25000         61525.00
Numeric Functions/second

39 new_raph       60.00       82840       1380.66667        276133.33
Zeros Found/second

40 trig_rtns      60.03       2210        36.81493          368149.26
Trigonometric Functions/second

41 matrix_rtns    60.00       366511      6108.51667        610851.67
Point Transformations/second

42 array_rtns     60.01       1002        16.69722          333.94
Linear Systems Solved/second

43 string_rtns    60.06        532        8.85781           885.78 
String Manipulations/second

44 mem_rtns_1     60.01        2759       45.97567          1379270.12
Dynamic Memory Operations/second

45 mem_rtns_2     60.00        131075     2184.58333        218458.33
Block Memory Operations/second

46 sort_rtns_1    60.01        2505       41.74304          417.43 
Sort Operations/second

47 misc_rtns_1    60.00        47872      797.86667         7978.67
Auxiliary Loops/second

48 dir_rtns_1     60.00        16357      272.61667         2726166.67
Directory Operations/second

49 shell_rtns_1   60.01        3507       58.44026          58.44
Shell Scripts/second

50 shell_rtns_2   60.01        3504       58.39027          58.39 
Shell Scripts/second

51 shell_rtns_3   60.01        3503       58.37360          58.37 
Shell Scripts/second

52 series_1       60.00        1470517    24508.61667       2450861.67
Series Evaluations/second

53 shared_memory  60.00        154240     2570.66667        257066.67
Shared Memory Operations/second

54 tcp_test       60.00        35435      590.58333         53152.50
TCP/IP Messages/second

55 udp_test       60.00        69701      1161.68333        116168.33
UDP/IP DataGrams/second

56 fifo_test      60.00        160258     2670.96667        267096.67 
FIFO Messages/second

57 stream_pipe    60.00        140440     2340.66667        234066.67
Stream Pipe Messages/second

58 dgram_pipe     60.00        139098     2318.30000        231830.00
DataGram Pipe Messages/second

59 pipe_cpy       60.00        183890     3064.83333        306483.33 
Pipe Messages/second

60 ram_copy       60.00        1552533    25875.55000       647406261.00
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

