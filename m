Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313861AbSDJVqc>; Wed, 10 Apr 2002 17:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313865AbSDJVqb>; Wed, 10 Apr 2002 17:46:31 -0400
Received: from rwcrmhc54.attbi.com ([216.148.227.87]:21403 "EHLO
	rwcrmhc54.attbi.com") by vger.kernel.org with ESMTP
	id <S313861AbSDJVq3>; Wed, 10 Apr 2002 17:46:29 -0400
From: "Guillaume Boissiere" <boissiere@attbi.com>
To: linux-kernel@vger.kernel.org
Date: Wed, 10 Apr 2002 17:46:19 -0400
MIME-Version: 1.0
Subject: [STATUS 2.5]  April 10, 2002
Message-ID: <3CB47A6B.14953.E164712@localhost>
X-mailer: Pegasus Mail for Windows (v4.01)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Things are continuing to move along, with quite a bit of work 
being done on IDE, USB and Big Kernel Lock (BLK) removal in the 
last couple of weeks.

As usual, you can find URLs pointing to all these projects on 
the Kernel 2.5 Status Page at:
          http://kernelnewbies.org/status/

Please let me know of any inaccuracies or missing items.  
I'm planning to do a major spring cleanup for next week -- in 
particular of the projects that have been marked as Ready
for quite some time.

Enjoy!

-- Guillaume

----------------------------------------------
Kernel 2.5 status  -  April 10th, 2002
(Latest kernel release is 2.5.8-pre3)


Features:

Merged
o in 2.5.1+   Rewrite of the block IO (bio) layer             (Jens Axboe)
o in 2.5.2    Initial support for USB 2.0                     (David Brownell, Greg Kroah-
Hartman, etc.)
o in 2.5.2    Per-process namespaces, late-boot cleanups      (Al Viro, Manfred Spraul)
o in 2.5.2+   New scheduler for improved scalability          (Ingo Molnar)
o in 2.5.2+   New kernel device structure (kdev_t)            (Linus Torvalds, etc.)
o in 2.5.3    IDE layer update                                (Andre Hedrick)
o in 2.5.3    Support reiserfs external journal               (Reiserfs team)
o in 2.5.3    Generic ACL (Access Control List) support       (Nathan Scott)
o in 2.5.3    PnP BIOS driver                                 (Alan Cox, Thomas Hood, Dave 
Jones, etc.)
o in 2.5.3+   New driver model & unified device tree          (Patrick Mochel)
o in 2.5.4    Add preempt kernel option                       (Robert Love, MontaVista team)
o in 2.5.4    Support for Next Generation POSIX Threading     (NGPT team)
o in 2.5.4+   Porting all input devices over to input API     (Vojtech Pavlik, James Simmons)
o in 2.5.5    Add ALSA (Advanced Linux Sound Architecture)    (ALSA team)
o in 2.5.5    Pagetables in highmem support                   (Ingo Molnar, Arjan van de Ven)
o in 2.5.5    New architecture: AMD 64-bit (x86-64)           (Andi Kleen, x86-64 Linux team)
o in 2.5.5    New architecture: PowerPC 64-bit (ppc64)        (Anton Blanchard, ppc64 team)
o in 2.5.6    Add JFS (Journaling FileSystem from IBM)        (JFS team)
o in 2.5.6    per_cpu infrastructure                          (Rusty Russell)
o in 2.5.6    HDLC (High-level Data Link Control) update      (Krzysztof Halasa)
o in 2.5.6    smbfs Unicode and large file support            (Urban Widmark) 
o in 2.5.7    New driver API for Wireless Extensions          (Jean Tourrilhes)
o in 2.5.7    Video for Linux (V4L) redesign                  (Gerd Knorr)
o in 2.5.7    Futexes (Fast Lightweight Userspace Semaphores) (Rusty Russell, etc.)
o in 2.5.7+   NAPI network interrupt mitigation               (Jamal Hadi Salim, Robert Olsson, 
Alexey Kuznetsov)
o in 2.5.7+   ACPI (Advanced Configuration & Power Interface) (Andy Grover, ACPI team)

o Pending     Finalize new device naming convention           (Linus Torvalds)
o in -dj      Rewrite of the framebuffer layer                (James Simmons)
o in -ac      Strict address space accounting                 (Alan Cox)
o in -ac      PCMCIA Zoom video support                       (Alan Cox)
o in -ac      More complete IEEE 802.2 stack                  (Arnaldo, Jay Schullist, from 
Procom donated code)

o Ready       Add hardware sensors drivers                    (lm_sensors team)
o Ready       New kernel config system: CML2                  (Eric Raymond)
o Ready       Read-Copy Update Mutual Exclusion               (Dipankar Sarma, Rusty Russell, 
Andrea Arcangeli, LSE Team)
o Ready       Better event logging for enterprise systems     (Larry Kessler, evlog team)
o Ready       New quota system supporting plugins             (Jan Kara)
o Ready       Replace old NTFS driver with NTFS TNG driver    (Anton Altaparmakov)
o Ready       New VM with reverse mappings                    (Rik van Riel)
o Ready       Linux booting ELF images                        (Eric Biederman)
o Ready       First pass at LinuxBIOS support                 (Eric Biederman)
o Ready       Radix-tree pagecache                            (Momchil Velikov, Christoph 
Hellwig)

o Beta        New kernel build system (kbuild 2.5)            (Keith Owens)
o Beta        Add support for CPU clock/voltage scaling       (Erik Mouw, Dave Jones, Russell 
King, Arjan van de Ven)
o Beta        Serial driver restructure                       (Russell King)
o Beta        New IO scheduler                                (Jens Axboe)
o Beta        Add XFS (A journaling filesystem from SGI)      (XFS team)
o Beta        Fix long-held locks for low scheduling latency  (Andrew Morton, Robert Love, etc.)
o Beta        Build option for Linux Trace Toolkit (LTT)      (Karim Yaghmour)
o Beta        Add Linux Security Module (LSM)                 (LSM team)
o Beta        Hotplug CPU support                             (Rusty Russell)
o Beta        Per-mountpoint read-only, union-mounts, unionfs (Al Viro)
o Beta        EVMS (Enterprise Volume Management System)      (EVMS team)
o Beta        LVM (Logical Volume Manager) v2.0               (LVM team)
o Beta        Dynamic Probes                                  (Suparna Bhattacharya, dprobes 
team)
o Beta        Scalable CPU bitmasks                           (Russ Weight)
o Beta        Page table sharing                              (Daniel Phillips)
o Beta        Rewrite of the console layer                    (James Simmons)
o Beta        ext2/ext3 online resize support                 (Andreas Dilger)
o Beta        Fast walk dcache                                (Hanna Linder)
o Beta        Add User-Mode Linux (UML)                       (Jeff Dike)
o Beta        UDF Write support for CD-RW and CD-R            (Jens Axboe, Peter Osterlund)

o Alpha       Better support of high-end NUMA machines        (NUMA team)
o Alpha       Add Asynchronous IO (aio) support               (Ben LaHaise)
o Alpha       Overhaul PCMCIA support                         (David Woodhouse, David Hinds)
o Alpha       Full compliance with IPv6                       (Alexey Kuznetzov, Jun Murai, 
Yoshifuji Hideaki, USAGI team)
o Alpha       UMSDOS (Unix under MS-DOS) Rewrite              (Al Viro)
o Alpha       Scalable Statistics Counter                     (Ravikiran Thirumalai)
o Alpha       Linux Kernel Crash Dumps                        (Matt Robinson, LKCD team)
o Alpha       Add support for NFS v4                          (NFS v4 team)
o Alpha       ext2/ext3 large directory support: HTree index  (Daniel Phillips, Christopher Li, 
Ted Ts'o)
o Alpha       Delayed disk block allocation                   (Andrew Morton)
o Alpha       Improved i2o (Intelligent Input/Ouput) layer    (Alan Cox)
o Alpha       New MTRR (Memory Type Range Register) driver    (Patrick Mochel)
o Alpha       Remove use of the BKL (Big Kernel Lock)         (Alan Cox, Robert Love, Neil 
Brown, Dave Hansen, etc.)
* Alpha       Zerocopy NFS                                    (Hirokazu Takahashi)

o Started     More complete NetBEUI stack                     (Arnaldo Carvalho de Melo, from 
Procom donated code)
o Started     Change all drivers to new driver model          (All maintainers)
o Started     Reiserfs v4                                     (Reiserfs team)
o Started     Move ISDN4Linux to CAPI based interface         (ISDN4Linux team)

o Draft #2    New lightweight library (klibc)                 (Greg Kroah-Hartman)
o Draft #3    Replace initrd by initramfs                     (H. Peter Anvin, Al Viro)
o Planning    Add thrashing control                           (Rik van Riel)
o Planning    Remove all hardwired drivers from kernel        (Alan Cox, etc.)
o Planning    Generic parameter/command line interface        (Keith Owens)
o Planning    New mount API                                   (Al Viro)


Cleanups:

Merged
o in 2.5.3    Break Configure.help into multiple files        (Linus Torvalds)
o in 2.5.3    Untangle include file dependancies              (Dave Jones, Roman Zippel)
o in 2.5.4    Per network protocol slabcache & sock.h         (Arnaldo Carvalho de Melo)
o in 2.5.4    Per filesystem slabcache & fs.h                 (Daniel Phillips, Jeff Garzik, Al 
Viro)
o in 2.5.6    Killing kdev_t for block devices                (Al Viro)

o Ready       Switch to ->get_super() for file_system_type    (Al Viro)
o Ready       ->getattr() ->setattr() ->permission() changes  (Al Viro)
o Ready       Remove dcache_lock                              (Maneesh Soni, IBM team)

o Beta        file.h and INIT_TASK                            (Benjamin LaHaise)
o Beta        Proper UFS fixes, ext2 and locking cleanups     (Al Viro)
o Beta        Lifting limitations on mount(2)                 (Al Viro)

o Alpha       Split up x86 setup.c into managable pieces      (Patrick Mochel)

o Started     Reorder x86 initialization                      (Dave Jones, Randy Dunlap)

Have some free time and want to help?  Check out the Kernel Janitor 
TO DO list for a list of source code cleanups you can work on.  
A great place to start learning more about kernel internals!



