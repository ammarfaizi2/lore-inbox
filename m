Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265708AbSLPI6U>; Mon, 16 Dec 2002 03:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265711AbSLPI6U>; Mon, 16 Dec 2002 03:58:20 -0500
Received: from wiprom2mx2.wipro.com ([203.197.164.42]:29137 "EHLO
	wiprom2mx2.wipro.com") by vger.kernel.org with ESMTP
	id <S265708AbSLPI6R>; Mon, 16 Dec 2002 03:58:17 -0500
From: "Sowmya Adiga" <sowmya.adiga@wipro.com>
To: <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK]AIM benchmark result for kernel 2.5.52
Date: Mon, 16 Dec 2002 14:35:47 +0530
Organization: Wipro Technologies
Message-ID: <000501c2a4e2$529ed3e0$6009720a@wipro.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
x-mimeole: Produced By Microsoft MimeOLE V6.00.2462.0000
Importance: Normal
X-OriginalArrivalTime: 16 Dec 2002 09:05:47.0573 (UTC) FILETIME=[52A25650:01C2A4E2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are AIM benchmark result for Kernel 2.5.52.When compared with
Kernel 2.5.51 there was a drop in performance in following tests:-
________________________________________________________________________
__

Dynamic Memory Operations/second
mem_rtns_1 [2.5.51]    60.00    1640   27.33333     820000.00 
mem_rtns_1 [2.5.52]    60.01    1617   26.94551     808365.27 

UDP/IP DataGrams/second
udp_test   [2.5.51]    60.00    49319  821.98333    82198.33 
udp_test   [2.5.52]    60.00    46763  779.38333    77938.33 
________________________________________________________________________
__

All other test results were consistent

------------------------------------------------------------------------
----
                       AIM result for kernel 2.5.52
------------------------------------------------------------------------
----                        
Machine's name                                    :access1
Machine's configuration                           :PIII/868MHZ/128MB
Number of seconds to run each test [2 to 1000]    :60
Path to disk files                                :/tmp

------------------------------------------------------------------------
----
 Test Test        Elapsed     Iteration  Iteration    Operation
NumberName        Time (sec)   Count     Rate (loops/sec)Rate (ops/sec)
------------------------------------------------------------------------
----
Thousand Double Precision Additions/second
1 add_double       60.02        716     11.92936      214728.42 

Thousand Single Precision Additions/second
2 add_float        60.05        1075    17.90175      214820.98 

Thousand Long Integer Additions/second
3 add_long         60.03        1768    29.45194      1767116.44 

Thousand Integer Additions/second
4 add_int          60.01        1768    29.46176      1767705.38 

Thousand Short Integer Additions/second
5 add_short        60.01        4419    73.63773      1767305.45 

File Creations and Closes/second
6 creat-clo        60.01        2131    35.51075      35510.75 

System Allocations & Pages/second
7 page_test        60.00        8843    147.38333     250551.67
 
System Memory Allocations/second
8 brk_test         60.00        3365    56.08333      953416.67 

Non-local gotos/second
9 jmp_test         60.00        318129  5302.15000    5302150.00
 
Signal Traps/second
10 signal_test     60.01        9734    162.20630     162206.30 

Program Loads/second
11 exec_test       60.02        2063    34.37188      171.86 

Task Creations/second
12 fork_test       60.03        1035    17.24138      1724.14 

Link/Unlink Pairs/second
13 link_test       60.00        10219   170.31667     10729.95 

Random Disk Reads (K)/second
14 disk_rr         60.09        501     8.33749       42687.97 

Random Disk Writes (K)/second
15 disk_rw         60.06        396     6.59341       33758.24 

Sequential Disk Reads (K)/second
16 disk_rd         60.01        2785    46.40893      237613.73 

Sequential Disk Writes (K)/second
17 disk_wrt        60.03        648     10.79460      55268.37 

Disk Copies (K)/second
18 disk_cp         60.09        517     8.60376       44051.26 

Sync Random Disk Writes (K)/second
19 sync_disk_rw    60.47        1       0.01654       42.34 

Sync Sequential Disk Writes (K)/second
20 sync_disk_wrt   76.75        2       0.02606       66.71 

Sync Disk Copies (K)/second
21 sync_disk_cp    77.60        2       0.02577       65.98 

Directory Searches/second
22 disk_src        60.01       10595    176.55391     13241.54 

Thousand Double Precision Divides/second
23 div_double      60.03       1322     22.02232      66066.97 

Thousand Single Precision Divides/second
24 div_float       60.00       1322     22.03333      66100.00 

Thousand Long Integer Divides/second
25 div_long        60.03       1592     26.52007      23868.07 

Thousand Integer Divides/second
26 div_int         60.03       1592     26.52007      23868.07 

Thousand Short Integer Divides/second
27 div_short       60.03       1592     26.52007      23868.07 

Function Calls (no arguments)/second
28 fun_cal         60.01       4362     72.68789      37216197.30 

Function Calls (1 argument)/second
29 fun_cal1        60.00      10231     170.51667     87304533.33 

Function Calls (2 arguments)/second
30 fun_cal2        60.01       7971     132.82786     68007865.36 

Function Calls (15 arguments)/second
31 fun_cal15       60.02       2455     40.90303      20942352.55 

Integer Sieves/second
32 sieve           60.50       41       0.67769       3.39 

  Thousand Double Precision Multiplies/second 
33 mul_double      60.01       836      13.93101      167172.14 

Thousand Single Precision Multiplies/second
34 mul_float       60.02       836      13.92869      167144.29 

Thousand Long Integer Multiplies/second
35 mul_long        60.00       75690    1261.50000    302760.00 

Thousand Integer Multiplies/second
36 mul_int         60.00       76003    1266.71667    304012.00 

Thousand Short Integer Multiplies/second
37 mul_short       60.00       60554    1009.23333    302770.00 

 Numeric Functions/second 
38 num_rtns_1      60.00       32595    543.25000     54325.00 

Zeros Found/second
39 new_raph        60.00       79896    1331.60000    266320.00 

Trigonometric Functions/second
40 trig_rtns       60.00       2161     36.01667      360166.67 

Point Transformations/second
41 matrix_rtns     60.00       349526   5825.43333    582543.33 

Linear Systems Solved/second
42 array_rtns      60.03       960      15.99200      319.84 

String Manipulations/second
43 string_rtns     60.03       851      14.17625      1417.62 

Dynamic Memory Operations/second
44 mem_rtns_1      60.01       1617     26.94551      808365.27 

Block Memory Operations/second
45 mem_rtns_2      60.00       131046   2184.10000    218410.00 

Sort Operations/second
46 sort_rtns_1     60.00       2426     40.43333      404.33 

Auxiliary Loops/second
47 misc_rtns_1     60.00       31441    524.01667     5240.17 

Directory Operations/second
48 dir_rtns_1      60.01       13183    219.68005     2196800.53

Shell Scripts/second
49 shell_rtns_1    60.02       2413     40.20327      40.20 

Shell Scripts/second
50 shell_rtns_2    60.01       2412     40.19330      40.19 

Shell Scripts/second
51 shell_rtns_3    60.01       2411     40.17664      40.18 

Series Evaluations/second
52 series_1        60.00       1464135  24402.25000   2440225.00 

Shared Memory Operations/second
53 shared_memory   60.00       163231   2720.51667    272051.67 

TCP/IP Messages/second
54 tcp_test        60.00       11039    183.98333     16558.50 

UDP/IP DataGrams/second
55 udp_test        60.00       46763    779.38333     77938.33 

FIFO Messages/second
56 fifo_test       60.00       87136    1452.26667    145226.67 

Stream Pipe Messages/second
57 stream_pipe     60.00       70184    1169.73333    116973.33 

DataGram Pipe Messages/second
58 dgram_pipe      60.00       68071    1134.51667    113451.67 

Pipe Messages/second
59 pipe_cpy        60.00       254506   4241.76667    424176.67 

Memory to Memory Copy/second
60 ram_copy        60.00       1495693  24928.21667   623703981.00 
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
 

