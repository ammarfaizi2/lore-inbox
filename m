Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264908AbSLPDgM>; Sun, 15 Dec 2002 22:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264910AbSLPDgM>; Sun, 15 Dec 2002 22:36:12 -0500
Received: from wiprom2mx2.wipro.com ([203.197.164.42]:63893 "EHLO
	wiprom2mx2.wipro.com") by vger.kernel.org with ESMTP
	id <S264908AbSLPDgI>; Sun, 15 Dec 2002 22:36:08 -0500
From: "Sowmya Adiga" <sowmya.adiga@wipro.com>
To: <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] unixbench result for kernel 2.5.49 and 2.5.50
Date: Mon, 16 Dec 2002 09:13:49 +0530
Organization: Wipro Technologies
Message-ID: <008901c2a4b5$5860cd10$6009720a@wipro.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Importance: Normal
X-OriginalArrivalTime: 16 Dec 2002 03:43:49.0891 (UTC) FILETIME=[5865FD30:01C2A4B5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are the unixbench result for kernel 2.5.49 and 2.5.50.kernel 2.5.50
performed better than kernel 2.5.49
________________________________________________________________________
_
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
pat pse36 mmx fxsr sse bogomips : 1716.22
------------------------------------------------------------------------
                            kernel 2.5.49
------------------------------------------------------------------------

BYTE UNIX Benchmarks (Version 4.1.0)
System -- Linux access1 2.5.49 #1 SMP Mon Dec 2 11:56:05 IST 2002 i686
unknown Start Benchmark Run: Mon Dec  2 13:38:54 IST 2002 1 interactive
users. 1:38pm  up  1:24,  1 user,  load average: 0.08, 0.02, 0.33
lrwxrwxrwx    1 root     root            4 Oct 22 00:35 /bin/sh -> bash
/bin/sh: symbolic link to bash
/dev/hda2              8262068   3346524   4495848  43% /data

Dhrystone 2 using register variables  1751221.2 lps   (10.0
secs,10samples)
Double-Precision Whetstone            476.4 MWIPS (10.0 secs, 10
samples)
System Call Overhead                  387799.8 lps   (10.0 secs, 10
samples)
Pipe Throughput                       297137.7 lps   (10.0 secs, 10
samples)
Pipe-based Context Switching          133589.7 lps   (10.0 secs, 10
samples)
Process Creation                      2629.1 lps   (30.0 secs, 3
samples)
Execl Throughput                      762.6 lps   (29.7 secs, 3 samples)
File Read 1024 bufsize 2000 maxblocks 215019.0 KBps  (30.0 secs, 3
samples)
File Write 1024 bufsize 2000 maxblocks 85866.0 KBps  (30.0 secs, 3
samples)
File Copy 1024 bufsize 2000 maxblocks  59746.0 KBps  (30.0 secs, 3
samples)
File Read 256 bufsize 500 maxblocks    93782.0 KBps  (30.0 secs, 3
samples)
File Write 256 bufsize 500 maxblocks   40861.0 KBps  (30.0 secs, 3
samples)
File Copy 256 bufsize 500 maxblocks    26811.0 KBps  (30.0 secs, 3
samples)
File Read 4096 bufsize 8000 maxblocks  314438.0 KBps  (30.0 secs, 3
samples)
File Write 4096 bufsize 8000 maxblocks 118311.0 KBps  (30.0 secs, 3
samples)
File Copy 4096 bufsize 8000 maxblocks  84267.0 KBps  (30.0 secs, 3
samples)
Shell Scripts (1 concurrent)           774.8 lpm   (60.0 secs, 3
samples)
Shell Scripts (8 concurrent)           102.0 lpm   (60.0 secs, 3
samples)
Shell Scripts (16 concurrent)          51.0 lpm   (60.0 secs, 3 samples)
Arithmetic Test (type = short)         207940.3 lps   (10.0 secs, 3
samples)
Arithmetic Test (type = int)           224781.5 lps   (10.0 secs, 3
samples)
Arithmetic Test (type = long)          224799.1 lps   (10.0 secs, 3
samples)
Arithmetic Test (type = float)         227188.4 lps   (10.0 secs, 3
samples)
Arithmetic Test (type = double)        227188.4 lps   (10.0 secs, 3
samples)
Arithoh                                3991197.7 lps   (10.0 secs,3
samples)
C Compiler Throughput                  393.7 lpm   (60.0 secs, 3
samples)
Dc: sqrt(2) to 99 decimal places       27072.3 lpm   (30.0 secs, 3
samples)
Recursion Test--Tower of Hanoi         29236.6 lps   (20.0 secs, 3
samples)


                     INDEX VALUES            
TEST                                    BASELINE     RESULT      INDEX

Dhrystone 2 using register variables    116700.0     1751221.2   150.1
Double-Precision Whetstone              55.0         476.4       86.6
Execl Throughput                        43.0         762.6       177.3
File Copy 1024 bufsize 2000 maxblocks   3960.0       59746.0     150.9
File Copy 256 bufsize 500 maxblocks     1655.0       26811.0     162.0
File Copy 4096 bufsize 8000 maxblocks   5800.0       84267.0     145.3
Pipe Throughput                         12440.0      297137.7    238.9
Process Creation                        126.0        2629.1      208.7
Shell Scripts (8 concurrent)            6.0          102.0       170.0
System Call Overhead                    15000.0      387799.8    258.5
 
                                                               =========
     FINAL SCORE                                                 168.0

------------------------------------------------------------------------
                               kernel 2.5.50
------------------------------------------------------------------------

BYTE UNIX Benchmarks (Version 4.1.0)
System -- Linux access1 2.5.50 #2 Fri Nov 29 09:46:11 IST 2002 i686
unknown Start Benchmark Run: Mon Dec  2 14:45:21 IST 2002 1 interactive
users. 2:45pm  up 4 min,  1 user,  load average: 0.02, 0.06, 0.02
lrwxrwxrwx    1 root     root            4 Oct 22 00:35 /bin/sh -> bash
/bin/sh: symbolic link to bash
/dev/hda2              8262068   3346580   4495792  43% /data

Dhrystone 2 using register variables  1753505.2lps(10.0 secs, 10samples)
Double-Precision Whetstone            477.0 MWIPS (10.0 secs, 10
samples)
System Call Overhead                  448722.4 lps(10.0 secs, 10
samples)
Pipe Throughput                       450494.7 lps(10.0 secs, 10
samples)
Pipe-based Context Switching          211149.3 lps(10.0 secs, 10
samples)
Process Creation                      3455.6 lps  (30.0 secs, 3 samples)
Execl Throughput                      923.2 lps   (29.9 secs, 3 samples)
File Read 1024 bufsize 2000 maxblocks 245865.0 KBps(30.0 secs, 3
samples)
File Write 1024 bufsize 2000 maxblocks 98599.0 KBps(30.0 secs, 3
samples)
File Copy 1024 bufsize 2000 maxblocks  69290.0 KBps(30.0 secs, 3
samples)
File Read 256 bufsize 500 maxblocks    112302.0KBps(30.0 secs, 3
samples)
File Write 256 bufsize 500 maxblocks   54638.0 KBps(30.0 secs,3 samples)
File Copy 256 bufsize 500 maxblocks    34567.0 KBps(30.0 secs, 3
samples)
File Read 4096 bufsize 8000 maxblocks  338340.0 KBps(30.0 secs,3
samples)
File Write 4096 bufsize 8000 maxblocks 124977.0 KBps(30.0 secs,3
samples)
File Copy 4096 bufsize 8000 maxblocks  90024.0 KBps (30.0 secs,3
samples)
Shell Scripts (1 concurrent)           864.8 lpm    (60.0 secs, 3
samples)
Shell Scripts (8 concurrent)           113.0 lpm    (60.0 secs, 3
samples)
Shell Scripts (16 concurrent)          57.0 lpm     (60.0 secs, 3
samples)
Arithmetic Test (type = short)         208274.2 lps (10.0 secs, 3
samples)
Arithmetic Test (type = int)           225446.1 lps (10.0 secs, 3
samples)
Arithmetic Test (type = long)          225107.6 lps (10.0 secs, 3
samples)
Arithmetic Test (type = float)         227482.4 lps (10.0 secs, 3
samples)
Arithmetic Test (type = double)        227482.7 lps (10.0 secs, 3
samples)
Arithoh                                3996457.3 lps(10.0 secs,3
samples)
C Compiler Throughput                  409.7 lpm   (60.0 secs, 3
samples)
Dc: sqrt(2) to 99 decimal places       32708.0 lpm (30.0 secs, 3
samples)
Recursion Test--Tower of Hanoi         29281.3 lps (20.0 secs, 3
samples)


                     INDEX VALUES            
TEST                                   BASELINE     RESULT      INDEX

Dhrystone 2 using register variables   116700.0  1753505.2      150.3
Double-Precision Whetstone             55.0      477.0          86.7
Execl Throughput                       43.0      923.2          214.7
File Copy 1024 bufsize 2000 maxblocks  3960.0    69290.0        175.0
File Copy 256 bufsize 500 maxblocks    1655.0    34567.0        208.9
File Copy 4096 bufsize 8000 maxblocks  5800.0    90024.0        155.2
Pipe Throughput                        12440.0   450494.7       362.1
Process Creation                       126.0     3455.6         274.3
Shell Scripts (8 concurrent)           6.0       113.0          188.3
System Call Overhead                   15000.0   448722.4       299.1
                                                              =========
     FINAL SCORE                                                197.2
________________________________________________________________________

Regards

Sowmya Adiga
Project Engineer
Wipro Technologies
53/1,Hosur Road,Madivala
Bangalore-560 068,INDIA
Tel: +91-80-5502001 Extn.5086
sowmya.adiga@wipro.com

