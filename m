Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131320AbRBVH4h>; Thu, 22 Feb 2001 02:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131318AbRBVH42>; Thu, 22 Feb 2001 02:56:28 -0500
Received: from mail.isis.co.za ([196.15.218.226]:57106 "EHLO mail.isis.co.za")
	by vger.kernel.org with ESMTP id <S131286AbRBVH4N> convert rfc822-to-8bit;
	Thu, 22 Feb 2001 02:56:13 -0500
Message-Id: <4.3.2.7.0.20010222095007.00b9e260@192.168.0.18>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Thu, 22 Feb 2001 09:56:03 +0200
To: linux-kernel@vger.kernel.org
From: Pat Verner <pat@isis.co.za>
Subject: PROBLEM: Network hanging - Tulip driver with Netgear (Lite-On)
  NIC
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1.      Network hanging - Tulip driver with Netgear (Lite-On) NIC

2.      I am trying to prepare a new firewall host with a Pentium III and 
three Netgear NICs and am experiencing considerable trouble with the 
combination:

Kernel 2.4.[01]:        ifconfig shows that the card see's traffic on the 
network, but does not transmit anything (no response to ping).

Kernel 2.2.16:  appears to work, but only for a short while.  In 
particular, running IPTRAF, with the card in promiscuous mode, will work 
for 2 - 5 minutes, then the card will hang.  The ONLY recovery that I have 
found is too reboot the machine.

Using the kernel 2.2.16, I have tried various combinations:
·       I have removed all but one of the NICs; no change.
·       I have changed the version of the tulip driver:  I have tried 
0.89H, 0.91g, and 0.91g-ppc with similar results on all drivers.

3.      Keywords:  modules, networking, tulip drivers

4.      Kernel Version : 2.2.16 / 2.4.1

5.      .

6.      Environment:

Hardware : ASUS P3W-E motherboard;   Netgear FA310DX (LC82C169C)  NIC

Software:

--Versions installed: (if some fields are empty or looks
--unusual then possibly you have very old versions)
Linux newgate 2.2.16 #2 Tue Feb 20 08:40:04 SAST 2001 i686 unknown
Kernel modules         2.4.1
Gnu C                  egcs-2.91.66
Binutils               2.9.1.0.25
Linux C Library        2.1.3
Dynamic linker         ldd: version 1.9.9
Procps                 2.0.6
Mount                  2.10l
Net-tools              1.55
Kbd                    command
Sh-utils               2.0
Modules Loaded         tulip bsd_comp ppp slhc

-- cat /proc/cpuinfo :
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model   : 8
model name      : Pentium III (Coppermine)
stepping        : 1
cpu MHz : 655.850
cache size      : 256 KB
fdiv_bug        : no
hlt_bug : no
sep_bug : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 3
wp              : yes
flags   : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat 
pse36 pn mmx fxsr xmm
bogomips        : 1307.44

7.      I am currently running a similar configuration on an older Pentium 
166 MHz, with three Netgear cards, as my present firewall host - Linux 
2.2.16 + ipchains, and experience no problems with this combination.

I am at a total loss as to what steps to try next.  Any advice / comments 
would be appreciated.

Regards
=Pat



--
Pat Verner				E-Mail:  pat@isis.co.za
           Isis Information Systems (Pty) Ltd
           PO Box 281, Irene, 0062, South Africa
Phone: +27-12-667-1411	      	Fax: +27-12-667-3800

