Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317759AbSGaFLD>; Wed, 31 Jul 2002 01:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317762AbSGaFLD>; Wed, 31 Jul 2002 01:11:03 -0400
Received: from pop.adiglobal.com ([66.207.47.93]:61964 "EHLO
	mail.adiglobal.com") by vger.kernel.org with ESMTP
	id <S317759AbSGaFLB>; Wed, 31 Jul 2002 01:11:01 -0400
From: "Guillaume Boissiere" <boissiere@adiglobal.com>
To: linux-kernel@vger.kernel.org
Date: Wed, 31 Jul 2002 01:06:43 -0400
MIME-Version: 1.0
Subject: [STATUS 2.5]  July 31, 2002
Message-ID: <3D473823.6656.12E45DEA@localhost>
X-mailer: Pegasus Mail for Windows (v4.01)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest status update is available at:
            http://www.kernelnewbies.org/status/

Of note this week for security enthusiasts is the beginning of the 
Linux Security Module (LSM) merge.

As usual, feedback and corrections welcome.
Enjoy!

-- Guillaume


--------------------------------------------------------
Linux Kernel 2.5 Status  -  July 31th, 2002
(Latest kernel release is 2.5.29)


Features:

Merged
o in 2.5.1+   Rewrite of the block IO (bio) layer             (Jens Axboe)
o in 2.5.2    Initial support for USB 2.0                     (David Brownell, Greg Kroah-Hartman, etc.)
o in 2.5.2    Per-process namespaces, late-boot cleanups      (Al Viro, Manfred Spraul)
o in 2.5.2+   New scheduler for improved scalability          (Ingo Molnar)
o in 2.5.2+   New kernel device structure (kdev_t)            (Linus Torvalds, etc.)
o in 2.5.3    IDE layer update                                (Andre Hedrick)
o in 2.5.3    Support reiserfs external journal               (Reiserfs team)
o in 2.5.3    Generic ACL (Access Control List) support       (Nathan Scott)
o in 2.5.3    PnP BIOS driver                                 (Alan Cox, Thomas Hood, Dave Jones, etc.)
o in 2.5.3+   New driver model & unified device tree          (Patrick Mochel)
o in 2.5.4    Add preempt kernel option                       (Robert Love, MontaVista team)
o in 2.5.4    Support for Next Generation POSIX Threading     (NGPT team)
o in 2.5.4+   Porting all input devices over to input API     (Vojtech Pavlik, James Simmons)
o in 2.5.5    Add ALSA (Advanced Linux Sound Architecture)    (ALSA team)
o in 2.5.5    Pagetables in highmem support                   (Ingo Molnar, Arjan van de Ven)
o in 2.5.5    New architecture: AMD 64-bit (x86-64)           (Andi Kleen, x86-64 Linux team)
o in 2.5.5    New architecture: PowerPC 64-bit (ppc64)        (Anton Blanchard, ppc64 team)
o in 2.5.5+   IDE subsystem rewrite                           (Martin Dalecki)
o in 2.5.6    Add JFS (Journaling FileSystem from IBM)        (JFS team)
o in 2.5.6    per_cpu infrastructure                          (Rusty Russell)
o in 2.5.6    HDLC (High-level Data Link Control) update      (Krzysztof Halasa)
o in 2.5.6    smbfs Unicode and large file support            (Urban Widmark) 
o in 2.5.7    New driver API for Wireless Extensions          (Jean Tourrilhes)
o in 2.5.7    Video for Linux (V4L) redesign                  (Gerd Knorr)
o in 2.5.7    Futexes (Fast Lightweight Userspace Semaphores) (Rusty Russell, etc.)
o in 2.5.7+   NAPI network interrupt mitigation               (Jamal Hadi Salim, Robert Olsson, Alexey 
Kuznetsov)
o in 2.5.7+   ACPI (Advanced Configuration & Power Interface) (Andy Grover, ACPI team)
o in 2.5.8    Syscall interface for CPU task affinity         (Robert Love)
o in 2.5.8    Radix-tree pagecache                            (Momchil Velikov, Christoph Hellwig)
o in 2.5.9    Smarter IRQ balancing                           (Ingo Molnar)
o in 2.5.11   Replace old NTFS driver with NTFS TNG driver    (Anton Altaparmakov)
o in 2.5.11   Fast walk dcache                                (Hanna Linder)
o in 2.5.11+  Rewrite of the framebuffer layer                (James Simmons)
o in 2.5.12+  Rewrite of the buffer layer                     (Andrew Morton)
o in 2.5.14   Support for IDE TCQ (Tagged Command Queueing)   (Jens Axboe)
o in 2.5.14   Bluetooth support (no longer experimental!)     (Maxim Krasnyansky, Bluetooth team)
o in 2.5.17   New quota system supporting plugins             (Jan Kara)
o in 2.5.17+  Move ISDN4Linux to CAPI based interface         (Kai Germaschewski, ISDN4Linux team)
o in 2.5.18   Software suspend (to disk & RAM)                (Pavel Machek)
o in 2.5.23   More complete IEEE 802.2 stack                  (Arnaldo, Jay Schullist, from Procom 
donated code)
o in 2.5.23+  Hotplug CPU support                             (Rusty Russell)
o in 2.5.25   Faster internal kernel clock frequency          (Linus Torvalds)
o in 2.5.26   Direct pagecache <-> BIO disk I/O               (Andrew Morton)
o in 2.5.27+  New VM with reverse mappings                    (Rik van Riel)
o in 2.5.28+  Serial driver restructure                       (Russell King)
o in 2.5.28   Remove the "Big IRQ lock"                       (Ingo Molnar)
* in 2.5.29   Thread-Local Storage (TLS) support              (Ingo Molnar)
o in 2.5.29+  Add Linux Security Module (LSM)                 (LSM team)

o in -dj      Rewrite of the console layer                    (James Simmons)
o in -dj      New MTRR (Memory Type Range Register) driver    (Patrick Mochel)
o in -dj      Add support for CPU clock/voltage scaling       (Erik Mouw, Dave Jones, Russell King, 
Arjan van de Ven)
o in -ac      Strict address space accounting                 (Alan Cox)
o in -ac      PCMCIA Zoom video support                       (Alan Cox)
o in -ac      Improved i2o (Intelligent Input/Ouput) layer    (Alan Cox)

o Ready       Read-Copy Update (RCU) Mutual Exclusion         (Dipankar Sarma, Rusty Russell, Andrea 
Arcangeli, LSE Team)
o Ready       Add hardware sensors drivers                    (lm_sensors team)
o Ready       Build option for Linux Trace Toolkit (LTT)      (Karim Yaghmour)
o Ready       Remove the 2TB block device limit               (Peter Chubb)
o Ready       Add User-Mode Linux (UML)                       (Jeff Dike)

o Beta        New kernel build system (kbuild 2.5)            (Keith Owens)
o Beta        New IO scheduler                                (Jens Axboe)
o Beta        Add XFS (A journaling filesystem from SGI)      (XFS team)
o Beta        Fix long-held locks for low scheduling latency  (Andrew Morton, Robert Love, etc.)
o Beta        Per-mountpoint read-only, union-mounts, unionfs (Al Viro)
o Beta        EVMS (Enterprise Volume Management System)      (EVMS team)
o Beta        Device mapper for Logical Volume Manager (LVM2) (LVM team)
o Beta        Dynamic Probes                                  (Suparna Bhattacharya, dprobes team)
o Beta        Page table sharing                              (Daniel Phillips, Dave McCracken)
o Beta        ext2/ext3 online resize support                 (Andreas Dilger)
o Beta        UDF Write support for CD-R/RW (packet writing)  (Jens Axboe, Peter Osterlund)
o Beta        Asynchronous IO (aio) support                   (Ben LaHaise)
o Beta        More complete NetBEUI stack                     (Arnaldo Carvalho de Melo, from Procom 
donated code)
o Beta        Better event logging for enterprise systems     (Larry Kessler, evlog team)
o Beta        High resolution timers                          (George Anzinger, etc.)
o Beta        discontigmem support                            (Pat Gaughen, Jack Steiner, Tony Luck, 
etc.)
* Beta        Add new CIFS (Common Internet File System)      (Steve French)

o Alpha       Full compliance with IPv6                       (Alexey Kuznetzov, Jun Murai, Yoshifuji 
Hideaki, USAGI team)
o Alpha       UMSDOS (Unix under MS-DOS) Rewrite              (Al Viro)
o Alpha       Scalable Statistics Counter                     (Ravikiran Thirumalai)
o Alpha       Linux Kernel Crash Dumps                        (Matt Robinson, LKCD team)
o Alpha       Add support for NFS v4                          (NFS v4 team)
o Alpha       ext2/ext3 large directory support: HTree index  (Daniel Phillips, Christopher Li, Ted 
Ts'o)
o Alpha       Remove use of the BKL (Big Kernel Lock)         (Alan Cox, Robert Love, Neil Brown, Dave 
Hansen, etc.)
o Alpha       Zerocopy NFS                                    (Hirokazu Takahashi)
o Alpha       Change all drivers to new driver model          (All maintainers)
o Alpha       SCTP (Stream Control Transmission Protocol)     (lksctp team)
o Alpha       USB gadget support                              (Stuart Lynne, Greg Kroah-Hartman)
o Alpha       NUMA aware scheduler extensions                 (Erich Focht)     
o Alpha       Basic NUMA API                                  (Matt Dobson)
o Alpha       NUMA topology support                           (Matt Dobson)
o Alpha       Non-linear memory support                       (Martin Bligh, Daniel Phillips)
o Alpha       Parallelizing page replacement                  (William Lee Irwin)
o Alpha       VM large page support                           (Simon Winwood, Hubertus Franke)
o Alpha       Remove waitqueue heads from kernel structures   (William Lee Irwin)
o Alpha       Remove the global tasklist                      (William Lee Irwin)
o Alpha       Overhaul PCMCIA support                         (David Woodhouse, David Hinds)

o Started     Reiserfs v4                                     (Reiserfs team)
o Started     Serial ATA support                              (Andre Hedrick)
o Started     InfiniBand support                              (InfiniBand team)
o Started     Fix device naming issues                        (Patrick Mochel, Greg Kroah-Hartman)
o Started     Replace initrd by initramfs                     (H. Peter Anvin, Al Viro)
o Started     Make AppleTalk use shared skbs and refcounting  (Arnaldo Carvalho de Melo)
o Started     SCSI multipath IO (with NUMA support)           (Patrick Mansfield, Mike Anderson)
o Started     NUMA aware slab allocator                       (Martin Bligh)

o Draft #2    New lightweight library (klibc)                 (Greg Kroah-Hartman)
o Planning    Add thrashing control                           (Rik van Riel)
o Planning    Remove all hardwired drivers from kernel        (Alan Cox, etc.)
o Planning    Generic parameter/command line interface        (Keith Owens)
o Planning    New mount API                                   (Al Viro)


Cleanups:

Merged
o in 2.5.3    Break Configure.help into multiple files        (Linus Torvalds)
o in 2.5.3    Untangle sched.h & fs.h include dependancies    (Dave Jones, Roman Zippel)
o in 2.5.4    Per network protocol slabcache & sock.h         (Arnaldo Carvalho de Melo)
o in 2.5.4    Per filesystem slabcache & fs.h                 (Daniel Phillips, Jeff Garzik, Al Viro)
o in 2.5.6    Killing kdev_t for block devices                (Al Viro)
o in 2.5.18+  ->getattr() ->setattr() ->permission() changes  (Al Viro)
o in 2.5.21   Split up x86 setup.c into managable pieces      (Patrick Mochel)
o in 2.5.23+  Major MD tool (RAID 5) cleanup                  (Neil Brown)

o Ready       Switch to ->get_super() for file_system_type    (Al Viro)

o Beta        file.h and INIT_TASK                            (Benjamin LaHaise)
o Beta        Proper UFS fixes, ext2 and locking cleanups     (Al Viro)
o Beta        Lifting limitations on mount(2)                 (Al Viro)
o Beta        Remove dcache_lock                              (Maneesh Soni, IBM team)

o Started     Reorder x86 initialization                      (Dave Jones, Randy Dunlap)
* Started     Remove incomplete SPX network stack             (Arnaldo Carvalho de Melo)
* Started     Rework datalink protocols to not use cli/sti    (Arnaldo Carvalho de Melo)

Have some free time and want to help?  Check out the Kernel Janitor 
TO DO list for a list of source code cleanups you can work on.  
A great place to start learning more about kernel internals!

