Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262317AbTAIJ3j>; Thu, 9 Jan 2003 04:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262326AbTAIJ3j>; Thu, 9 Jan 2003 04:29:39 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:1670 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S262317AbTAIJ3g>; Thu, 9 Jan 2003 04:29:36 -0500
From: "Sowmya Adiga" <sowmya.adiga@wipro.com>
To: <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK]unixbench result for kernel 2.5.55.
Date: Thu, 9 Jan 2003 15:08:04 +0530
Message-ID: <007e01c2b7c2$cec683d0$6009720a@wipro.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
x-mimeole: Produced By Microsoft MimeOLE V6.00.2462.0000
Importance: Normal
X-OriginalArrivalTime: 09 Jan 2003 09:38:04.0023 (UTC) FILETIME=[CEC32870:01C2B7C2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	Here are the unixbench result for kernel 2.5.55. when compared
with kernel 2.5.54 there was no significant differnece in the test
results.
	
------------------------------------------------------------------------
----
					kernel 2.5.55
------------------------------------------------------------------------
----

BYTE UNIX Benchmarks (Version 4.1.0)
System -- Linux access1 2.5.55 #10 Thu Jan 9 10:29:24 IST 2003 i686
unknown
Start Benchmark Run: Thu Jan  9 11:57:05 IST 2003
1 interactive users.
11:57am  up 1 min,  1 user,  load average: 0.13, 0.08, 0.03
lrwxrwxrwx    1 root     root            4 Oct 22 00:35 /bin/sh ->
bash/bin/sh: symbolic link to bash
/dev/hda2              8262068   3815592   4026780  49% /data

Dhrystone 2 using register variables     1804749.6lps (10.0 secs,10
samples)
Double-Precision Whetstone               476.9 MWIPS  (10.0 secs,10
samples)
System Call Overhead                     449629.7lps  (10.0 secs,10
samples)
Pipe Throughput                          450120.7 lps (10.0 secs,10
samples)
Pipe-based Context Switching             201606.5 lps (10.0 secs,10
samples)
Process Creation                         4297.4 lps   (30.0 secs, 3
samples)
Execl Throughput                         899.9 lps    (30.0 secs, 3
samples)
File Read 1024 bufsize 2000 maxblocks    243970.0KBps (30.0 secs, 3
samples)
File Write 1024 bufsize 2000 maxblocks   96131.0 KBps (30.0 secs, 3
samples)
File Copy 1024 bufsize 2000 maxblocks    67314.0 KBps (30.0 secs, 3
samples)
File Read 256 bufsize 500 maxblocks      112911.0KBps (30.0 secs, 3
samples)
File Write 256 bufsize 500 maxblocks     52060.0KBps  (30.0 secs, 3
samples)
File Copy 256 bufsize 500 maxblocks      32760.0 KBps (30.0 secs, 3
samples)
File Read 4096 bufsize 8000 maxblocks    336476.0KBps (30.0 secs, 3
samples)
File Write 4096 bufsize 8000 maxblocks   124355.0KBps (30.0 secs, 3
samples)
File Copy 4096 bufsize 8000 maxblocks    89195.0 KBps (30.0 secs, 3
samples)
Shell Scripts (1 concurrent)             892.4 lpm    (60.0 secs, 3
samples)
Shell Scripts (8 concurrent)             116.0 lpm    (60.0 secs, 3
samples)
Shell Scripts (16 concurrent)            58.0 lpm     (60.0 secs, 3
samples)
Arithmetic Test (type = short)           208076.5lps  (10.0 secs, 3
samples)
Arithmetic Test (type = int)             225163.1lps  (10.0 secs, 3
samples)
Arithmetic Test (type = long)            225115.3lps  (10.0 secs, 3
samples)
Arithmetic Test (type = float)           227406.3lps  (10.0 secs, 3
samples)
Arithmetic Test (type = double)          227413.1lps  (10.0 secs, 3
samples)
Arithoh                                  3996379.5lps (10.0 secs, 3
samples)
C Compiler Throughput                    409.0 lpm    (60.0 secs, 3
samples)
Dc: sqrt(2) to 99 decimal places         34733.6 lpm  (30.0 secs, 3
samples)
Recursion Test--Tower of Hanoi           28911.6 lps  (20.0 secs, 3
samples)


                     INDEX VALUES            
TEST                                      BASELINE     RESULT      INDEX

Dhrystone 2 using register variables      116700.0   1804749.6     154.6
Double-Precision Whetstone                55.0       476.9         86.7
Execl Throughput                          43.0       899.9         209.3
File Copy 1024 bufsize 2000 maxblocks     3960.0     67314.0       170.0
File Copy 256 bufsize 500 maxblocks       1655.0     32760.0       197.9
File Copy 4096 bufsize 8000 maxblocks     5800.0     89195.0       153.8
Pipe Throughput                           12440.0    450120.7      361.8
Process Creation                          126.0      4297.4        341.1
Shell Scripts (8 concurrent)              6.0        116.0         193.3
System Call Overhead                      15000.0    449629.7      299.8
 
=========
     FINAL SCORE                                                   200.3
------------------------------------------------------------------------
----Regards
 
Sowmya Adiga
Project Engineer
Wipro Technologies
53/1,Hosur Road,Madivala
Bangalore-560 068,INDIA
Tel: +91-80-5502001 Extn.5086
sowmya.adiga@wipro.com

