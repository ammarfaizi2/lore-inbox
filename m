Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261855AbTB0INB>; Thu, 27 Feb 2003 03:13:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261857AbTB0INB>; Thu, 27 Feb 2003 03:13:01 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:40640 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S261855AbTB0IM7>; Thu, 27 Feb 2003 03:12:59 -0500
From: "Sowmya Adiga" <sowmya.adiga@wipro.com>
To: <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK]unixbench result for kernel 2.5.63
Date: Thu, 27 Feb 2003 13:53:00 +0530
Message-ID: <00e701c2de39$70b04ea0$6009720a@wipro.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Importance: Normal
X-OriginalArrivalTime: 27 Feb 2003 08:23:00.0410 (UTC) FILETIME=[70A419A0:01C2DE39]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	There is no much difference when compared with the result of
kernel-2.5.62.
------------------------------------------------------------------------
---
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
---					Kernel-2.5.63
------------------------------------------------------------------------
---
BYTE UNIX Benchmarks (Version 4.1.0)
System -- Linux sowmya 2.5.63 #5 SMP Tue Feb 25 11:30:29 IST 2003 i686
i386 GNU/Linux
Start Benchmark Run: Tue Feb 25 13:12:52 IST 2003
1 interactive users.
1:12pm  up  1:08,  1 user,  load average: 0.09, 0.42, 0.72
lrwxrwxrwx    1 root     root            4 Feb  4 15:21 /bin/sh -> bash
/bin/sh: symbolic link to bash
/dev/hda3              9835584   3144808   6191156  34% /home

Dhrystone 2 using register variables     1821990.3 lps(10.0
secs,10samples)
Double-Precision Whetstone               481.8  MWIPS (10.0
secs,10samples)
System Call Overhead                     394198.6 lps 10.0 secs,
10samples)
Pipe Throughput                          317012.7 lps (10.0
secs,10samples)
Pipe-based Context Switching             138348.2 lps (10.0
secs,10samples)
Process Creation                         5537.0   lps (30.0 secs,
3samples)
Execl Throughput                         1171.9   lps (29.7 secs,
3samples)
File Read 1024 bufsize 2000 maxblocks    218422.0 KBps(30.0 secs,
3samples)
File Write 1024 bufsize 2000 maxblocks   98266.0  KBps(30.0 secs,
3samples)
File Copy 1024 bufsize 2000 maxblocks    65577.0  KBps(30.0 secs,
3samples)
File Read 256 bufsize 500 maxblocks      94202.0  KBps(30.0 secs,
3samples)
File Write 256 bufsize 500 maxblocks     53681.0  KBps(30.0 secs,
3samples)
File Copy 256 bufsize 500 maxblocks      31138.0  KBps(30.0 secs,
3samples)
File Read 4096 bufsize 8000 maxblocks    320458.0 KBps(30.0 secs,
3samples)
File Write 4096 bufsize 8000 maxblocks   125599.0 KBps(30.0 secs,
3samples)
File Copy 4096 bufsize 8000 maxblocks    87666.0  KBps(30.0 secs,
3samples)
Shell Scripts (1 concurrent)             819.3    lpm (60.0 secs,
3samples)
Shell Scripts (8 concurrent)             105.0    lpm (60.0 secs,
3samples)
Shell Scripts (16 concurrent)            53.0     lpm (60.0 secs,
3samples)
Arithmetic Test (type = short)           217590.3 lps (10.0 secs,
3samples)
Arithmetic Test (type = int)             224250.2 lps (10.0 secs,
3samples)
Arithmetic Test (type = long)            224326.6 lps (10.0 secs,
3samples)
Arithmetic Test (type = float)           227452.9 lps (10.0 secs,
3samples)
Arithmetic Test (type = double)          227534.4 lps (10.0 secs,
3samples)
Arithoh                                  3991475.0 lps(10.0 secs,
3samples)
C Compiler Throughput                    362.0     lpm(60.0 secs,
3samples)
Dc: sqrt(2) to 99 decimal places         38165.8   lpm(30.0 secs,
3samples)
Recursion Test--Tower of Hanoi           32017.7   lps(20.0 secs,
3samples)


                     INDEX VALUES            
TEST                                       BASELINE     RESULT    INDEX

Dhrystone 2 using register variables        116700.0  1821990.3    156.1
Double-Precision Whetstone                  55.0      481.8        87.6
Execl Throughput                            43.0      1171.9       272.5
File Copy 1024 bufsize 2000 maxblocks       3960.0    65577.0      165.6
File Copy 256 bufsize 500 maxblocks         1655.0    31138.0      188.1
File Copy 4096 bufsize 8000 maxblocks       5800.0    87666.0      151.1
Pipe Throughput                             12440.0   317012.7     254.8
Process Creation                            126.0     5537.0       439.4
Shell Scripts (8 concurrent)                6.0       105.0        175.0
System Call Overhead                        15000.0   394198.6     262.8
 
=========
     FINAL SCORE                                                   197.5

------------------------------------------------------------------------
---Regards
 
Sowmya Adiga
Project Engineer
Wipro Technologies
53/1,Hosur Road,Madivala
Bangalore-560 068,INDIA
Tel: +91-80-5502001 Extn.5086

