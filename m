Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289708AbSAWGZB>; Wed, 23 Jan 2002 01:25:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289702AbSAWGYv>; Wed, 23 Jan 2002 01:24:51 -0500
Received: from chmls18.ne.ipsvc.net ([24.147.1.153]:19586 "EHLO
	chmls18.ne.ipsvc.net") by vger.kernel.org with ESMTP
	id <S289291AbSAWGYn>; Wed, 23 Jan 2002 01:24:43 -0500
From: "Guillaume Boissiere" <boissiere@mediaone.net>
To: linux-kernel@vger.kernel.org
Date: Wed, 23 Jan 2002 01:23:39 -0500
MIME-Version: 1.0
Subject: [STATUS 2.5]  January 23, 2002
Message-ID: <3C4E109B.29109.2B8A7BFD@localhost>
X-mailer: Pegasus Mail for Windows (v4.01)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lots of new things this week.  First, a new URL that (yes!) people can 
bookmark:

http://www.kernelnewbies.org/status/status.html

Many thanks to John Levon, Rik van Riel and the folks at kernelnewbies.org 
for providing the hosting!  You guys rock.

Also, lots of new features (in bold) have been added this week.  Hopefully, 
most of the *truly* important stuff should be in the list now, maybe except 
a few things (nfs4? scsi?).  Otherwise, if more features get added than 
merged any given week, 2.5 is going to be long in the coming  :-)

Finally, I have to admit the amount of feedback I have received has been 
incredible and has helped improve this list dramatically, so big thanks 
to everyone who has sent me pointers, keep doing it.  My main concern right 
now is to keep this status list to a reasonnable size, otherwise it will 
become unmanageable. My plan is pretty simple, I will only accept:

1. A major feature, i.e. *lots* of people are anxious to get this in the 
   2.5 tree because they will use it (i.e kbuild or NAPI)
OR
2. A feature/cleanup that touches critical parts of the kernel and 
   requires lots of people to know about it because they will be affected 
   --> i.e. good communication of status is important (i.e some of the 
       VFS work).

In short, don't bother sending me driver updates...
And as usual, let me know of any inaccuracies, and I'll be happy to 
correct them.

Cheers, 

-- Guillaume

-------------------------------------------------------------
Kernel 2.5 status  -  January 23th, 2002
(Latest kernel release is 2.5.3-pre3)


Features:

o Merged     New scheduler for improved scalability          (Ingo Molnar, Davide Libenzi)
o Merged     Rewrite of the block IO (bio) layer             (Jens Axboe)
o Merged     New kernel device structure (kdev_t)            (Linus Torvalds, etc)
o Merged     Initial support for USB 2.0                     (David Brownell, Greg Kroah-Hartman, others)
* Merged     Per-process namespaces, late-boot cleanups      (Al Viro, Manfred Spraul)
o Merged     IDE layer update                                (Andre Hedrick)
o Merged     New driver API for Wireless Extensions (1/2)    (Jean Tourrilhes)

o Pending    Finalize new device naming convention           (Linus Torvalds)
o in -dj     Porting all input devices over to input API     (Vojtech Pavlik, James Simmons)

o Ready      Add User-Mode Linux (UML)                       (Jeff Dike)
o Ready      HDLC (High-level Data Link Control) update      (Krzysztof Halasa)
o Ready      Add ALSA (Advanced Linux Sound Architecture)    (ALSA team)
* Ready      Support reiserfs external journal               (Reiserfs team)
* Ready      Add hardware sensors drivers                    (lm_sensors team)
o Ready      Add preempt kernel option                       (Robert Love)

o <1 month   New kernel build system (kbuild 2.5)            (Keith Owens)
o <1 month   New kernel config system: CML2                  (Eric Raymond)

o Beta       Add support for CPU clock/voltage scaling       (Erik Mouw, Dave Jones, Russell King, Arjan van de 
Ven)
o Beta       Serial driver restructure                       (Russell King)
o Beta       New IO scheduler                                (Jens Axboe)
o Beta       NAPI Network interrupt mitigation               (Jamal Hadi Salim, Robert Olsson, Alexey Kuznetsov)
o Beta       Add JFS (Journaling FileSystem from IBM)        (JFS team)
o Beta       Add XFS (A journaling filesystem from SGI)      (XFS team)
o Beta       New VM with reverse mappings                    (Rik van Riel)
o Beta       Add resheduling points to remove latency        (Andrew Morton)
o Beta       Build option for Linux Trace Toolkit (LTT)      (Karim Yaghmour)
o Beta       Better event logging for enterprise systems     (evlog team)
* Beta       Add Linux Security Module (LSM)                 (LSM team)
* Beta       Generic ACL (Access Control List) support       (Nathan Scott)
* Beta       Hotplug CPU support                             (Rusty Russell)
* Beta       Per-mountpoint read-only, union-mounts, unionfs (Al Viro)

o Alpha      Better support of high-end NUMA machines        (NUMA team)
o Alpha      Add Asynchronous IO (aio) support               (Ben LaHaise)
o Alpha      EVMS (Enterprise Volume Management System)      (EVMS team)
o Alpha      Overhaul PCMCIA support                         (David Woodhouse, David Hinds)
o Alpha      Replace old NTFS driver with NTFS TNG driver    (Anton Altaparmakov)
o Alpha      More complete IEEE 802.2 stack                  (Arnaldo, Jay Schullist, from Procom donated code)
* Alpha      LVM (Logical Volume Manager) v2.0               (Heintz Mauelshagen, Andreas Dilger, LVM team)
* Alpha      Read-Copy Update Mutual Exclusion               (Dipankar Sarma, Rusty Russell, LSE Team)
* Alpha      Full compliance with IPv6                       (Alexey Kuznetzov, Jun Murai, Yoshifuji Hideaki, 
USAGI team)
* Alpha      Linux booting ELF images                        (Eric Biederman)
* Alpha      First pass at LinuxBIOS support                 (Eric Biederman)
* Alpha      UMSDOS Rewrite                                  (Al Viro)

o Started    Rewrite of the framebuffer layer                (James Simmons)
o Started    New driver model & unified device tree          (Patrick Mochel)
o Started    Rewrite of the console layer                    (James Simmons)
o Started    More complete NetBEUI stack                     (Arnaldo Carvalho de Melo, from Procom donated code)

o Draft #2   New lightweight library (klibc)                 (Greg Kroah-Hartman)
o Draft #3   Replace initrd by initramfs                     (H. Peter Anvin, Al Viro)
o Planning   Change all drivers to new driver model          (All maintainers)
o Planning   Add thrashing control                           (Rik van Riel)
o Planning   Remove all hardwired drivers from kernel        (Alan Cox, etc)
o Planning   Generic parameter/command line interface        (Keith Owens)
* Planning   Remove use of the BKL (Big Kernel Lock)         (Alan Cox, Robert Love, Neil Brown, others)
* Planning   New mount API                                   (Al Viro)


Cleanups:

o Ready      Per network protocol slabcache & sock.h         (Arnaldo Carvalho de Melo)
* Ready      Switch to ->get_super() for file_system_type    (Al Viro)
* Ready      ->getattr() ->setattr() ->permission() changes  (Al Viro)

o Beta       file.h and INIT_TASK                            (Benjamin LaHaise)
* Beta       Remove dcache_lock                              (Maneesh Soni, IBM team)
* Beta       Proper UFS fixes, ext2 and locking cleanups     (Al Viro)
* Beta       Lifting limitations on mount(2)                 (Al Viro)

o Started    Per filesystem slabcache & fs.h                 (Daniel Phillips, Jeff Garzik)
* Started    Killing kdev_t for block devices                (Al Viro)

Have some free time and want to help?  Check out the Kernel Janitor TO DO list for a list of source code 
cleanups you can work on.  A great place to start learning more about kernel internals!

