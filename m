Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262491AbSJPMX5>; Wed, 16 Oct 2002 08:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262492AbSJPMX5>; Wed, 16 Oct 2002 08:23:57 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:17597 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S262491AbSJPMXV>; Wed, 16 Oct 2002 08:23:21 -0400
From: "Pavan Kumar Reddy N.S." <pavan.kumar@wipro.com>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: LMBench (v2.0patch 2) results for 2.4 kernel.
Date: Wed, 16 Oct 2002 18:04:33 +0530
Message-ID: <003f01c27510$6188d880$610b720a@m3xxx101262>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPartTM-000-54e1487c-f132-4893-9a1b-c144728d7c6c"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

------=_NextPartTM-000-54e1487c-f132-4893-9a1b-c144728d7c6c
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit


Hi All,

Here are the performance results of latest Linux 2.4 kernel tree using
LMBench (V2.0patch2).

There is a small drop in overall performance except memory latencies from
2.4.18-3(RedHat Linux 7.3) kernel to 2.4.20-pre10 kernel.

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

============================================================================ 

                 L M B E N C H  2 . 0   S U M M A R Y
                 ------------------------------------


Basic system parameters
----------------------------------------------------
Host                 OS Description              Mhz
                                                    
--------- ------------- ----------------------- ----
access1   Linux 2.4.18-  i686-pc-linux-gnu_2.18  868
access1   Linux 2.4.18-  i686-pc-linux-gnu_2.18  868
access1   Linux 2.4.18-  i686-pc-linux-gnu_2.18  868
access1   Linux 2.4.18-  i686-pc-linux-gnu_2.18  868
access1   Linux 2.4.18-  i686-pc-linux-gnu_2.18  868

Processor, Processes - times in microseconds - smaller is better
----------------------------------------------------------------
Host                 OS  Mhz null null      open selct sig  sig  fork exec sh  
                             call  I/O stat clos TCP   inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ----- ---- ---- ---- ---- ----
access1   Linux 2.4.18-  868 0.37 0.51 2.94 3.69       0.93 2.91 150. 792. 5152
access1   Linux 2.4.18-  868 0.37 0.53 2.92 3.65       0.94 2.94 143. 735. 5127
access1   Linux 2.4.18-  868 0.36 0.53 2.95 3.66  16.3 0.94 2.92 138. 673. 4576
access1   Linux 2.4.18-  868 0.37 0.52 2.93 3.75       0.95 2.92 146. 668. 4604
access1   Linux 2.4.18-  868 0.37 0.52 2.91 3.65  17.6 0.93 2.92 191. 705. 4600

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------
access1   Linux 2.4.18- 0.650 4.0400   69.8 8.4900  182.3    41.2   183.5
access1   Linux 2.4.18- 0.640 4.0300   13.0 7.2300  178.9    39.5   187.8
access1   Linux 2.4.18- 0.830 4.0600   13.1 6.6400  148.3    32.4   149.3
access1   Linux 2.4.18- 0.880 4.1000   12.7 7.5700  147.7    40.0   149.1
access1   Linux 2.4.18- 0.850 4.0400   12.9 9.8300  147.7    33.0   149.2

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
access1   Linux 2.4.18- 0.650 4.327 8.13  23.0  43.5  32.1  58.0 101.
access1   Linux 2.4.18- 0.640 4.535 8.50  24.0  45.2  34.2  60.7 100.
access1   Linux 2.4.18- 0.830 4.515 8.43  23.9  45.4  33.9  60.3 100.
access1   Linux 2.4.18- 0.880 4.706 8.34  23.8  46.3  34.1  61.5 101.
access1   Linux 2.4.18- 0.850 5.349 8.45  24.0  45.9  34.6  61.2 100.

File & VM system latencies in microseconds - smaller is better
--------------------------------------------------------------
Host                 OS   0K File      10K File      Mmap    Prot    Page	
                        Create Delete Create Delete  Latency Fault   Fault 
--------- ------------- ------ ------ ------ ------  ------- -----   ----- 
access1   Linux 2.4.18-   64.8   16.4  208.7   32.4    235.0 0.775 2.00000
access1   Linux 2.4.18-   67.9   15.9  228.1   37.4    233.0 0.983  7507.0
access1   Linux 2.4.18-   67.6   15.6  197.4   30.6    236.0 0.967 2.00000
access1   Linux 2.4.18-   68.2   15.8  196.5   30.7    235.0 1.065 2.00000
access1   Linux 2.4.18-   67.2   15.6  196.9   30.5    236.0 0.983 2.00000

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
access1   Linux 2.4.18- 853. 726. 43.0  292.2  344.7  111.1  104.3 343. 136.6
access1   Linux 2.4.18- 813. 201. 40.6  155.8  322.5  104.7   97.6 323. 131.7
access1   Linux 2.4.18- 798. 472. 98.6  343.7  387.9  131.8  121.5 390. 165.9
access1   Linux 2.4.18- 699. 327. 49.0  331.9  386.6  130.8  121.9 388. 165.2
access1   Linux 2.4.18- 682. 378. 50.0  326.0  388.3  130.4  119.8 386. 163.8

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
---------------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    Guesses
--------- -------------  ---- ----- ------    --------    -------
access1   Linux 2.4.18-   868 3.455 8.0650  181.3
access1   Linux 2.4.18-   868 3.456 8.0750  197.4
access1   Linux 2.4.18-   868 3.456 8.0660  160.0
access1   Linux 2.4.18-   868 3.456   61.0  160.2
access1   Linux 2.4.18-   868 3.456 8.0640  162.0

================================================================================

                 L M B E N C H  2 . 0   S U M M A R Y
                 ------------------------------------


Basic system parameters
----------------------------------------------------
Host                 OS Description              Mhz
                                                    
--------- ------------- ----------------------- ----
access1   Linux 2.4.20-  i686-pc-linux-gnu_2.20  868
access1   Linux 2.4.20-  i686-pc-linux-gnu_2.20  868
access1   Linux 2.4.20-  i686-pc-linux-gnu_2.20  868
access1   Linux 2.4.20-  i686-pc-linux-gnu_2.20  868
access1   Linux 2.4.20-  i686-pc-linux-gnu_2.20  868

Processor, Processes - times in microseconds - smaller is better
----------------------------------------------------------------
Host                 OS  Mhz null null      open selct sig  sig  fork exec sh  
                             call  I/O stat clos TCP   inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ----- ---- ---- ---- ---- ----
access1   Linux 2.4.20-  868 0.41 0.73 3.91 5.45  31.6 0.96 3.04 147. 735. 5102
access1   Linux 2.4.20-  868 0.41 0.69 3.88 5.34  30.7 0.96 3.04 162. 741. 5148
access1   Linux 2.4.20-  868 0.41 0.68 3.88 5.37  30.4 0.96 3.04 149. 699. 4617
access1   Linux 2.4.20-  868 0.41 0.72 3.99 5.47  33.7 0.96 3.04 192. 690. 4595
access1   Linux 2.4.20-  868 0.41 0.68 3.95 5.35  30.5 0.97 3.04 145. 705. 4611

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------
access1   Linux 2.4.20- 1.140 4.3000   13.2 8.6600  187.2    40.5   186.3
access1   Linux 2.4.20- 1.130 4.4900   15.1 7.2200  145.3    33.0   149.9
access1   Linux 2.4.20- 1.140 4.1600   13.8 8.2500  150.2    33.7   151.7
access1   Linux 2.4.20- 1.200 4.4400   13.7 6.6300  150.4    35.1   150.4
access1   Linux 2.4.20- 1.060 4.5100   13.3 8.7500  150.0    37.3   150.1

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
access1   Linux 2.4.20- 1.140 6.387 11.2  18.7  40.5  25.9  52.7 86.0
access1   Linux 2.4.20- 1.130 6.487 11.3  18.7  40.3  26.3  52.8 85.6
access1   Linux 2.4.20- 1.140 6.414 11.2  18.7  40.9  26.4  53.5 85.3
access1   Linux 2.4.20- 1.200 6.462 11.3  18.9  41.2  26.6  52.9 86.0
access1   Linux 2.4.20- 1.060 6.522 11.2  18.8  40.7  26.2  53.6 85.3

File & VM system latencies in microseconds - smaller is better
--------------------------------------------------------------
Host                 OS   0K File      10K File      Mmap    Prot    Page	
                        Create Delete Create Delete  Latency Fault   Fault 
--------- ------------- ------ ------ ------ ------  ------- -----   ----- 
access1   Linux 2.4.20-   35.6 8.5450  152.7   20.3    270.0 0.826 3.00000
access1   Linux 2.4.20-   35.6 8.5510  153.3   20.3    275.0 0.803 2.00000
access1   Linux 2.4.20-   34.9 7.8700  132.7   19.1    271.0 0.821 2.00000
access1   Linux 2.4.20-   35.1 8.0060  132.6   19.2    267.0 0.818 3.00000
access1   Linux 2.4.20-   34.9 7.9410  132.5   19.1    273.0 0.832 2.00000

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
access1   Linux 2.4.20- 722. 656. 107.  308.2  346.0  109.5  101.9 346. 138.9
access1   Linux 2.4.20- 674. 348. 126.  305.3  343.7  110.8  124.4 414. 173.5
access1   Linux 2.4.20- 717. 493. 156.  364.2  419.4  136.4  123.6 419. 174.5
access1   Linux 2.4.20- 661. 562. 153.  359.8  417.0  136.2  125.3 413. 173.1
access1   Linux 2.4.20- 717. 659. 148.  362.4  413.2  139.6  127.1 418. 173.0

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
---------------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    Guesses
--------- -------------  ---- ----- ------    --------    -------
access1   Linux 2.4.20-   868 3.456 8.0760  181.1
access1   Linux 2.4.20-   868 3.457 8.0670  153.2
access1   Linux 2.4.20-   868 3.456 8.0760  154.1
access1   Linux 2.4.20-   868 3.456 8.0740  153.3
access1   Linux 2.4.20-   868 3.455 8.0650  153.8

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

------=_NextPartTM-000-54e1487c-f132-4893-9a1b-c144728d7c6c
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

------=_NextPartTM-000-54e1487c-f132-4893-9a1b-c144728d7c6c--
