Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264992AbSLPEVN>; Sun, 15 Dec 2002 23:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265039AbSLPEVN>; Sun, 15 Dec 2002 23:21:13 -0500
Received: from wiprom2mx2.wipro.com ([203.197.164.42]:56478 "EHLO
	wiprom2mx2.wipro.com") by vger.kernel.org with ESMTP
	id <S264992AbSLPEVK>; Sun, 15 Dec 2002 23:21:10 -0500
From: "Sowmya Adiga" <sowmya.adiga@wipro.com>
To: <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK RESULT]Unixbench result for kernel 2.5.51 with mm2 patch .
Date: Mon, 16 Dec 2002 09:58:49 +0530
Organization: Wipro Technologies
Message-ID: <008d01c2a4bb$a21eead0$6009720a@wipro.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Importance: Normal
X-OriginalArrivalTime: 16 Dec 2002 04:28:50.0679 (UTC) FILETIME=[A2318870:01C2A4BB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 
Here are the Unixbench result for kernel 2.5.51 with mm2 patch along
with kernel 2.5.51.
________________________________________________________________________
____
Test Machine details
---------------------
processor : 0(single processor)
vendor_id : GenuineIntel
cpu family : 6
model  : 8
model name : Pentium III (Coppermine)
stepping : 10
cpu MHz  : 868.275
cache size : 256 KB
fdiv_bug : no
hlt_bug  : no
f00f_bug : no
coma_bug : no
fpu  : yes
fpu_exception : yes
cpuid level : 2
wp  : yes
flags  : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 mmx fxsr sse
bogomips : 1716.22

------------------------------------------------------------------------
----
                                    kernel 2.5.51

------------------------------------------------------------------------
----
BYTE UNIX Benchmarks (Version 4.1.0)
System -- Linux access1 2.5.51 #3 Tue Dec 10 11:52:13 IST 2002 i686
unknown
Start Benchmark Run: Tue Dec 10 13:23:54 IST 2002
1 interactive users.
1:23pm  up 1 min,  1 user,  load average: 0.13, 0.08, 0.03
lrwxrwxrwx    1 root     root            4 Oct 22 00:35 /bin/sh -> bash
/bin/sh: symbolic link to bash
/dev/hda2              8262068   2711284   5131088  35% /data

Dhrystone 2 using register variables    1753562.1 lps(10.0 secs,10
samples)
Double-Precision Whetstone              477.0 MWIPS  (10.0 secs,10
samples)
System Call Overhead                    458680.5 lps (10.0 secs,10
samples)
Pipe Throughput                         452140.4 lps (10.0 secs,10
samples)
Pipe-based Context Switching            224110.7 lps (10.0 secs,10
samples)
Process Creation                        4090.9 lps   (30.0 secs,3
samples)
Execl Throughput                        956.9 lps    (29.9 secs,3
samples)
File Read 1024 bufsize 2000 maxblocks   244936.0 KBps(30.0 secs,3
samples)
File Write 1024 bufsize 2000 maxblocks  99665.0 KBps (30.0 secs,3
samples)
File Copy 1024 bufsize 2000 maxblocks   67488.0 KBps (30.0 secs,3
samples)
File Read 256 bufsize 500 maxblocks     114320.0KBps (30.0 secs,3
samples)
File Write 256 bufsize 500 maxblocks    55900.0 KBps (30.0 secs,3
samples)
File Copy 256 bufsize 500 maxblocks     33000.0 KBps (30.0 secs,3
samples)
File Read 4096 bufsize 8000 maxblocks   336659.0 KBps(30.0 secs,3
samples)
File Write 4096 bufsize 8000 maxblocks  125510.0 KBps(30.0 secs,3
samples)
File Copy 4096 bufsize 8000 maxblocks   81771.0 KBps (30.0 secs,3
samples)
Shell Scripts (1 concurrent)            867.7 lpm    (60.0 secs,3
samples)
Shell Scripts (8 concurrent)            113.0 lpm    (60.0 secs,3
samples)
Shell Scripts (16 concurrent)           57.0 lpm    (60.0 secs, 3
samples)
Arithmetic Test (type = short)          208206.7 lps(10.0 secs, 3
samples)
Arithmetic Test (type = int)            225297.0 lps(10.0 secs, 3
samples)
Arithmetic Test (type = long)           225335.1 lps(10.0 secs, 3
samples)
Arithmetic Test (type = float)          227559.9 lps(10.0 secs, 3
samples)
Arithmetic Test (type = double)         227389.7 lps(10.0 secs, 3
samples)
Arithoh                                 3996200.7 lps(10.0 secs,3
samples)
C Compiler Throughput                   409.7 lpm   (60.0 secs, 3
samples)
Dc: sqrt(2) to 99 decimal places        34294.6 lpm (30.0 secs, 3
samples)
Recursion Test--Tower of Hanoi          29280.8 lps (20.0 secs, 3
samples)

                     INDEX VALUES            
TEST                                       BASELINE     RESULT
INDEX
Dhrystone 2 using register variables       116700.0    1753562.1
150.3
Double-Precision Whetstone                 55.0        477.0        6.7
Execl Throughput                           43.0        956.9
222.5
File Copy 1024 bufsize 2000 maxblocks      3960.0      67488.0
170.4
File Copy 256 bufsize 500 maxblocks        1655.0      33000.0
199.4
File Copy 4096 bufsize 8000 maxblocks      5800.0      81771.0
141.0
Pipe Throughput                            12440.0     452140.4
363.5
Process Creation                           126.0       4090.9
324.7
Shell Scripts (8 concurrent)               6.0         113.0
188.3
System Call Overhead                       15000.0     458680.5
305.8
 
=========                                          
     FINAL SCORE
198.4                                    
------------------------------------------------------------------------
----
                           kernel 2.5.51 with mm2 patch
------------------------------------------------------------------------
----
BYTE UNIX Benchmarks (Version 4.1.0)
System -- Linux access1 2.5.51 #4 Thu Dec 12 17:06:03 IST 2002 i686
unknown
Start Benchmark Run: Fri Dec 13 09:18:40 IST 2002
1 interactive users.
9:18am  up 1 min,  1 user,  load average: 0.25, 0.11, 0.04
lrwxrwxrwx    1 root     root            4 Oct 22 00:35 /bin/sh -> bash
/bin/sh: symbolic link to bash
/dev/hda2              8262068   3205664   4636708  41% /data

Dhrystone 2 using register variables   1753336.5 lps(10.0 secs,10
samples)
Double-Precision Whetstone             477.1 MWIPS  (10.0 secs,10
samples)
System Call Overhead                   445833.3 lps (10.0 secs,10
samples)
Pipe Throughput                        447423.5 lps (10.0 secs,10
samples)
Pipe-based Context Switching           222788.5 lps(10.0 secs, 10
samples)
Process Creation                       4342.5 lps   (30.0 secs, 3
samples)
Execl Throughput                       928.5 lps    (29.8 secs, 3
samples)
File Read 1024 bufsize 2000 maxblocks  243963.0 KBps(30.0 secs, 3
samples)
File Write 1024 bufsize 2000 maxblocks 95244.0 KBps (30.0 secs, 3
samples)
File Copy 1024 bufsize 2000 maxblocks  68035.0 KBps (30.0 secs, 3
samples)
File Read 256 bufsize 500 maxblocks    112811.0 KBps(30.0 secs, 3
samples)
File Write 256 bufsize 500 maxblocks   50727.0 KBps (30.0 secs, 3
samples)
File Copy 256 bufsize 500 maxblocks    33630.0 KBps (30.0 secs, 3
samples)
File Read 4096 bufsize 8000 maxblocks  336749.0 KBps(30.0 secs, 3
samples)
File Write 4096 bufsize 8000 maxblocks 124177.0 KBps(30.0 secs, 3
samples)
File Copy 4096 bufsize 8000 maxblocks  89078.0 KBps (30.0 secs, 3
samples)
Shell Scripts (1 concurrent)           869.1 lpm    (60.0 secs, 3
samples)
Shell Scripts (8 concurrent)           114.0 lpm    (60.0 secs, 3
samples)
Shell Scripts (16 concurrent)          57.0 lpm     (60.0 secs, 3
samples)
Arithmetic Test (type = short)         208135.9 lps (10.0 secs, 3
samples)
Arithmetic Test (type = int)           225041.1 lps (10.0 secs, 3
samples)
Arithmetic Test (type = long)          225069.1 lps (10.0 secs, 3
samples)
Arithmetic Test (type = float)         227400.9 lps (10.0 secs, 3
samples)
Arithmetic Test (type = double)        227403.6 lps (10.0 secs, 3
samples)
Arithoh                                3997714.0 lps(10.0 secs, 3
samples)
C Compiler Throughput                  408.7 lpm    (60.0 secs, 3
samples)
Dc: sqrt(2) to 99 decimal places       33208.3 lpm  (30.0 secs, 3
samples)
Recursion Test--Tower of Hanoi         29272.8 lps  (20.0 secs, 3
samples)

                     INDEX VALUES            
TEST                                   BASELINE     RESULT    INDEX
Dhrystone 2 using register variables   116700.0    1753336.5  150.2
Double-Precision Whetstone             55.0        477.1      86.7
Execl Throughput                       43.0        928.5      215.9
File Copy 1024 bufsize 2000 maxblocks  3960.0      68035.0    171.8
File Copy 256 bufsize 500 maxblocks    1655.0      33630.0    203.2
File Copy 4096 bufsize 8000 maxblocks  5800.0      89078.0    153.6
Pipe Throughput                        12440.0     447423.5   359.7
Process Creation                       126.0       4342.5     344.6
Shell Scripts (8 concurrent)           6.0         114.0      190.0
System Call Overhead                   15000.0     445833.3   297.2
                                                             =========

     FINAL SCORE                                              200.6

________________________________________________________________________
__
Regards
Sowmya Adiga
Project Engineer
Wipro Technologies
53/1,Hosur Road,Madivala
Bangalore-560 068,INDIA
Tel: +91-80-5502001 Extn.5086
sowmya.adiga@wipro.com
 

