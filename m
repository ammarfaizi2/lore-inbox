Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264631AbSLQEOX>; Mon, 16 Dec 2002 23:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264644AbSLQEOX>; Mon, 16 Dec 2002 23:14:23 -0500
Received: from wiprom2mx2.wipro.com ([203.197.164.42]:40156 "EHLO
	wiprom2mx2.wipro.com") by vger.kernel.org with ESMTP
	id <S264631AbSLQEOU>; Mon, 16 Dec 2002 23:14:20 -0500
From: "Sowmya Adiga" <sowmya.adiga@wipro.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: [BENCHMARK]Unixbench result for kernel 2.5.52 with mm1 patch
Date: Tue, 17 Dec 2002 09:48:16 +0530
Organization: Wipro Technologies
Message-ID: <001c01c2a583$526959d0$6009720a@wipro.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
In-Reply-To: <001a01c2a582$aa4f2400$6009720a@wipro.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Importance: Normal
X-OriginalArrivalTime: 17 Dec 2002 04:18:16.0393 (UTC) FILETIME=[528AEB90:01C2A583]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are the Unixbench result for kernel 2.5.52 with mm1 patch. kernel
2.5.52 with mm1 patch had drop in performance in file copy
operation,when compared with kernel
2.5.52__________________________________________________________________
Test Machine details
---------------------
processor : 0(single processor)
vendor_id : GenuineIntel
cpu family : 6
model : 8
model name : Pentium III (Coppermine)
stepping : 10
cpu MHz : 868.275
cache size : 256 KB
fdiv_bug : no
hlt_bug : no
f00f_bug : no
coma_bug : no
fpu : yes
fpu_exception : yes
cpuid level : 2
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 mmx fxsr sse bogomips : 1716.22
-----------------------------------------------------------------------
                                kernel 2.5.52 with mm1
-----------------------------------------------------------------------
BYTE UNIX Benchmarks (Version 4.1.0)
System -- Linux access1 2.5.52 #5 Mon Dec 16 15:33:48 IST 2002 i686
unknown Start Benchmark Run: Mon Dec 16 16:50:46 IST 2002 1 interactive
users. 4:50pm  up 1 min,  1 user,  load average: 0.23, 0.09, 0.03
lrwxrwxrwx    1 root     root            4 Oct 22 00:35 /bin/sh -> bash
/bin/sh: symbolic link to bash
/dev/hda2              8262068   3702376   4139996  48% /data

Dhrystone 2 using register variables    1752939.3lps (10.0 secs,10
samples)
Double-Precision Whetstone              477.1 MWIPS  (10.0 secs,10
samples)
System Call Overhead                    464185.6lps  (10.0 secs,10
samples)
Pipe Throughput                         446029.4lps  (10.0 secs,10
samples)
Pipe-based Context Switching            222769.0lps  (10.0 secs,10
samples)
Process Creation                        4319.8 lps   (30.0 secs, 3
samples)
Execl Throughput                        921.1 lps    (29.7 secs, 3
samples)
File Read 1024 bufsize 2000 maxblocks   243106.0KBps (30.0 secs, 3
samples)
File Write 1024 bufsize 2000 maxblocks  97288.0KBps  (30.0 secs, 3
samples)
File Copy 1024 bufsize 2000 maxblocks   68153.0KBps  (30.0 secs, 3
samples)
File Read 256 bufsize 500 maxblocks     112186.0KBps (30.0 secs, 3
samples)
File Write 256 bufsize 500 maxblocks    53099.0KBps  (30.0 secs, 3
samples)
File Copy 256 bufsize 500 maxblocks     33800.0KBps  (30.0 secs, 3
samples)
File Read 4096 bufsize 8000 maxblocks   335995.0KBps (30.0 secs, 3
samples)
File Write 4096 bufsize 8000 maxblocks  125866.0KBps (30.0 secs, 3
samples)
File Copy 4096 bufsize 8000 maxblocks   89049.0KBps  (30.0 secs, 3
samples)
Shell Scripts (1 concurrent)            871.0 lpm    (60.0 secs, 3
samples)
Shell Scripts (8 concurrent)            114.0 lpm    (60.0 secs, 3
samples)
Shell Scripts (16 concurrent)           57.0 lpm     (60.0 secs, 3
samples)
Arithmetic Test (type = short)          208197.8 lps (10.0 secs, 3
samples)
Arithmetic Test (type = int)            225191.0 lps (10.0 secs, 3
samples)
Arithmetic Test (type = long)           225183.4 lps (10.0 secs, 3
samples)
Arithmetic Test (type = float)          227478.4 lps (10.0 secs, 3
samples)
Arithmetic Test (type = double)         227482.6 lps (10.0 secs, 3
samples)
Arithoh                                 3997626.4 lps(10.0 secs, 3
samples)
C Compiler Throughput                   408.7 lpm    (60.0 secs, 3
samples)
Dc: sqrt(2) to 99 decimal places        33040.9 lpm  (30.0 secs, 3
samples)
Recursion Test--Tower of Hanoi          29275.1 lps  (20.0 secs, 3
samples)


                     INDEX VALUES            
TEST                                      BASELINE    RESULT    INDEX

Dhrystone 2 using register variables      116700.0  1752939.3   150.2
Double-Precision Whetstone                55.0      477.1       86.7
Execl Throughput                          43.0      921.1       214.2
File Copy 1024 bufsize 2000 maxblocks     3960.0    68153.0     172.1
File Copy 256 bufsize 500 maxblocks       1655.0    33800.0     204.2
File Copy 4096 bufsize 8000 maxblocks     5800.0    89049.0     153.5
Pipe Throughput                           12440.0   446029.4    358.5
Process Creation                          126.0     4319.8      342.8
Shell Scripts (8 concurrent)              6.0       114.0       190.0
System Call Overhead                      15000.0   464185.6    309.5
                                                               =========
     FINAL SCORE                                                 201.2

------------------------------------------------------------------------
                                    kernel 2.5.52
------------------------------------------------------------------------
BYTE UNIX Benchmarks (Version 4.1.0)
System -- Linux access1 2.5.52 #4 Mon Dec 16 10:16:06 IST 2002 i686
unknown Start Benchmark Run: Mon Dec 16 11:30:24 IST 2002 1 interactive
users. 11:30am up 1:05, 1 user, load average: 0.07, 0.58, 0.79
lrwxrwxrwx 1 root root 4 Oct 22 00:35 /bin/sh -> bash
/bin/sh: symbolic link to bash
/dev/hda2 8262068 3454348 4388024 45% /data
Dhrystone 2 using register variables     1753628.8lps (10.0 secs,10
samples)
Double-Precision Whetstone               476.9 MWIPS  (10.0 secs,10
samples)
System Call Overhead                     450934.1lps  (10.0 secs,10
samples)
Pipe Throughput                          456612.8lps  (10.0 secs,10
samples)
Pipe-based Context Switching             225683.4lps  (10.0 secs,10
samples)
Process Creation                         4275.6 lps   (30.0 secs, 3
samples)
Execl Throughput                         909.8 lps(29.7 secs,3 samples)
File Read 1024 bufsize 2000 maxblocks    244385.0KBps (30.0 secs, 3
samples)
File Write 1024 bufsize 2000 maxblocks   100577.0KBps (30.0
secs, 3 samples)
File Copy 1024 bufsize 2000 maxblocks    70152.0KBps  (30.0 secs, 3
samples)
File Read 256 bufsize 500 maxblocks      111926.0KBps (30.0 secs, 3
samples)
File Write 256 bufsize 500 maxblocks     56243.0KBps  (30.0 secs, 3
samples)
File Copy 256 bufsize 500 maxblocks      35585.0KBps  (30.0 secs, 3
samples)
File Read 4096 bufsize 8000 maxblocks    338086.0KBps (30.0 secs, 3
samples)
File Write 4096 bufsize 8000 maxblocks   126577.0KBps (30.0 secs, 3
samples)
File Copy 4096 bufsize 8000 maxblocks    89815.0KBps  (30.0 secs, 3
samples)
Shell Scripts (1 concurrent)             849.1 lpm    (60.0 secs, 3
samples)
Shell Scripts (8 concurrent)             111.0 lpm    (60.0 secs, 3
samples)
Shell Scripts (16 concurrent)            56.0 lpm     (60.0 secs, 3
samples)
Arithmetic Test (type = short)           208275.8 lps (10.0 secs, 3
samples)
Arithmetic Test (type = int)             225111.9 lps (10.0 secs, 3
samples)
Arithmetic Test (type = long)            225305.4 lps (10.0 secs, 3
samples)
Arithmetic Test (type = float)           227632.9 lps (10.0 secs, 3
samples)
Arithmetic Test (type = double)          227629.5 lps (10.0 secs, 3
samples)
Arithoh                                  3997619.3lps (10.0 secs, 3
samples)
C Compiler Throughput                    408.0 lpm    (60.0 secs, 3
samples)
Dc: sqrt(2) to 99 decimal places         32839.0 lpm  (30.0 secs, 3
samples)
Recursion Test--Tower of Hanoi           29277.5 lps  (20.0 secs, 3
samples)

INDEX VALUES 
TEST                                        BASELINE   RESULT    INDEX
Dhrystone 2 using register variables        116700.0   1753628.8  150.3
Double-Precision Whetstone                  55.0       476.9      86.7
Execl Throughput                            43.0       909.8      211.6
File Copy 1024 bufsize 2000 maxblocks       3960.0     70152.0    177.2
File Copy 256 bufsize 500 maxblocks         1655.0     35585.0    215.0
File Copy 4096 bufsize 8000 maxblocks       5800.0     89815.0    154.9
Pipe Throughput                             12440.0    456612.8   367.1
Process Creation                            126.0      4275.6     339.3
Shell Scripts (8 concurrent)                6.0        111.0      185.0
System Call Overhead                        15000.0    450934.1   300.6
 
=========
FINAL SCORE                                                       201.9
------------------------------------------------------------------------
Regards
 
Sowmya Adiga
Project Engineer
Wipro Technologies
53/1,Hosur Road,Madivala
Bangalore-560 068,INDIA
Tel: +91-80-5502001 Extn.5086
sowmya.adiga@wipro.com
 




