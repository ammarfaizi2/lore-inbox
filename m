Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265683AbTATLkk>; Mon, 20 Jan 2003 06:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265689AbTATLkk>; Mon, 20 Jan 2003 06:40:40 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:62848 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S265683AbTATLkh>; Mon, 20 Jan 2003 06:40:37 -0500
From: "Sowmya Adiga" <sowmya.adiga@wipro.com>
To: <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK]AIM benchmark result for kernel 2.5.59
Date: Mon, 20 Jan 2003 17:19:27 +0530
Message-ID: <005601c2c079$fc247a20$6009720a@wipro.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Importance: Normal
X-OriginalArrivalTime: 20 Jan 2003 11:49:27.0347 (UTC) FILETIME=[FC223030:01C2C079]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 Here are the AIM benchmark result for kernel 2.5.59.when compared with
kernel 2.5.58 showed difference of performance in system memory
allocation/second :-

========================================================================

Test        Elapsed      Iteration    Iteration        Operation
Name        Time (sec)   Count        Rate(loops/sec)  Rate (ops/sec)
------------------------------------------------------------------------
1 System Memory Allocations/second
  brk_test      
  [2.5.59]   60.00        3396        56.60000          962200.00 
  [2.5.58]   60.00        3459        57.65000          980050.00

========================================================================
*There is no much significant difference in other test result.

------------------------------------------------------------------------


------------------------------------------------------------------------
----
					kernel-2.5.59
------------------------------------------------------------------------
----
Machine's name                                    : access1
Machine's configuration                           : PIII/868MHZ/128MB
Number of seconds to run each test [2 to 1000]    : 60
Path to disk files                                : /tmp 

------------------------------------------------------------------------
----
 TestTest     Elapsed     Iteration    Iteration          Operation
NumberName    Time(sec)   Count        Rate(loops/sec)    Rate (ops/sec)
------------------------------------------------------------------------
----
1 add_double    60.04        716         11.92538          214656.90 
Thousand Double Precision Additions/second

2 add_float     60.05        1075        17.90175          214820.98 
Thousand Single Precision Additions/second

3 add_long      60.01        1768        29.46176          1767705.38
Thousand Long Integer Additions/second

4 add_int       60.01        1768        29.46176          1767705.38
Thousand Integer Additions/second

5 add_short     60.00        4419        73.65000          1767600.00
Thousand Short Integer Additions/second

6 creat-clo     60.01        2144        35.72738          35727.38 
File Creations and Closes/second

7 page_test     60.01        8398        139.94334         237903.68 
System Allocations & Pages/second

8 brk_test      60.00        3396        56.60000          962200.00 
System Memory Allocations/second

9 jmp_test      60.00        318244      5304.06667        5304066.67
Non-local gotos/second

10signal_test   60.00        9728        162.13333         162133.33 
Signal Traps/second

11 exec_test    60.01        2110        35.16081          175.80 
Program Loads/second

12 fork_test    60.03        1281        21.33933          2133.93 
Task Creations/second

13 link_test    60.01        9484        158.04033         9956.54
Link/Unlink Pairs/second

14 disk_rr      60.09        503         8.37078           42858.38 
Random Disk Reads (K)/second

15 disk_rw      60.08        403         6.70772           34343.54 
Random Disk Writes (K)/second

16 disk_rd      60.02        2795        46.56781          238427.19
Sequential Disk Reads (K)/second

17 disk_wrt     60.07        654         10.88730          55742.97
Sequential Disk Writes (K)/second

18 disk_cp      60.10        499         8.30283           42510.48 
Disk Copies (K)/second

19sync_disk_rw  60.96         1          0.01640           41.99 
Sync Random Disk Writes (K)/second

20sync_disk_wrt 76.86         2          0.02602           66.61
Sync Sequential Disk Writes (K)/second

21sync_disk_cp  77.40         2          0.02584           66.15 
Sync Disk Copies (K)/second

22 disk_src     60.01         10544      175.70405         13177.80
Directory Searches/second

23 div_double   60.00         1322       22.03333          66100.00 
Thousand Double Precision Divides/second

24 div_float    60.01         1322       22.02966          66088.99 
Thousand Single Precision Divides/second

25 div_long     60.03         1592       26.52007          23868.07 
Thousand Long Integer Divides/second

26 div_int      60.03         1592       26.52007          23868.07 
Thousand Integer Divides/second

27 div_short    60.02         1592       26.52449          23872.04 
Thousand Short Integer Divides/second

28 fun_cal      60.01         4362       72.68789          37216197.30
Function Calls (no arguments)/second

29 fun_cal1     60.00         10231      170.51667         87304533.33
Function Calls (1 argument)/second

30 fun_cal2     60.00         7968       132.80000         67993600.00
Function Calls (2 arguments)/second

31 fun_cal15    60.03         2455       40.89622          20938863.90
Function Calls (15 arguments)/second

32 sieve        60.20         41         0.68106           3.41
Integer Sieves/second

33 mul_double   60.03         834        13.89305          166716.64
Thousand Double Precision Multiplies/second

34 mul_float    60.05         837        13.93838          167260.62
Thousand Single Precision Multiplies/second

35 mul_long     60.00         75709      1261.81667       302836.00 
Thousand Long Integer Multiplies/second

36 mul_int      60.00         76022      1267.03333       304088.00 
Thousand Integer Multiplies/second

37 mul_short    60.00         60572      1009.53333       302860.00 
Thousand Short Integer Multiplies/second

38 num_rtns_1   60.00         32603      543.38333        54338.33 
Numeric Functions/second

39 new_raph     60.00         79912      1331.86667       266373.33 
Zeros Found/second

40 trig_rtns    60.00         2152       35.86667         358666.67
Trigonometric Functions/second

41 matrix_rtns  60.00         349676     5827.93333       582793.33 
Point Transformations/second

42 array_rtns   60.01         930        15.49742         309.95
Linear Systems Solved/second

43 string_rtns  60.01         851        14.18097         1418.10
String Manipulations/second

44 mem_rtns_1   60.03         1338       22.28886         668665.67 
Dynamic Memory Operations/second

45 mem_rtns_2   60.00         131062     2184.36667       218436.67 
Block Memory Operations/second

46 sort_rtns_1  60.01         2425       40.40993         404.10 
Sort Operations/second

47 misc_rtns_1  60.00         31822      530.36667        5303.67 
Auxiliary Loops/second

48 dir_rtns_1   60.00         12849      214.15000        2141500.00
Directory Operations/second

49 shell_rtns_1 60.01         2567       42.77620         42.78 
Shell Scripts/second

50 shell_rtns_2 60.01         2575       42.90952         42.91 
Shell Scripts/second

51 shell_rtns_3 60.01         2577       42.94284         42.94 
Shell Scripts/second

52 series_1     60.00         1465210    24420.16667      2442016.67 
Series Evaluations/second

53shared_memory 60.00         166109     2768.48333       276848.33 
Shared Memory Operations/second

54 tcp_test     60.00         16154      269.23333        24231.00 
TCP/IP Messages/second

55 udp_test     60.00         49164      819.40000        81940.00 
UDP/IP DataGrams/second

56 fifo_test    60.00         90704      1511.73333       151173.33 
FIFO Messages/second

57 stream_pipe  60.00         77088      1284.80000       128480.00 
Stream Pipe Messages/second

58 dgram_pipe   60.00         74169      1236.15000       123615.00 
DataGram Pipe Messages/second

59 pipe_cpy     60.00         260050     4334.16667       433416.67 
Pipe Messages/second

60 ram_copy     60.00         1496821    24947.01667      624174357.00
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

