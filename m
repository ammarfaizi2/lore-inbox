Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261585AbSJQMXi>; Thu, 17 Oct 2002 08:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261588AbSJQMXi>; Thu, 17 Oct 2002 08:23:38 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:4747 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S261585AbSJQMX0>; Thu, 17 Oct 2002 08:23:26 -0400
From: "Saji Kumar VR" <saji.kumar@wipro.com>
To: "Ltp-Results" <ltp-results@lists.sourceforge.net>
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: [Ltp-results] 2.5.43 -- ltp-20021008 -- 12 hours -- runalltests : Pass 98.89%
Date: Thu, 17 Oct 2002 18:00:38 +0530
Message-ID: <PCENKBHIJBDCDPIIAICPAEOKCBAA.saji.kumar@wipro.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPartTM-000-c48256a6-d01d-415d-8f75-6aa91ef6e171"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

------=_NextPartTM-000-c48256a6-d01d-415d-8f75-6aa91ef6e171
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

System Configuration
====================

Red Hat Linux release 7.1 (Seawolf)
Linux  2.5.43 #2 Wed Oct 16 15:42:53 IST 2002 i686 unknown

Gnu C                  2.96
Gnu make               3.79.1
binutils               2.10.91.0.2
util-linux             2.10s
mount                  2.10r
modutils               2.4.2
e2fsprogs              1.19
Linux C Library        2.2.2
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.57
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         tulip

free -m reports:
             total       used       free     shared    buffers     cached
Mem:            59         57          1          0          1         23
-/+ buffers/cache:         31         27
Swap:          305         15        290

/proc/cpuinfo
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 5
model name	: Pentium II (Deschutes)
stepping	: 2
cpu MHz		: 349.409
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36
mmx fxsr
bogomips	: 690.17

Failed tests
============

nanosleep02 	(11/11)
personality02	(11/11)
pread02		(11/11)
pwrite02 	(11/11)
readv02		(11/11)
writev01	(11/11)
sem02		(11/11)

Detailed output for failed tests
================================

<<<test_start>>>
tag=nanosleep02 stime=1034771944
cmdline="nanosleep02"
contacts=""
analysis=exit
initiation_status="ok"
<<<test_output>>>
nanosleep02    1  FAIL  :  Remaining sleep time 4001000 usec doesn't match
with
the expected 3999665 usec time
nanosleep02    1  FAIL  :  child process exited abnormally
<<<execution_status>>>
duration=1 termination_type=exited termination_id=1 corefile=no
cutime=1 cstime=0
<<<test_end>>>

<<<test_start>>>
tag=personality02 stime=1034771951
cmdline="personality02"
contacts=""
analysis=exit
initiation_status="ok"
<<<test_output>>>
personality02    1  FAIL  :  call failed - errno = 0 - Success
<<<execution_status>>>
duration=1 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=1
<<<test_end>>>

<<<test_start>>>
tag=pread02 stime=1034771957
cmdline="pread02"
contacts=""
analysis=exit
initiation_status="ok"
<<<test_output>>>
pread02     1  PASS  :  pread() fails, file descriptor is a PIPE or FIFO,
errno:29
pread02     2  FAIL  :  pread() returned 0, expected -1, errno:22
<<<execution_status>>>
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=0
<<<test_end>>>

pwrite02    1  PASS  :  file descriptor is a PIPE or FIFO, errno:29
caught SIGXFSZ
pwrite02    2  FAIL  :  specified offset is -ve or invalid, unexpected
errno:27, expected:22
pwrite02    3  PASS  :  file descriptor is bad, errno:9
<<<test_start>>>
tag=pwrite02 stime=1034771957
cmdline="pwrite02"
contacts=""
analysis=exit
initiation_status="ok"
<<<test_output>>>
<<<execution_status>>>
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=1
<<<test_end>>>

readv02     1  PASS  :  got EINVAL
readv02     2  PASS  :  got EFAULT
readv02     3  PASS  :  got EBADF
readv02     4  PASS  :  got EINVAL
readv02     5  FAIL  :  readv did not fail with EINVAL when count == 0
<<<test_start>>>
tag=readv02 stime=1034771958
cmdline="readv02"
contacts=""
analysis=exit
initiation_status="ok"
<<<test_output>>>
<<<execution_status>>>
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=0
<<<test_end>>>

<<<test_start>>>
tag=writev01 stime=1034772026
cmdline="writev01"
contacts=""
analysis=exit
initiation_status="ok"
<<<test_output>>>
writev01    0  INFO  :  Enter Block 1
writev01    0  INFO  :  Received EINVAL as expected
writev01    0  INFO  :  block 1 PASSED
writev01    0  INFO  :  Exit block 1
writev01    0  INFO  :  Enter block 2
writev01    1  FAIL  :  writev() failed unexpectedly
writev01    0  INFO  :  block 2 FAILED
writev01    0  INFO  :  Exit block 2
writev01    0  INFO  :  Enter block 3
writev01    0  INFO  :  block 3 PASSED
writev01    0  INFO  :  Exit block 3
writev01    0  INFO  :  Enter block 4
writev01    0  INFO  :  Received EBADF as expected
writev01    0  INFO  :  block 4 PASSED
writev01    0  INFO  :  Exit block 4
writev01    0  INFO  :  Enter block 5
writev01    0  INFO  :  Received EINVAL as expected
writev01    0  INFO  :  block 5 PASSED
writev01    0  INFO  :  Exit block 5
writev01    0  INFO  :  Enter block 6
writev01    2  FAIL  :  writev() did not fail with EINVAL when count == 0
writev01    0  INFO  :  block 6 FAILED
writev01    0  INFO  :  Exit block 6
writev01    0  INFO  :  Enter block 7
writev01    3  PASS  :  writev passed writing 64 bytes, followed by two NULL
vectors
writev01    0  INFO  :  block 7 PASSED
writev01    0  INFO  :  Exit block 7
writev01    0  INFO  :  Enter block 8
writev01    0  INFO  :  Received EPIPE as expected
writev01    0  INFO  :  block 8 PASSED
writev01    0  INFO  :  Exit block 8
<<<execution_status>>>
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=1
<<<test_end>>>

<<<test_start>>>
tag=sem02 stime=1034775415
cmdline="sem02"
contacts=""
analysis=exit
initiation_status="ok"
<<<test_output>>>
Waiter, pid = 8232
Poster, pid = 8233, posting
Poster posted
Poster exiting
Waiter waiting, pid = 8232
sem02: FAIL
Waiter done waiting
<<<execution_status>>>
duration=20 termination_type=exited termination_id=1 corefile=no
cutime=1 cstime=1
<<<test_end>>>




------=_NextPartTM-000-c48256a6-d01d-415d-8f75-6aa91ef6e171
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

------=_NextPartTM-000-c48256a6-d01d-415d-8f75-6aa91ef6e171--
