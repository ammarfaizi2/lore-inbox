Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319338AbSHNU4W>; Wed, 14 Aug 2002 16:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319339AbSHNUzc>; Wed, 14 Aug 2002 16:55:32 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:29579 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S319338AbSHNUy5> convert rfc822-to-8bit; Wed, 14 Aug 2002 16:54:57 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: WOLK - Working Overloaded Linux Kernel
To: wolk-devel@lists.sourceforge.net, wolk-announce@lists.sourceforge.net
Subject: [ANNOUNCE] WOLK v3.5 FINAL, Codemane 'Fin' alias 'Birthday Release'
Date: Wed, 14 Aug 2002 22:57:41 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200208101518.41426.m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I am very proud to announce: (and also give me a small present for my b'day :)

 WOLK v3.5 FINAL, Codename 'Fin' alias 'Birthday Release'

A lot of development has been done since the last version of WOLK, v3.4.

Also I am a kind of happy that this is the last release of the
"Working Overloaded Linux Kernel", because I don't have the time that WOLK 
needs for further good development. I have a job, a girl friend, some friends 
etc. so I depend on some people who will help me to manage this project 
successfull.

I've asked a thousand times for help, got some offers, but never really get 
that what they promised to do. The only real helping hands for patches was 
Michael Gasperi, the only Co-Developer for my project, and Dominik Perpeet, 
my "personal" C/C++ Guru ;). And 2 times Jure Pecar ... But 2-3 people are 
definitively too less for managing this big project successfull.

Anyway, it was a nice time, having fun, a good kernel, many learning about 
kernel internals. Thanks a lot to all those people around over the planet of 
using WOLK.


Sorry, no OpenMosix and also no O(1) scheduler as I promised! 
- Thanks Paul, Enrico!


Here we go, Changelog from v3.4 -> v3.5:
----------------------------------------

 o indicates work by WOLK Developers (almost me)
 + indicates work by WOLK Users

o   add:     ext3 Write/Read speedups
o   add:     ext3 commit interval (mount option commit=X)
+   add:     /dev/epoll support + #ifdef'ed
+   add:     AIO (Asynchronous I/O) 20020619 + Bugfixes + #ifdef'ed
o   add:     SOFFIC (Secure On-the-Fly File Integrity Checker)
o   add:     IBM Next Generation Posix Threading 2 (NGPT2)
o   add:     Shared ZLIB (Use only one copy of zlib for whole kernel)
o   add:     WL24xx Wireless LAN Card Driver (boerde.de approved)
o   add:     Fast PID allocation
o   add:     Read-Copy Update mechanism for mutual exclusion
o   add:     "export LC_ALL=C" to addpatches script due to conflicts with
              other locales. Error was wrong order in applying patches.
+   add:     readlink patch (Makes symlinks for supermount working)
o   add:     Single Driver Qlogic FC/SCSI support
o   add:     CPU - Cap Processor Usage
              allowing to limit processor usage (by percentage)
              for a given task (cap binary in WOLK-tools package)
o   add:     Compaq/CCISS Updates from 2.4.19-rcX (fixes build problems also)
o   add:     2.4.19-rcX full updates for SCSI, IEEE1394, VIDEO
o   add:     gzip/bzip2 compressed RAM disk image support
o   add:     Very small low latency additions
o   add:     /proc/PID/mapped_base and /proc/PID/oom_priority
o   add:     CPU Frequency Scaling + Enforce SpeedStep Fix
o   add:     htree ext3 directory indexing
o   add:     some more ext3 fixes
o   add:     Intermediate queueing device + IMQ target support
o   add:     IBM's Prioritized Accept Queue
o   add:     New NAT and again some more extra modules for NetFilter!
              - IPv4: H.323 (netmeeting) support
              - IPv4: DSCP match support
              - IPv4: Helper match support
              - IPv4: realm match support
              - IPv4: RPC match support
              - IPv4: RMARK target support
              - IPv6: Routing header match support
              - IPv6: Hop-by-Hop and Dst opts header match
              - IPv6: Fragmentation header match support
              - IPv6: IPv6 Extension Headers Match
              - IPv6: AH/ESP match support
              - IPv6: Packet Length match support
              - IPv6: EUI64 address check
               You may need the userspace iptables v1.27-WOLK version
               shipped with the WOLK-tools package including all patches
               for some features in WOLK like stealth, IMQ and TProxy.
               ! This is also available as a seperate package !
o   add:     Some gcc3.x additions
o   add:     vlogger in scripts/vlogger/ (Nice keylogger, eh?! ;-)
o   add:     oomkiller.c in scripts/ Directory
o   add:     Some AA-VM merges
o   add:     IRQ-rate-limiting. Adds the dynamic hard-IRQ-limiting
              feature and fixes softirq performance.
o   add:     corefile-name: This patch will allow you to configure the
              way core files are named through the /proc filesystem.
              You can specify patterns, e.g. "core.%p" to get pid
              appended, "%e.core" to get the name of the executable,
              or "/var/core/core.%h" to get all yor core files in /var/core
              and have the hostname appended.
+   add:     PPC compile fixes
o   add:     USB Driver from v2.4.19 final
+   add:     Athlon-XP arch optimizations for gcc v3.x
o   add:     ReiserFS speedups (requested)
o   add:     IBM NGPT2 (Next Generation Posix Threading 2)
o   add:     Packet writing on CD/DVD media + Write caching
o   add:     Early printk() + #ifdef'ed for x86 arch only
o   add:     Multiple Framebuffer Boot Logos, including:
              TuX's, WOLK, Debian, Redhat, Mandrake,
              Slackware, Gentoo, Kondara MNU/Linux, some misc stuff
o   add:     ReiserFS Updates from 2.4.19
o   add:     SambaFS Updates from 2.4.19 + other fixes
o   add:     Use specific machine level instructions for mb() for new
              processors (P3, P4, Athlon).
o   add:     Configure the max number of CPUs at compile time (def. was 32).
              Saves memory footprint for kernel (around 240Kb in 32->2).
o   add:     Some patches/fixes introduced by 2.4.19-rc1-aa1 kernel tree
o   add:     Dependency for SiS DRM -> SiSFB (otherwise build fails)
o   add:     CTX-12 (Virtual private servers and security contexts)
              + userspace tools (vserver,vserveradmin) in WOLK-tools package
o   add:     IBM's Kernel Lock Metering
              + Lockstat tool in WOLK-tools package
+   add:     Dependency for SiS DRM -> SiS FB (otherwise build fails)
+   add:     SiS Driverupdates
+   fixed:   SuperMount: Stale NFS Handle. Works now !!
+   fixed:   VIA Oops() -> Panics at boottime. Works now!
o   fixed:   EMU10k Driver Update (hopefully working again)
+   fixed:   Circular dependencies at build time
+   fixed:   ext2 compression + Compressed Cache build problem
+   fixed:   FrameBuffer SplashScreen build error
+   fixed:   remove /proc/stat kstat when TuX is not configured
o   fixed:   Fixes for swap (memleak, unsafe BUG()s, redundant checks)
o   fixed:   Fixes for tmpfs (symlinks, directory itimes, truncate,
              swapoff speedup)
o   fixed:   Attempt to fix the ServerWorks problem with certain disks/DMA.
+   fixed:   iptables annoying log entries
+   fixed:   Netgear GA622 compile problem
o   fixed:   hopefully really fixed the AutoFS oops bug this time
o   update:  IPVS v1.0.5
o   update:  Crypto v2.4.18.3
o   update:  Loop JARI v2.4.18
o   update:  Block Highmem I/O 19-1
o   update:  i810/i815 Framebuffer Device Driver v0.0.29
+   update:  Matrox/Radeon/Rage128 Driver
o   update:  ACPI Fixes from 2.5.24 + New PCI IRQ 27
o   update:  JFS v1.0.21
o   update:  Tekram DC395 SCSI Controller Driver v1.41
o   update:  ALSA v0.9.0-rc2 (no oops anymore for /proc/asound/*)
+   update:  V4L driver for the Quickcam Express and Dexxa Quickcam v0.41c
o   update:  Preempt v2.4.19-rc5-3 
o   update:  Preempt Stats v2.4.19-pre8-1
o   update:  UML - User-Mode-Linux v2.4.18-52
o   update:  i2c v2.6.4
o   update:  lmsensors v2.6.4 + Fixes + missing Config.in entries
o   update:  XFS + KDB v2.4.19 CVS snapshot
o   update:  Compressed Cache v0.24-pre3
              (since 0.24-pre2 Preempt+Lockbreak compatible)
o   update:  grsecurity v1.9.6
              + gradm v1.4 in the WOLK-tools package
o   update:  NTFS Filesystem Driver v2.0.21b
o   update:  Enterprise Volume Management System (EVMS) v1.1.0final
o   update:  Timepegs 2.4.19-pre6-1 and removed NR_CPUS 2
o   update:  FreeS/WAN v1.97 + x.509 v0.9.12
o   change:  /proc/config.gz is no longer readable by anyone but root.
o   removed: htree ext2 directory indexing
              (causes oops and non-working ext2 with highmem enabled)


WOLK (and Oracle 9i) test mashine:
----------------------------------
Compaq ML570, Quad XEON 900MHz, 16GB RAM, 200GB U2W SCSI RAID
- Sponsored by Freenet AG, Duesseldorf, Germany
- Many thanks to Ruben Puettmann



Date   : 14th August, 2002
Time   : 11:00 pm CET
URL    : http://sf.net/projects/wolk



All in One Patch:
-----------------
http://prdownloads.sf.net/wolk/linux-2.4.18-wolk3.5-patch.patch.bz2
http://prdownloads.sf.net/wolk/linux-2.4.18-wolk3.5-patch.patch.gz


Patchset:
---------
http://prdownloads.sf.net/wolk/linux-2.4.18-wolk3.5-patchset.tar.bz2
http://prdownloads.sf.net/wolk/linux-2.4.18-wolk3.5-patchset.tar.gz


Full Kernels with Patches applied:
----------------------------------
http://prdownloads.sf.net/wolk/linux-2.4.18-wolk3.5-fullkernel.tar.bz2
http://prdownloads.sf.net/wolk/linux-2.4.18-wolk3.5-fullkernel.tar.gz


Diff from v3.4 -> v3.5
----------------------
http://prdownloads.sf.net/wolk/linux-2.4.18-wolk3.4-to-3.5.patch.bz2
http://prdownloads.sf.net/wolk/linux-2.4.18-wolk3.4-to-3.5.patch.gz



md5sums:
--------
ac76ef80ded1e8f2603c2f605baac542 *WOLK-tools.tar.bz2
e77af11e3827d831c28ef907d09f233e *WOLK-tools.tar.gz
3de0bf0db014540df9aafd0558e5a341 *linux-2.4.18-wolk3.4-to-3.5.patch.bz2
bb7036cf22fea7b6e13b0e7ea5f159eb *linux-2.4.18-wolk3.4-to-3.5.patch.gz
226c40476f5cad10008d26d27a3d9749 *linux-2.4.18-wolk3.5-fullkernel.tar.bz2
ba76bdf741cf345f14f38d8a18ace73a *linux-2.4.18-wolk3.5-fullkernel.tar.gz
7df2ae36adafb02c7cdff45b7d544dca *linux-2.4.18-wolk3.5-patch.patch.bz2
acc6f61a02efb1a5eb0e354667255928 *linux-2.4.18-wolk3.5-patch.patch.gz
c5c02d35fa7052b55fe87f9e2ad879b9 *linux-2.4.18-wolk3.5-patchset.tar.bz2
d38adf7f7a6862b77f4e975af5d02732 *linux-2.4.18-wolk3.5-patchset.tar.gz



Uploading is in progress. All packages are ~ 250 MB (Megabyte). This
takes some time with 16kb/s upload speed to sf.net ;-(
Expect all files to be up at latest tomorrows morning !!


Have fun!


P.S.: Andrea: Consider removing/fixing inode-highmem-2.patch.
              It's horribly slow ;)


-- 
Kind regards
        Marc-Christian Petersen

http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/569DE2E3DB441A16
Fingerprint: 3469 0CF8 CA7E 0042 7824 080A 569D E2E3 DB44 1A16
Key available at www.keyserver.net. Encrypted e-mail preferred.


