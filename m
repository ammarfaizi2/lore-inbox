Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292802AbSCIPdd>; Sat, 9 Mar 2002 10:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292803AbSCIPdZ>; Sat, 9 Mar 2002 10:33:25 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:54749 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S292802AbSCIPdL> convert rfc822-to-8bit; Sat, 9 Mar 2002 10:33:11 -0500
Message-Id: <200203091416.g29EGBaO007081@codeman.linux-systeme.org>
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <mcp@linux-systeme.de>
Reply-To: mcp@linux-systeme.de
Organization: Linux-Systeme GmbH
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] Kernel 2.4.18-mcp3-WOLK
Date: Sat, 9 Mar 2002 14:46:19 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel - patched - mcp3-WOLK - Base: Linux kernel 2.4.18

by Marc-Christian Petersen <mcp@linux-systeme.de>


Some words, this is my first public release. I think its ready to use for others.

Thanks to darix <darix@irssi.de> for the project name WOLK :-)


What is this? Why another patchset/patched kernel?

Using Linux since years, very tired of there are not really good patchsets available. Saw FOLK Patch/Kernel which is very very buggy. Inspired by the jp-Patchsets from Joerg Prante <joerg@infolinux.de>.

The -mcp-WOLK kernels are development kernels for testing purpose only.
!! If you want to use it in production, use it at your own risk !!
Their purpose is to provide a service for developers and end-users who can't be up to date with the latest kernels/patches but want to test many features out there linux can use. Maybe, (hopefully) some of them will be included into the mainstream kernel 2.4 soon.
There will always be a new WOLK if there is a new final kernel released. 

You are missing a patch? Patches will be added by request.
You think one or more of the patches are fully useless? Tell me why.
You have minor, major or heavy mega problems, let me know. I will try to fix.
You think this is great? Let me know too :-)

Unfortunately you must use the whole kernel with the patches applied, cause at the moment i don't have time to make a patchset to the Vanilla Kernel from kernel.org. If i have more time, i will do so! I think i will do so for the next 2.4.19-mcp4-WOLK release.

I think i made some people happy, cause this patched kernel includes some very nice features, and, of course, for the end-WIN-(L)users Win4Lin3 Support. Don't hit me for that ;)


Overview:
---------
The -mcp3-WOLK kernel contains: (over 70 Patches)


SET_PERSONALITY fix

security fix x86
----------------
A security hole was recently found in both the 2.2 and 2.4 trees of linux kernels. The hole is x86 processor specific, and allows an attacker to kill processes he doesn't own. This is not a hole in grsecurity, but in all linux kernels.
http://www.grsecurity.net/linux-2.4.18.secfix.patch


grsec 1.9.4 REAL Final
----------------------
really great security patch
Brad Spengler / Michael Dalton
http://www.grsecurity.net
(Included is gradm 1.2.1, find it under tools/)


Win4Lin3
--------
Use Windows under Linux with Win4Lin (commercial)
Netraverse
http://www.netraverse.com/


preempt + stuff
---------------
full preempting kernel tasks for low latency
Robert Love
http://www.tech9.net/rml/linux


EMU10k1 (SBLive etc.)
---------------------
These are updates to the in-kernel driver for the emu10k1
Robert Love
http://www.kernel.org/pub/linux/kernel/people/rml/emu10k1/


crypto + loop jari
------------------
international cryptographic API patch
Herbert Valerio Riedel et.al.
http://www.kernel.org/pub/linux/kernel/people/hvr/


Boot time ioremap
-----------------
Implements a version of ioremap() which is functional at the very
early stages of the i386 boot sequence.
Mikael Pettersson
http://www.csd.uu.se/~mikpe/linux/kernel-patches/2.4/


Early DMI Scan
--------------
Moves the i386 DMI scan to an earlier point in the boot sequence, so that
the DMI data can be used to guide hardware detection and initialisation.
Mikael Pettersson
http://www.csd.uu.se/~mikpe/linux/kernel-patches/2.4/


DMI APIC Fixups
---------------
Adds DMI scan rules and apic.c workarounds for broken BIOSen, which is needed to avoid hard lockups on some machines in certain configurations. The machines currently handled by this patch are: Dell Inspiron and Latitude, IBMT hinkpad T20, Intel AL440LX, and Microstar 6163.
Mikael Pettersson
http://www.csd.uu.se/~mikpe/linux/kernel-patches/2.4/


IDE
---
IDE enhancements 
Andre Hedrick
http://www.kernel.org/pub/linux/kernel/people/hedrick/


Software RAID enhancements
--------------------------
patch set to manage multiple RAID devices (span chunks, MD partitioning)
Neil Brown
http://cgi.cse.unsw.edu.au/~neilb/patches/linux-stable/


loop crypto device/twofish
--------------------------
from older version of the international crypto patch


JFS 1.0.15 
----------     
IBM journal file system
Steve Best et.al
http://oss.software.ibm.com/developerworks/oss/jfs/


freeswan 1.95  
-------------
free IPsec implementation 
John Gilmore et.al.
http://www.freeswan.org


freeswan x.509 patch
--------------------
Andreas Steffen et.al
http://www.strongsec.com/freeswan/


Tekram DC395 Patch
------------------
Kurt Garloff
http://www.garloff.de/kurt/linux/dc395/
ftp://ftp.suse.com/pub/people/garloff/linux/dc395/


HTB Scheduling
--------------
Martin Devera
http://luxik.cdi.cz/~devik/qos/htb/


NWFS (Netware FileSystem)
-------------------------
J. Merkey
http://www.kernel.org/pub/linux/kernel/people/jmerkey/nwfs/


IPVS (Linux Virtual Server)
---------------------------
http://www.linuxvirtualserver.org/deployment.html
http://www.linuxvirtualserver.org/
(Included tools to use IPVS, find it under tools/)


NFS Patches
-----------
Trond Myklebust
http://www.fys.uio.no/~trondmy/src/2.4.18/


VFAT Symlinks Patch
-------------------
Make Windows .lnk files look like real symlinks
Jan Pazdziora
http://www.fi.muni.cz/~adelton/linux/vfat-symlink/


Load Kill Patch
---------------
Kill process with excessive load
http://www.cssc-inc.com/loadkill-0.1.patch


Filesystem in Userspace Patch
-----------------------------
http://sourceforge.net/projects/avf


XFS + KDB (cvs snapshot 04. March 2002)
---------------------------------------
High performance journaling filesystem
SGI / Stephen Lord et al
ftp://oss.sgi.com/projects/xfs/download/patches/2.4.18


Adaptec SCSI Driver Updates
---------------------------
http://people.freebsd.org/~gibbs/linux/


i2c 2.6.2
---------
Hardware monitoring
Alexander Larsson et.al.
http://www.netroedge.com/~lm78/


lm_sensors 2.6.2
----------------
Hardware monitoring
Alexander Larsson et.al.
http://www.netroedge.com/~lm78/


badMEM
-------
If you want to use it, you must first configure the badmem tools located at the tools directory included in this package
http://badmem.sourceforge.net/


Enterprise Event Logging System
-------------------------------
http://evlog.sourceforge.net/


Kernel Panic Message Dumper
---------------------------
http://www-miaif.lip6.fr/willy/linux-patches/


accessfs
--------
http://home.t-online.de/home/olaf.dietsche/linux/


ACPI
----
http://sourceforge.net/projects/acpi/


timepeg
-------
Andrew Morton
http://www.zipworld.com.au/~akpm/linux/ext3/


Compressed Cache
----------------
http://linuxcompressed.sourceforge.net/


Extended ptrace
---------------
http://www.elis.rug.ac.be/~fcorneli/


bttv
----
http://bytesex.org/bttv/


TIOCGDEV
--------
new ioctl to return the console mapping
Kurt Garloff
http://banyan.dlut.edu.cn/news/121600/0116.html



And some other small patches ... Have a look yourself in the included applied_patches directory. ( I love Open Source :-)

Credits go to all the people who created the patches, working hard on
improving the quality.


Installation
------------
* get the WOLK Kernel from: http://sourceforge.net/projects/mcp-wolk/
* untar the kernel source you've downloaded to your favourite place on
  your harddisk. I suggest you untar it in /usr/src
  You will get a directory named linux-2.4.18-mcp3-WOLK
* I have included my .config File, change it to your needs with:
  make {config|menuconfig}
* compile and install the kernel, compile/install modules
* Have a look at the tools/ directory included in this package.

--------------------------------------------------------------------------
Feel free to send me feedback. Please CC, I am not subscribed to the lkml.
--------------------------------------------------------------------------

The next WOLK Kernel will be available some days after the 2.4.19 final kernel release.


Todo for the next releases:
---------------------------
- Mosix/OpenMosix (why the hell they are so slow to release new patches.
  Hurry up !!
- FTPFS (does not work now, just very old, but usefull)
- OpenAFS
- OpenGFS
- ALSA


Enjoy!

Marc-Christian Petersen <mcp@linux-systeme.de>
Unix/Linux Administrator
Essen, Germany

