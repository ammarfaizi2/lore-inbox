Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261375AbTB0Gzs>; Thu, 27 Feb 2003 01:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261427AbTB0Gzs>; Thu, 27 Feb 2003 01:55:48 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:57775 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S261375AbTB0Gzo>; Thu, 27 Feb 2003 01:55:44 -0500
From: "Sowmya Adiga" <sowmya.adiga@wipro.com>
To: <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK]AIM9 benchmark result for kernel 2.5.63
Date: Thu, 27 Feb 2003 12:35:42 +0530
Message-ID: <00db01c2de2e$a4327fb0$6009720a@wipro.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Importance: Normal
X-OriginalArrivalTime: 27 Feb 2003 07:05:42.0385 (UTC) FILETIME=[A429A610:01C2DE2E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	 Here is the AIM9 benchmark result for kernel 2.5.63.when
compared with kernel 2.5.62 showed difference in create_clo 

========================================================================
 Test         Elapsed      Iteration    Iteration        Operation
 Name         Time (sec)   Count        Rate(loops/sec)  Rate (ops/sec)
------------------------------------------------------------------------
File Creations and Closes/second
creat-clo       
[Linux-2.5.63]  60.00        5736        95.60000          95600.00 
[Linux-2.5.62]  60.00        6025        100.41667         100416.67 

========================================================================
*There is no much significant difference in other test result.
------------------------------------------------------------------------
---					kernel-2.5.63
------------------------------------------------------------------------
---
Machine's name                                    : access1
Machine's configuration                           : PIII/868MHZ/128MB
Number of seconds to run each test [2 to 1000]    : 60
Path to disk files                                : /tmp 
------------------------------------------------------------------------
---
Test   Test      Elapsed     Iteration    Iteration         Operation
Number Name      Time(sec)   Count        Rate(loops/sec)   Rate
ops/sec)
------------------------------------------------------------------------
---
1 add_double      60.08        716        11.91744          214513.98
Thousand Double Precision Additions/second

2 add_float      	60.00        1073   	17.88333
214600.00 Thousand Single Precision Additions/second

3 add_long        60.04        1767       29.43038          1765822.78
Thousand Long Integer Additions/second

4 add_int         60.03        1767       29.43528          1766116.94
Thousand Integer Additions/second

5 add_short       60.01        4415       73.57107          1765705.72
Thousand Short Integer Additions/second

6 creat-clo       60.00        5736       95.60000          95600.00 
File Creations and Closes/second

7 page_test       60.01        6816       113.58107         193087.82
System Allocations & Pages/second

8 brk_test        60.01        2559       42.64289          724929.18
System Memory Allocations/second

9 jmp_test        60.00        322027     5367.11667        5367116.67 
Non-local gotos/second

10 signal_test    60.00        11077      184.61667         184616.67
Signal Traps/second

11 exec_test      60.01        2710       45.15914          225.80 
Program Loads/second

12 fork_test      60.03        1557       25.93703          2593.70 
Task Creations/second

13 link_test      60.00        27496      458.26667         28870.80
Link/Unlink Pairs/second

14 disk_rr        60.05        444        7.39384           37856.45 
Random Disk Reads (K)/second

15 disk_rw        60.00        360        6.00000           30720.00 
Random Disk Writes (K)/second

16 disk_rd        60.01        2549       42.47625          217478.42
Sequential Disk Reads (K)/second

17 disk_wrt       60.09        565        9.40256           48141.12
Sequential Disk Writes (K)/second

18 disk_cp        60.12        445        7.40186           37897.54 
Disk Copies (K)/second

19 sync_disk_rw   94.15         2         0.02124           54.38 
Sync Random Disk Writes (K)/second

20 sync_disk_wrt  68.79         2         0.02907           74.43 
Sync Sequential Disk Writes (K)/second

21 sync_disk_cp   68.40         2         0.02924           74.85 
Sync Disk Copies (K)/second

22 disk_src       60.00         17362     289.36667         21702.50
Directory Searches/second

23 div_double     60.02         1321      22.00933          66027.99
Thousand Double Precision Divides/second

24 div_float      60.01         1321      22.01300          66038.99
Thousand Single Precision Divides/second

25 div_long       60.01         1590      26.49558          23846.03
Thousand Long Integer Divides/second

26 div_int        60.01         1590      26.49558          23846.03
Thousand Integer Divides/second

27 div_short      60.02         1590      26.49117          23842.05
Thousand Short Integer Divides/second

28 fun_cal        60.01         4713      78.53691          40210898.18
Function Calls (no arguments)/second

29 fun_cal1       60.00         10334     172.23333         88183466.67
Function Calls (1 argument)/second

30 fun_cal2       60.00         7492      124.86667         63931733.33
Function Calls (2 arguments)/second

31 fun_cal15      60.02         2452      40.85305          20916761.08
Function Calls (15 arguments)/second

32 sieve          60.68         41        0.67568           3.38 
Integer Sieves/second

33 mul_double     60.01         835       13.91435          166972.17
Thousand Double Precision Multiplies/second

34 mul_float      60.02         835       13.91203          166944.35
Thousand Single Precision Multiplies/second

35 mul_long       60.00         75812     1263.53333        303248.00
Thousand Long Integer Multiplies/second

36 mul_int        60.00         75934     1265.56667        303736.00
Thousand Integer Multiplies/second

37 mul_short      60.00         60727     1012.11667        303635.00
Thousand Short Integer Multiplies/second

38 num_rtns_1     60.00         36675     611.25000         61125.00
Numeric Functions/second

39 new_raph       60.00         82843     1380.71667        276143.33
Zeros Found/second

40 trig_rtns      60.01         2210      36.82720          368271.95
Trigonometric Functions/second

41 matrix_rtns    60.00         366590    6109.83333        610983.33 
Point Transformations/second

42 array_rtns     60.05         1001      16.66944          333.39 
Linear Systems Solved/second

43 string_rtns    60.06         532       8.85781           885.78 
String Manipulations/second

44 mem_rtns_1     60.01         2347      39.11015          1173304.45
Dynamic Memory Operations/second

45 mem_rtns_2     60.00         131125    2185.41667        218541.67 
Block Memory Operations/second

46 sort_rtns_1    60.01         2505      41.74304          417.43 
Sort Operations/second

47 misc_rtns_1    60.01         50359     839.17680         8391.77
Auxiliary Loops/second

48 dir_rtns_1     60.00         11886     198.10000         1981000.00
Directory Operations/second

49 shell_rtns_1   60.01         3164      52.72455          52.72 
Shell Scripts/second

50 shell_rtns_2   60.02         3172      52.84905          52.85 
Shell Scripts/second

51 shell_rtns_3   60.01         3172      52.85786          52.86 
Shell Scripts/second

52 series_1       60.00         1470759   24512.65000       2451265.00
Series Evaluations/second

53 shared_memory  60.00         153743    2562.38333        256238.33
Shared Memory Operations/second

54 tcp_test       60.00         29462     491.03333         44193.00 
TCP/IP Messages/second

55 udp_test       60.00         65547     1092.45000        109245.00
UDP/IP DataGrams/second

56 fifo_test      60.00         86797     1446.61667        144661.67 
FIFO Messages/second

57 stream_pipe    60.00         136142    2269.03333        226903.33
Stream Pipe Messages/second

58 dgram_pipe     60.01         132608    2209.76504        220976.50
DataGram Pipe Messages/second

59 pipe_cpy       60.00         188382    3139.70000        313970.00 
Pipe Messages/second

60 ram_copy       60.00         1553332   25888.86667       647739444.00
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

