Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262489AbSJPMYL>; Wed, 16 Oct 2002 08:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262492AbSJPMYK>; Wed, 16 Oct 2002 08:24:10 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:9917 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S262489AbSJPMW5>; Wed, 16 Oct 2002 08:22:57 -0400
From: "Pavan Kumar Reddy N.S." <pavan.kumar@wipro.com>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: UnixBench (v4.1.0) preformance results for 2.5 kernel
Date: Wed, 16 Oct 2002 18:04:10 +0530
Message-ID: <003e01c27510$538e0ca0$610b720a@m3xxx101262>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPartTM-000-8203f3e2-01bf-4828-a9ad-161e34e9f549"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

------=_NextPartTM-000-8203f3e2-01bf-4828-a9ad-161e34e9f549
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit



Hi All,

Here are the performance results of latest Linux 2.5 kernel tree using
UnixBench (V4.1.0).

There is a small drop in overall performance from
2.5.42 kernel to 2.5.43 kernel.

Thanks,
pavan.

============================================================================

Test Machine details:
---------------------
processor       : 0 (single processor)
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 10
cpu MHz         : 868.241
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
			cmov pat pse36 mmx fxsr sse
bogomips        : 1716.22

================================================================================
  BYTE UNIX Benchmarks (Version 4.1.0)
  System -- Linux access1 2.5.42 #1 SMP Tue Oct 15 13:06:21 IST 2002 i686 unknown
  Start Benchmark Run: Wed Oct 16 10:19:01 IST 2002
   3 interactive users.
   10:19am  up 14 min,  3 users,  load average: 0.10, 0.04, 0.02
  lrwxrwxrwx    1 root     root            4 Oct  9 23:43 /bin/sh -> bash
  /bin/sh: symbolic link to bash
  /dev/hda3             18073956   3549436  13606408  21% /

Dhrystone 2 using register variables     	1778505.1 lps   (10.0 secs, 10 samples)
Double-Precision Whetstone                474.9 MWIPS     (10.0 secs, 10 samples)
System Call Overhead                     	367334.3 lps    (10.0 secs, 10 samples)
Pipe Throughput                          	329512.3 lps    (10.0 secs, 10 samples)
Pipe-based Context Switching             	137563.4 lps    (10.0 secs, 10 samples)
Process Creation                          2290.0 lps      (30.0 secs, 3 samples)
Execl Throughput                          758.3 lps       (29.8 secs, 3 samples)
File Read 1024 bufsize 2000 maxblocks    	227423.0 KBps   (30.0 secs, 3 samples)
File Write 1024 bufsize 2000 maxblocks    86486.0 KBps   (30.0 secs, 3 samples)
File Copy 1024 bufsize 2000 maxblocks     60017.0 KBps   (30.0 secs, 3 samples)
File Read 256 bufsize 500 maxblocks       98960.0 KBps   (30.0 secs, 3 samples)
File Write 256 bufsize 500 maxblocks      42276.0 KBps   (30.0 secs, 3 samples)
File Copy 256 bufsize 500 maxblocks       27182.0 KBps   (30.0 secs, 3 samples)
File Read 4096 bufsize 8000 maxblocks    	322864.0 KBps  (30.0 secs, 3 samples)
File Write 4096 bufsize 8000 maxblocks   	118133.0 KBps  (30.0 secs, 3 samples)
File Copy 4096 bufsize 8000 maxblocks     83635.0 KBps   (30.0 secs, 3 samples)
Shell Scripts (1 concurrent)              778.8 lpm      (60.0 secs, 3 samples)
Shell Scripts (8 concurrent)              103.3 lpm      (60.0 secs, 3 samples)
Shell Scripts (16 concurrent)             52.0 lpm       (60.0 secs, 3 samples)
Arithmetic Test (type = short)           	203980.5 lps   (10.0 secs, 3 samples)
Arithmetic Test (type = int)             	220317.8 lps   (10.0 secs, 3 samples)
Arithmetic Test (type = long)            	220357.8 lps   (10.0 secs, 3 samples)
Arithmetic Test (type = float)           	222680.3 lps   (10.0 secs, 3 samples)
Arithmetic Test (type = double)          	222759.4 lps   (10.0 secs, 3 samples)
Arithoh                                  	3905145.6lps   (10.0 secs, 3 samples)
C Compiler Throughput                     392.1 lpm      (60.0 secs, 3 samples)
Dc: sqrt(2) to 99 decimal places          26614.0 lpm    (30.0 secs, 3 samples)
Recursion Test--Tower of Hanoi            29664.7 lps    (20.0 secs, 3 samples)


                     INDEX VALUES
	         	   ============

TEST                                  BASELINE   RESULT    	INDEX

Dhrystone 2 using register variables  116700.0  1778505.1  	152.4
Double-Precision Whetstone            55.0      474.9      	86.3
Execl Throughput                      43.0      758.3      	176.3
File Copy 1024 bufsize 2000 maxblocks 3960.0    60017.0    	151.6
File Copy 256 bufsize 500 maxblocks   1655.0    27182.0    	164.2
File Copy 4096 bufsize 8000 maxblocks 5800.0    83635.0     144.2
Pipe Throughput                       12440.0   329512.3   	264.9
Process Creation                      126.0     2290.0     	181.7
Shell Scripts (8 concurrent)          6.0      	103.3      	172.2
System Call Overhead                  15000.0   367334.3   	244.9
                                                           =========
     FINAL SCORE                                        	167.0

=================================================================================

  BYTE UNIX Benchmarks (Version 4.1.0)
  System -- Linux access1 2.5.43 #1 SMP Wed Oct 16 13:12:40 IST 2002 i686 unknown
  Start Benchmark Run: Wed Oct 16 14:15:28 IST 2002
   3 interactive users.
    2:15pm  up 36 min,  3 users,  load average: 0.31, 0.45, 0.66
  lrwxrwxrwx    1 root     root            4 Oct  9 23:43 /bin/sh -> bash
  /bin/sh: symbolic link to bash
  /dev/hda3             18073956   3853188  13302656  23% /


Dhrystone 2 using register variables     1764386.3lps   (10.0 secs, 10 samples)
Double-Precision Whetstone                  474.6 MWIPS (10.0 secs, 10 samples)
System Call Overhead                     371030.5 lps   (10.0 secs, 10 samples)
Pipe Throughput                          320695.5 lps   (10.0 secs, 10 samples)
Pipe-based Context Switching             131501.4 lps   (10.0 secs, 10 samples)
Process Creation                           2353.7 lps   (30.0 secs, 3 samples)
Execl Throughput                            715.2 lps   (29.7 secs, 3 samples)
File Read 1024 bufsize 2000 maxblocks    204907.0 KBps  (30.0 secs, 3 samples)
File Write 1024 bufsize 2000 maxblocks    80629.0 KBps  (30.0 secs, 3 samples)
File Copy 1024 bufsize 2000 maxblocks     53524.0 KBps  (30.0 secs, 3 samples)
File Read 256 bufsize 500 maxblocks       87657.0 KBps  (30.0 secs, 3 samples)
File Write 256 bufsize 500 maxblocks      33733.0 KBps  (30.0 secs, 3 samples)
File Copy 256 bufsize 500 maxblocks       23382.0 KBps  (30.0 secs, 3 samples)
File Read 4096 bufsize 8000 maxblocks    277771.0 KBps  (30.0 secs, 3 samples)
File Write 4096 bufsize 8000 maxblocks   104468.0 KBps  (30.0 secs, 3 samples)
File Copy 4096 bufsize 8000 maxblocks     78163.0 KBps  (30.0 secs, 3 samples)
Shell Scripts (1 concurrent)                779.2 lpm   (60.0 secs, 3 samples)
Shell Scripts (8 concurrent)                102.0 lpm   (60.0 secs, 3 samples)
Shell Scripts (16 concurrent)                52.0 lpm   (60.0 secs, 3 samples)
Arithmetic Test (type = short)           202697.9 lps   (10.0 secs, 3 samples)
Arithmetic Test (type = int)             220528.6 lps   (10.0 secs, 3 samples)
Arithmetic Test (type = long)            219973.2 lps   (10.0 secs, 3 samples)
Arithmetic Test (type = float)           221995.1 lps   (10.0 secs, 3 samples)
Arithmetic Test (type = double)          222824.0 lps   (10.0 secs, 3 samples)
Arithoh                                  3909486.7lps   (10.0 secs, 3 samples)
C Compiler Throughput                       387.4 lpm   (60.0 secs, 3 samples)
Dc: sqrt(2) to 99 decimal places          26594.8 lpm   (30.0 secs, 3 samples)
Recursion Test--Tower of Hanoi            29728.3 lps   (20.0 secs, 3 samples)


                     INDEX VALUES
		     ============
TEST                                        BASELINE     RESULT      INDEX

Dhrystone 2 using register variables        116700.0  1764386.3      151.2
Double-Precision Whetstone                      55.0      474.6       86.3
Execl Throughput                                43.0      715.2      166.3
File Copy 1024 bufsize 2000 maxblocks         3960.0    53524.0      135.2
File Copy 256 bufsize 500 maxblocks           1655.0    23382.0      141.3
File Copy 4096 bufsize 8000 maxblocks         5800.0    78163.0      134.8
Pipe Throughput                              12440.0   320695.5      257.8
Process Creation                               126.0     2353.7      186.8
Shell Scripts (8 concurrent)                     6.0      102.0      170.0
System Call Overhead                         15000.0   371030.5      247.4
                                                                  =========
     FINAL SCORE                                                     160.4

===============================================================================
============================================ 

PAVAN KUMAR REDDY N.S. 
Sr.Software Engineer
Wipro Technologies
53/1, Hosur road, Madivala 
Bangalore - 68. 
Phone Off: +91-80-5502001-8 extn: 6087. 
      Res: +91-80-6685179
http://www.wipro.com/linux/

============================================  


------=_NextPartTM-000-8203f3e2-01bf-4828-a9ad-161e34e9f549
Content-Type: text/plain;
	name="Wipro_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Wipro_Disclaimer.txt"

**************************Disclaimer**************************************************    
 
 Information contained in this E-MAIL being proprietary to Wipro Limited is 'privileged' 
and 'confidential' and intended for use only by the individual or entity to which it is 
addressed. You are notified that any use, copying or dissemination of the information 
contained in the E-MAIL in any manner whatsoever is strictly prohibited.

****************************************************************************************

------=_NextPartTM-000-8203f3e2-01bf-4828-a9ad-161e34e9f549--
