Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262498AbSJPMZ6>; Wed, 16 Oct 2002 08:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262484AbSJPMY3>; Wed, 16 Oct 2002 08:24:29 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:56764 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S262488AbSJPMVy>; Wed, 16 Oct 2002 08:21:54 -0400
From: "Pavan Kumar Reddy N.S." <pavan.kumar@wipro.com>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: UnixBench (v4.1.0) preformance results for 2.4 kernel
Date: Wed, 16 Oct 2002 18:03:06 +0530
Message-ID: <003d01c27510$2dc559b0$610b720a@m3xxx101262>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPartTM-000-e9e97db4-3180-40c3-b6e3-110558906e43"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

------=_NextPartTM-000-e9e97db4-3180-40c3-b6e3-110558906e43
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit



Hi All,

Here are the performance results of latest Linux 2.4 kernel tree using
UnixBench (V4.1.0).

There is a small increase in overall performance from
2.4.18-3(RedHat Linux 7.3) kernel to 2.4.20-pre10 kernel.

Any comments...

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
===============================================================================

  BYTE UNIX Benchmarks (Version 4.1.0)
  System -- Linux access1 2.4.18-3 #1 Thu Apr 18 07:37:53 EDT 2002 i686 unknown
  Start Benchmark Run: Tue Oct 15 20:04:50 IST 2002
   3 interactive users.
   8:04pm  up  1:17,  3 users,  load average: 0.34, 0.16, 0.06
  lrwxrwxrwx    1 root     root            4 Oct  9 23:43 /bin/sh -> bash
  /bin/sh: symbolic link to bash
  /dev/hda3             18073956   2894812  14261032  17% /

Dhrystone 2 using register variables     1807049.7 lps   (10.0 secs, 10 samples)
Double-Precision Whetstone                   476.2 MWIPS (10.0 secs, 10 samples)
System Call Overhead                     	443240.9 lps   (10.0 secs, 10 samples)
Pipe Throughput                          	512417.1 lps   (10.0 secs, 10 samples)
Pipe-based Context Switching             	250704.4 lps   (10.0 secs, 10 samples)
Process Creation                         	  6601.9 lps   (30.0 secs, 3 samples)
Execl Throughput                            1536.1 lps   (29.7 secs, 3 samples)
File Read 1024 bufsize 2000 maxblocks  	250124.0 KBps  (30.0 secs, 3 samples)
File Write 1024 bufsize 2000 maxblocks  	 95888.0 KBps  (30.0 secs, 3 samples)
File Copy 1024 bufsize 2000 maxblocks  	 67847.0 KBps  (30.0 secs, 3 samples)
File Read 256 bufsize 500 maxblocks     	122836.0 KBps  (30.0 secs, 3 samples)
File Write 256 bufsize 500 maxblocks    	 50834.0 KBps  (30.0 secs, 3 samples)
File Copy 256 bufsize 500 maxblocks     	 33500.0 KBps  (30.0 secs, 3 samples)
File Read 4096 bufsize 8000 maxblocks  	350145.0 KBps  (30.0 secs, 3 samples)
File Write 4096 bufsize 8000 maxblocks  	118398.0 KBps  (30.0 secs, 3 samples)
File Copy 4096 bufsize 8000 maxblocks   	 85544.0 KBps  (30.0 secs, 3 samples)
Shell Scripts (1 concurrent)                1156.2 lpm   (60.0 secs, 3 samples)
Shell Scripts (8 concurrent)                 149.0 lpm   (60.0 secs, 3 samples)
Shell Scripts (16 concurrent)                 73.7 lpm   (60.0 secs, 3 samples)
Arithmetic Test (type = short)           	208087.1 lps   (10.0 secs, 3 samples)
Arithmetic Test (type = int)             	225243.8 lps   (10.0 secs, 3 samples)
Arithmetic Test (type = long)            	225229.1 lps   (10.0 secs, 3 samples)
Arithmetic Test (type = float)           	227202.8 lps   (10.0 secs, 3 samples)
Arithmetic Test (type = double)          	227298.7 lps   (10.0 secs, 3 samples)
Arithoh                                  	3901181.6lps   (10.0 secs, 3 samples)
C Compiler Throughput                        450.4 lpm   (60.0 secs, 3 samples)
Dc: sqrt(2) to 99 decimal places           56943.1 lpm   (30.0 secs, 3 samples)
Recursion Test--Tower of Hanoi             29804.5 lps   (20.0 secs, 3 samples)


                     INDEX VALUES
                     ============
TEST                                       BASELINE   RESULT    	INDEX

Dhrystone 2 using register variables       116700.0  	1807049.7	154.8
Double-Precision Whetstone                     55.0       476.2  	 86.6
Execl Throughput                               43.0      1536.1  	357.2
File Copy 1024 bufsize 2000 maxblocks  	   3960.0     67847.0  	171.3
File Copy 256 bufsize 500 maxblocks     	   1655.0     33500.0   202.4
ipe Throughput                              12440.0    512417.1   411.9
Process Creation                              126.0      6601.9   524.0
Shell Scripts (8 concurrent)                    6.0       149.0   248.3
System Call Overhead                        15000.0    443240.9   295.5
                                                         	     =========
     FINAL SCORE                                            	228.5

===================================================================================
  BYTE UNIX Benchmarks (Version 4.1.0)
  System -- Linux access1 2.4.20-pre10 #1 SMP Fri Oct 11 14:08:36 IST 2002 i686 unknown
  Start Benchmark Run: Wed Oct 16 11:41:59 IST 2002
   3 interactive users.
   11:41am  up 3 min,  3 users,  load average: 0.23, 0.14, 0.05
  lrwxrwxrwx    1 root     root            4 Oct  9 23:43 /bin/sh -> bash
  /bin/sh: symbolic link to bash
  /dev/hda3             18073956   3549616  13606228  21% /

Dhrystone 2 using register variables     1816447.2lps   (10.0 secs, 10 samples)
Double-Precision Whetstone                  482.0 MWIPS (10.1 secs, 10 samples)
System Call Overhead                     389477.1 lps   (10.0 secs, 10 samples)
Pipe Throughput                          399735.9 lps   (10.0 secs, 10 samples)
Pipe-based Context Switching             157074.9 lps   (10.0 secs, 10 samples)
Process Creation                           6372.2 lps   (30.0 secs, 3 samples)
Execl Throughput                           1510.6 lps   (29.8 secs, 3 samples)
File Read 1024 bufsize 2000 maxblocks    245802.0 KBps  (30.0 secs, 3 samples)
File Write 1024 bufsize 2000 maxblocks   123029.0 KBps  (30.0 secs, 3 samples)
File Copy 1024 bufsize 2000 maxblocks     82358.0 KBps  (30.0 secs, 3 samples)
File Read 256 bufsize 500 maxblocks      110655.0 KBps  (30.0 secs, 3 samples)
File Write 256 bufsize 500 maxblocks      90216.0 KBps  (30.0 secs, 3 samples)
File Copy 256 bufsize 500 maxblocks       48883.0 KBps  (30.0 secs, 3 samples)
File Read 4096 bufsize 8000 maxblocks    346073.0 KBps  (30.0 secs, 3 samples)
File Write 4096 bufsize 8000 maxblocks   140089.0 KBps  (30.0 secs, 3 samples)
File Copy 4096 bufsize 8000 maxblocks     98835.0 KBps  (30.0 secs, 3 samples)
Shell Scripts (1 concurrent)               1200.2 lpm   (60.0 secs, 3 samples)
Shell Scripts (8 concurrent)                160.7 lpm   (60.0 secs, 3 samples)
Shell Scripts (16 concurrent)                80.7 lpm   (60.0 secs, 3 samples)
Arithmetic Test (type = short)           208417.3 lps   (10.0 secs, 3 samples)
Arithmetic Test (type = int)             225025.9 lps   (10.0 secs, 3 samples)
Arithmetic Test (type = long)            224585.0 lps   (10.0 secs, 3 samples)
Arithmetic Test (type = float)           227383.0 lps   (10.0 secs, 3 samples)
Arithmetic Test (type = double)          227050.9 lps   (10.0 secs, 3 samples)
Arithoh                                  3971520.4lps   (10.0 secs, 3 samples)
C Compiler Throughput                       449.4 lpm   (60.0 secs, 3 samples)
Dc: sqrt(2) to 99 decimal places          50269.5 lpm   (30.0 secs, 3 samples)
Recursion Test--Tower of Hanoi            24576.6 lps   (20.0 secs, 3 samples)


                     INDEX VALUES
		         ============
TEST                                        BASELINE     RESULT      INDEX

Dhrystone 2 using register variables        116700.0  1816447.2      155.7
Double-Precision Whetstone                      55.0      482.0       87.6
Execl Throughput                                43.0     1510.6      351.3
File Copy 1024 bufsize 2000 maxblocks         3960.0    82358.0      208.0
File Copy 256 bufsize 500 maxblocks           1655.0    48883.0      295.4
File Copy 4096 bufsize 8000 maxblocks         5800.0    98835.0      170.4
Pipe Throughput                              12440.0   399735.9      321.3
Process Creation                               126.0     6372.2      505.7
Shell Scripts (8 concurrent)                     6.0      160.7      267.8
System Call Overhead                         15000.0   389477.1      259.7
                                                                  =========
     FINAL SCORE                                                     237.3

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

------=_NextPartTM-000-e9e97db4-3180-40c3-b6e3-110558906e43
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

------=_NextPartTM-000-e9e97db4-3180-40c3-b6e3-110558906e43--
