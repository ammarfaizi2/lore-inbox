Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264628AbSLQDh7>; Mon, 16 Dec 2002 22:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264630AbSLQDh7>; Mon, 16 Dec 2002 22:37:59 -0500
Received: from wiprom2mx2.wipro.com ([203.197.164.42]:18647 "EHLO
	wiprom2mx2.wipro.com") by vger.kernel.org with ESMTP
	id <S264628AbSLQDh4>; Mon, 16 Dec 2002 22:37:56 -0500
From: "Sowmya Adiga" <sowmya.adiga@wipro.com>
To: <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK]AIM benchmark result for kernel 2.5.52with mm1 patch.
Date: Tue, 17 Dec 2002 09:15:38 +0530
Organization: Wipro Technologies
Message-ID: <001801c2a57e$c37c70d0$6009720a@wipro.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
In-Reply-To: <001601c2a57e$292d6b60$6009720a@wipro.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Importance: Normal
X-OriginalArrivalTime: 17 Dec 2002 03:45:38.0536 (UTC) FILETIME=[C391A680:01C2A57E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Here are the AIM benchmark result for kernel 2.5.52 with mm1 patch.
Kernel 2.5.52 with mm1 patch when compared with kernel 2.5.52 showed
difference of performance in following tests:-
------------------------------------------------------------------------
                  drop in performance of kernel 2.5.52mm1
------------------------------------------------------------------------

System Memory Allocations/second
8 brk_test[2.5.52mm1] 60.02      3303      55.03166      935538.15 
8 brk_test[2.5.52]    60.00      3365      56.08333      953416.67 

Sequential Disk Writes (K)/second
17 disk_wrt[2.5.52mm1]60.08      630       10.48602      53688.42 
17 disk_wrt[2.5.52]   60.03      648       10.79460      55268.37 

Disk Copies (K)/second
18 disk_cp[2.5.52mm1]  60.03      500       8.32917      42645.34 
18 disk_cp[2.5.52]     60.09      517       8.60376      44051.26 

------------------------------------------------------------------------
                 Gain in performance of kernel 2.5.52mm1
------------------------------------------------------------------------
Task Creations/second
12 fork_test[2.5.52mm1]60.01      1215      20.24663      2024.66 
12 fork_test[2.5.52]   60.03      1035      17.24138      1724.14

Dynamic Memory Operations/second
44 mem_rtns_1[2.5.52mm1]60.02      1971      32.83905     985171.61 
44 mem_rtns_1[2.5.52]   60.01      1617      26.94551     808365.27
------------------------------------------------------------------------

************************************************************************
                               kernel 2.5.52 with mm1
************************************************************************

Machine's name                                 : access1
Machine's configuration                        : PIII/868MHZ/128MB
Number of seconds to run each test [2 to 1000] : 60
Path to disk files                             :/tmp
------------------------------------------------------------------------

Test Test            Elapsed    Iteration  Iteration       Operation
NumberName           Time (sec) Count      Rate(loops/sec)Rate (ops/sec)
------------------------------------------------------------------------

Thousand Double Precision Additions/second
1 add_double          60.05      716       11.92340        214621.15 

Thousand Single Precision Additions/second
2 add_float           60.05      1075      17.90175        214820.98 

Thousand Long Integer Additions/second
3 add_long            60.01      1768      29.46176        1767705.38

Thousand Integer Additions/second
4 add_int             60.01      1768      29.46176        1767705.38 

Thousand Short Integer Additions/second
5 add_short           60.01      4419      73.63773        1767305.45 

File Creations and Closes/second
6 creat-clo           60.02      2158      35.95468        35954.68 

System Allocations & Pages/second
7 page_test           60.00      8703      145.05000       246585.00 

System Memory Allocations/second
8 brk_test            60.02      3303      55.03166        935538.15 

Non-local gotos/second
9 jmp_test            60.00      318110    5301.83333      5301833.33

Signal Traps/second
10 signal_test        60.00      9683      161.38333       161383.33
 
Program Loads/second
11 exec_test          60.00      2105      35.08333        175.42 

Task Creations/second
12 fork_test          60.01      1215      20.24663        2024.66 

Link/Unlink Pairs/second
13 link_test          60.00      10097     168.28333       10601.85 

Random Disk Reads (K)/second
14 disk_rr            60.09      491       8.17108         41835.91 

Random Disk Writes (K)/second
15 disk_rw            60.04      389       6.47901         33172.55 

Sequential Disk Reads (K)/second
16 disk_rd            60.01      2809      46.80887        239661.39 

Sequential Disk Writes (K)/second
17 disk_wrt           60.08      630       10.48602        53688.42 

Disk Copies (K)/second
18 disk_cp            60.03      500       8.32917         42645.34 

Sync Random Disk Writes (K)/second
19 sync_disk_rw       61.27      1         0.01632         41.78 

Sync Sequential Disk Writes (K)/second
20 sync_disk_wrt      76.82      2         0.02603         66.65 

Sync Disk Copies (K)/second
21 sync_disk_cp       78.52      2         0.02547         65.21 

Directory Searches/second
22 disk_src           60.00      10606     176.76667       13257.50 

Thousand Double Precision Divides/second
23 div_double         60.01      1322      22.02966        66088.99 

Thousand Single Precision Divides/second
24 div_float          60.00      1322      22.03333        66100.00 

Thousand Long Integer Divides/second
25 div_long           60.03      1592      26.52007        23868.07 

Thousand Integer Divides/second
26 div_int            60.03      1592      26.52007        23868.07 

Thousand Short Integer Divides/second
27 div_short          60.03      1592      26.52007        23868.07 

Function Calls (no arguments)/second
28 fun_cal            60.01      4362      72.68789        37216197.30 

Function Calls (1 argument)/second
29 fun_cal1           60.00      10231     170.51667       87304533.33 

Function Calls (2 arguments)/second
30 fun_cal2           60.00      7968      132.80000       67993600.00 

Function Calls (15 arguments)/second
31 fun_cal15          60.03      2455      40.89622        20938863.90 

Integer Sieves/second
32 sieve              60.46      41        0.67813         3.39 

Thousand Double Precision Multiplies/second
33 mul_double         60.05      837       13.93838        167260.62 

Thousand Single Precision Multiplies/second
34 mul_float          60.01      836       13.93101        167172.14 

Thousand Long Integer Multiplies/second
35 mul_long           60.00      75674     1261.23333      02696.00 

Thousand Integer Multiplies/second
36 mul_int            60.00      76002     1266.70000      304008.00 

Thousand Short Integer Multiplies/second
37 mul_short          60.00      60635     1010.58333      303175.00 

Numeric Functions/second
38 num_rtns_1         60.00      32597     543.28333       54328.33 

Zeros Found/second
39 new_raph           60.00      79889     1331.48333      266296.67 

Trigonometric Functions/second
40 trig_rtns          60.00      2170      36.16667        361666.67 

Point Transformations/second
41 matrix_rtns        60.00      349510    5825.16667      582516.67 

Linear Systems Solved/second
42 array_rtns         60.06      940       15.65102        313.02 

String Manipulations/second
43 string_rtns        60.01      851       14.18097        1418.10 

Dynamic Memory Operations/second
44 mem_rtns_1         60.02      1971      32.83905        985171.61 

Block Memory Operations/second
45 mem_rtns_2         60.00      131046    2184.10000      218410.00 

Sort Operations/second
46 sort_rtns_1        60.02      2425      40.40320        404.03 

Auxiliary Loops/second
47 misc_rtns_1        60.00      32078     534.63333       5346.33 

Directory Operations/second
48 dir_rtns_1         60.00      13136     218.93333       2189333.33 

Shell Scripts/second
49 shell_rtns_1       60.01       2431     40.50992        40.51 

Shell Scripts/second
50 shell_rtns_2       60.02       2443     40.70310        40.70 

Shell Scripts/second
51 shell_rtns_3       60.01       2441     40.67655        40.68 

Series Evaluations/second
52 series_1           60.00       1464046  24400.76667     2440076.67 

Shared Memory Operations/second
53 shared_memory      60.00       165255   2754.25000      275425.00 

TCP/IP Messages/second
54 tcp_test           60.00       10912    181.86667       16368.00 

UDP/IP DataGrams/second
55 udp_test           60.00        46347   772.45000       77245.00 

FIFO Messages/second
56 fifo_test          60.00        90470   1507.83333      150783.33 

Stream Pipe Messages/second
57 stream_pipe        60.00        70291   1171.51667      117151.67 

DataGram Pipe Messages/second
58 dgram_pipe         60.00        69220   1153.66667      115366.67 

Pipe Messages/second
59 pipe_cpy           60.00        249414  4156.90000      415690.00 

Memory to Memory Copy/second
60 ram_copy           60.00       1495432  24923.86667    623595144.00 
------------------------------------------------------------------------
Regards
 
Sowmya Adiga
Project Engineer
Wipro Technologies
53/1,Hosur Road,Madivala
Bangalore-560 068,INDIA
Tel: +91-80-5502001 Extn.5086
sowmya.adiga@wipro.com
 

