Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262040AbTANJjS>; Tue, 14 Jan 2003 04:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262089AbTANJjS>; Tue, 14 Jan 2003 04:39:18 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:22405 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S262040AbTANJjL>; Tue, 14 Jan 2003 04:39:11 -0500
From: "Sowmya Adiga" <sowmya.adiga@wipro.com>
To: <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK]unixbench result for kernel 2.5.57.
Date: Tue, 14 Jan 2003 15:17:50 +0530
Message-ID: <00d101c2bbb2$006afea0$6009720a@wipro.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
x-mimeole: Produced By Microsoft MimeOLE V6.00.2462.0000
Importance: Normal
X-OriginalArrivalTime: 14 Jan 2003 09:47:50.0535 (UTC) FILETIME=[006A8970:01C2BBB2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	
		Here are the unixbench result for kernel 2.5.57. when
compared with kernel 2.5.56 there was no significant differnece in the
test results.
------------------------------------------------------------------------
----
					kernel-2.5.57
------------------------------------------------------------------------
----
BYTE UNIX Benchmarks (Version 4.1.0)
System -- Linux access1 2.5.57 #12 Tue Jan 14 11:07:28 IST 2003 i686
unknown
Start Benchmark Run: Tue Jan 14 13:31:27 IST 2003
1 interactive users.
1:31pm  up 1 min,  1 user,  load average: 0.11, 0.06, 0.02
lrwxrwxrwx    1 root     root            4 Oct 22 00:35 /bin/sh -> bash
/bin/sh: symbolic link to bash
/dev/hda2              8262068   4050612   3791760  52% /data

Dhrystone 2 using register variables     1804903.8 lps (10.0
secs,10samples)
Double-Precision Whetstone               476.7MWIPS    (10.0
secs,10samples)
System Call Overhead                     459625.8 lps  (10.0
secs,10samples)
Pipe Throughput                          457011.3 lps  (10.0
secs,10samples)
Pipe-based Context Switching             207980.3 lps  (10.0
secs,10samples)
Process Creation                         4330.5 lps    (30.0 secs,
3samples)
Execl Throughput                         906.9 lps     (29.9 secs,
3samples)
File Read 1024 bufsize 2000 maxblocks    244767.0 KBps (30.0 secs,
3samples)
File Write 1024 bufsize 2000 maxblocks   102066.0 KBps (30.0 secs,
3samples)
File Copy 1024 bufsize 2000 maxblocks    69843.0 KBps  (30.0 secs,
3samples)
File Read 256 bufsize 500 maxblocks      113751.0 KBps (30.0 secs,
3samples)
File Write 256 bufsize 500 maxblocks     58411.0 KBps  (30.0 secs,
3samples)
File Copy 256 bufsize 500 maxblocks      35238.0 KBps  (30.0 secs,
3samples)
File Read 4096 bufsize 8000 maxblocks    336516.0 KBps (30.0 secs,
3samples)
File Write 4096 bufsize 8000 maxblocks   127644.0 KBps (30.0 secs,
3samples)
File Copy 4096 bufsize 8000 maxblocks    89810.0 KBps  (30.0 secs,
3samples)
Shell Scripts (1 concurrent)             882.3 lpm     (60.0 secs,
3samples)
Shell Scripts (8 concurrent)             115.0 lpm     (60.0 secs,
3samples)
Shell Scripts (16 concurrent)            58.0 lpm      (60.0 secs,
3samples)
Arithmetic Test (type = short)           208139.7 lps  (10.0 secs,
3samples)
Arithmetic Test (type = int)             225297.5 lps  (10.0 secs,
3samples)
Arithmetic Test (type = long)            225169.4 lps  (10.0 secs,
3samples)
Arithmetic Test (type = float)           227413.2 lps  (10.0 secs,
3samples)
Arithmetic Test (type = double)          227410.3 lps  (10.0 secs,
3samples)
Arithoh                                  3995188.9 lps (10.0 secs,
3samples)
C Compiler Throughput                    408.7 lpm     (60.0 secs,
3samples)
Dc: sqrt(2) to 99 decimal places         34768.0 lpm   (30.0 secs,
3samples)
Recursion Test--Tower of Hanoi           28917.6 lps   (20.0 secs,
3samples)


                     INDEX VALUES            
TEST                                       BASELINE     RESULT     INDEX

Dhrystone 2 using register variables       116700.0   1804903.8    154.7
Double-Precision Whetstone                 55.0       476.7        86.7
Execl Throughput                           43.0       906.9        210.9
File Copy 1024 bufsize 2000 maxblocks      3960.0     69843.0      176.4
File Copy 256 bufsize 500 maxblocks        1655.0     35238.0      212.9
File Copy 4096 bufsize 8000 maxblocks      5800.0     89810.0      154.8
Pipe Throughput                            12440.0    457011.3     367.4
Process Creation                           126.0      4330.5       343.7
Shell Scripts (8 concurrent)               6.0        115.0        191.7
System Call Overhead                       15000.0    459625.8     306.4
 
=========
     FINAL SCORE                                                   203.5
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

