Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289767AbSAJXGK>; Thu, 10 Jan 2002 18:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289770AbSAJXGB>; Thu, 10 Jan 2002 18:06:01 -0500
Received: from wep10a-3.wep.tudelft.nl ([130.161.65.38]:16400 "EHLO
	wep10a-3.wep.tudelft.nl") by vger.kernel.org with ESMTP
	id <S289767AbSAJXFt>; Thu, 10 Jan 2002 18:05:49 -0500
Date: Fri, 11 Jan 2002 00:05:47 +0100 (CET)
From: Taco IJsselmuiden <taco@wep.tudelft.nl>
Reply-To: Taco IJsselmuiden <taco@wep.tudelft.nl>
To: linux-kernel@vger.kernel.org
Subject: boot problems pre11 + O(1) H1 & H4 on UP athlon
Message-ID: <Pine.LNX.4.21.0201102352200.1515-100000@banaan.taco.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i'm having problems booting 2.5.2-pre11 with O(1) H1 or H4 patch.
the last few lines are:

<snip>
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb470, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.15)
Starting kswapd

and then it doesn't respond to anything (like keyboard leds...)
no oops no nothing ;((

pre11 boots fine without the patch.
even pre10 + G1 boots fine...


extra info:
+ gcc --version
2.95.4
+ make --version
GNU Make version 3.79.1, by Richard Stallman and Roland McGrath.
+ ld -v
GNU ld version 2.11.92.0.12.3 20011121 Debian/GNU Linux
+ fdformat --version
fdformat from util-linux-2.11n
+ insmod -V
insmod version 2.4.12
+ tune2fs
tune2fs 1.25 (20-Sep-2001)
+ reiserfsck
+ grep reiserfsprogs
reiserfsprogs 3.x.0j


brood:~# cat /proc/cpuinfo l
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 1
model name      : AMD-K7(tm) Processor
stepping        : 2
cpu MHz         : 499.045
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov
pat mmx syscall mmxext 3dnowext 3dnow
bogomips        : 996.14



any ideas ?


Cheers,
Taco.

