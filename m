Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290587AbSBFOpF>; Wed, 6 Feb 2002 09:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290589AbSBFOov>; Wed, 6 Feb 2002 09:44:51 -0500
Received: from chmls06.ne.ipsvc.net ([24.147.1.144]:3712 "EHLO
	chmls06.mediaone.net") by vger.kernel.org with ESMTP
	id <S290587AbSBFOod>; Wed, 6 Feb 2002 09:44:33 -0500
From: "Guillaume Boissiere" <boissiere@mediaone.net>
To: linux-kernel@vger.kernel.org
Date: Wed, 6 Feb 2002 09:44:05 -0500
MIME-Version: 1.0
Subject: [STATUS 2.5]  February 6, 2002
Message-ID: <3C60FAE5.19451.20FCF5E@localhost>
X-mailer: Pegasus Mail for Windows (v4.01)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest 2.5 status list for this week is available at the usual 
URL with all the good stuff (URL link to each project, changes 
since last week in bold, etc.)

   http://kernelnewbies.org/status/

Worthy of note for filesystem junkies is the inclusion of Access 
Control List (ACL) support in the Virtual File System layer, which 
should pave the way for XFS, better NTFS and ext2/ext3 ACL support.

Equally exciting is Linus' new use of BitKeeper.  This has the very 
nice side effect of generating big fat changelogs (see the latest 
18k Changelog for 2.5.4-pre1) that should make it a lot easier 
to do regression testing and track down bugs to individual patches.

As usual, please send corrections and updates to me.
Enjoy!

-- Guillaume


-------------------------------------------------------
Kernel 2.5 status  -  February 6th, 2002
(Latest kernel release is 2.5.4pre1)


Features:

o Merged     New scheduler for improved scalability          (Ingo Molnar, Davide Libenzi)
o Merged     Rewrite of the block IO (bio) layer             (Jens Axboe)
o Merged     New kernel device structure (kdev_t)            (Linus Torvalds, etc.)
o Merged     Initial support for USB 2.0                     (David Brownell, Greg Kroah-
Hartman, etc.)
o Merged     Per-process namespaces, late-boot cleanups      (Al Viro, Manfred Spraul)
o Merged     IDE layer update                                (Andre Hedrick)
o Merged     New driver API for Wireless Extensions (1/2)    (Jean Tourrilhes)
o Merged     Generic ACL (Access Control List) support       (Nathan Scott)
o Merged     Support reiserfs external journal               (Reiserfs team)
o Merged     New driver model & unified device tree          (Patrick Mochel)

o Pending    Finalize new device naming convention           (Linus Torvalds)
o in -dj     Porting all input devices over to input API     (Vojtech Pavlik, James Simmons)
* in -ac     32bit UID quota support                         (?)

o Ready      Add User-Mode Linux (UML)                       (Jeff Dike)
o Ready      HDLC (High-level Data Link Control) update      (Krzysztof Halasa)
o Ready      Add ALSA (Advanced Linux Sound Architecture)    (ALSA team)
o Ready      Add hardware sensors drivers                    (lm_sensors team)
o Ready      Add preempt kernel option                       (Robert Love)
o Ready      New kernel config system: CML2                  (Eric Raymond)
o Ready      Add JFS (Journaling FileSystem from IBM)        (JFS team)
 
o <1 month   New kernel build system (kbuild 2.5)            (Keith Owens)

o Beta       Add support for CPU clock/voltage scaling       (Erik Mouw, Dave Jones, 
Russell King, Arjan van de Ven)
o Beta       Serial driver restructure                       (Russell King)
o Beta       New IO scheduler                                (Jens Axboe)
o Beta       NAPI Network interrupt mitigation               (Jamal Hadi Salim, Robert 
Olsson, Alexey Kuznetsov)
o Beta       Add XFS (A journaling filesystem from SGI)      (XFS team)
o Beta       New VM with reverse mappings                    (Rik van Riel)
o Beta       Add resheduling points to remove latency        (Andrew Morton)
o Beta       Build option for Linux Trace Toolkit (LTT)      (Karim Yaghmour)
o Beta       Better event logging for enterprise systems     (evlog team)
o Beta       Add Linux Security Module (LSM)                 (LSM team)
o Beta       Hotplug CPU support                             (Rusty Russell)
o Beta       Per-mountpoint read-only, union-mounts, unionfs (Al Viro)
o Beta       EVMS (Enterprise Volume Management System)      (EVMS team)
o Beta       LVM (Logical Volume Manager) v2.0               (Heintz Mauelshagen, Andreas 
Dilger, LVM team)
o Beta       Linux booting ELF images                        (Eric Biederman)
o Beta       First pass at LinuxBIOS support                 (Eric Biederman)
o Beta       Read-Copy Update Mutual Exclusion               (Dipankar Sarma, Rusty 
Russell, Ardrea Arcangeli, LSE Team)
* Beta       Dynamic Probes                                  (Suparna Bhattacharya, dprobes 
team)

o Alpha      Better support of high-end NUMA machines        (NUMA team)
o Alpha      Add Asynchronous IO (aio) support               (Ben LaHaise)
o Alpha      Overhaul PCMCIA support                         (David Woodhouse, David Hinds)
o Alpha      Replace old NTFS driver with NTFS TNG driver    (Anton Altaparmakov)
o Alpha      More complete IEEE 802.2 stack                  (Arnaldo, Jay Schullist, from 
Procom donated code)
o Alpha      Full compliance with IPv6                       (Alexey Kuznetzov, Jun Murai, 
Yoshifuji Hideaki, USAGI team)
o Alpha      UMSDOS (Unix under MS-DOS) Rewrite              (Al Viro)
o Alpha      Scalable CPU bitmaps                            (Russ Weight)
* Alpha      Scalable Statistics Counter                     (Ravikiran Thirumalai)
* Alpha      Linux Kernel Crash Dumps                        (Matt Robinson, LKCD team)

o Started    Rewrite of the framebuffer layer                (James Simmons)
o Started    Rewrite of the console layer                    (James Simmons)
o Started    More complete NetBEUI stack                     (Arnaldo Carvalho de Melo, 
from Procom donated code)
o Started    Remove use of the BKL (Big Kernel Lock)         (Alan Cox, Robert Love, Neil 
Brown, etc.)
o Started    Change all drivers to new driver model          (All maintainers)
o Started    Reiserfs v4                                     (Reiserfs team)
o Started    Move ISDN4Linux to CAPI based interface         (ISDN4Linux team)

o Draft #2   New lightweight library (klibc)                 (Greg Kroah-Hartman)
o Draft #3   Replace initrd by initramfs                     (H. Peter Anvin, Al Viro)
o Planning   Add thrashing control                           (Rik van Riel)
o Planning   Remove all hardwired drivers from kernel        (Alan Cox, etc.)
o Planning   Generic parameter/command line interface        (Keith Owens)
o Planning   New mount API                                   (Al Viro)
o Planning   New MTRR (Memory Type Range Register) driver    (Dave Jones)


Cleanups:

o Merged     Break Configure.help into multiple files        (Linus Torvalds)

o Ready      Per network protocol slabcache & sock.h         (Arnaldo Carvalho de Melo)
o Ready      Switch to ->get_super() for file_system_type    (Al Viro)
o Ready      ->getattr() ->setattr() ->permission() changes  (Al Viro)

o Beta       file.h and INIT_TASK                            (Benjamin LaHaise)
o Beta       Remove dcache_lock                              (Maneesh Soni, IBM team)
o Beta       Proper UFS fixes, ext2 and locking cleanups     (Al Viro)
o Beta       Lifting limitations on mount(2)                 (Al Viro)

o Started    Per filesystem slabcache & fs.h                 (Daniel Phillips, Jeff Garzik)
o Started    Killing kdev_t for block devices                (Al Viro)
o Started    Split up x86 setup.c into managable pieces      (Dave Jones, Randy Dunlap)
o Started    Reorder x86 initialization                      (Dave Jones, Randy Dunlap)

Have some free time and want to help?  Check out the Kernel Janitor TO DO list for a list 
of 
source code cleanups you can work on.  A great place to start learning more about kernel 
internals!



