Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311811AbSCTQky>; Wed, 20 Mar 2002 11:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311819AbSCTQkq>; Wed, 20 Mar 2002 11:40:46 -0500
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:28058 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S311811AbSCTQk1>; Wed, 20 Mar 2002 11:40:27 -0500
From: "Guillaume Boissiere" <boissiere@attbi.com>
To: linux-kernel@vger.kernel.org
Date: Wed, 20 Mar 2002 11:39:12 -0500
MIME-Version: 1.0
Subject: [STATUS 2.5]  March 20, 2002
Message-ID: <3C9874E0.14526.3D4235FF@localhost>
X-mailer: Pegasus Mail for Windows (v4.01)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest status update for the 2.5 series is available at
http://kernelnewbies.org/status/ with links for each item.

Of note since last week is the merge of NAPI, which is a way 
to deal with high network packet load -- networking drivers
authors may want to take a look at the porting guide.
Also merged is a big ACPI patch, which should pave the way 
for better power management in Linux.

As usual, please let me know of anything incorrect or missing.  
Cheers,

-- Guillaume

------------------------------------------
Kernel 2.5 status  -  March 20th, 2002
(Latest kernel release is 2.5.7)


Features:

Merged
o in 2.5.1+   Rewrite of the block IO (bio) layer             (Jens Axboe)
o in 2.5.2    Initial support for USB 2.0                     (David 
Brownell, Greg Kroah-Hartman, etc.)
o in 2.5.2    Per-process namespaces, late-boot cleanups      (Al Viro, 
Manfred Spraul)
o in 2.5.2+   New scheduler for improved scalability          (Ingo Molnar)
o in 2.5.2+   New kernel device structure (kdev_t)            (Linus 
Torvalds, etc.)
o in 2.5.3    IDE layer update                                (Andre 
Hedrick)
o in 2.5.3    Support reiserfs external journal               (Reiserfs 
team)
o in 2.5.3    Generic ACL (Access Control List) support       (Nathan Scott)
o in 2.5.3    PnP BIOS driver                                 (Alan Cox, 
Thomas Hood, Dave Jones, etc.)
o in 2.5.3+   New driver model & unified device tree          (Patrick 
Mochel)
o in 2.5.4    Add preempt kernel option                       (Robert Love, 
MontaVista team)
o in 2.5.4    Support for Next Generation POSIX Threading     (NGPT team)
o in 2.5.4+   Porting all input devices over to input API     (Vojtech 
Pavlik, James Simmons)
o in 2.5.5    Add ALSA (Advanced Linux Sound Architecture)    (ALSA team)
o in 2.5.5    Pagetables in highmem support                   (Ingo Molnar, 
Arjan van de Ven)
o in 2.5.5    New architecture: AMD 64-bit (x86-64)           (Andi Kleen, 
x86-64 Linux team)
o in 2.5.5    New architecture: PowerPC 64-bit (ppc64)        (Anton 
Blanchard, ppc64 team)
o in 2.5.6    Add JFS (Journaling FileSystem from IBM)        (JFS team)
o in 2.5.6    per_cpu infrastructure                          (Rusty 
Russell)
o in 2.5.6    HDLC (High-level Data Link Control) update      (Krzysztof 
Halasa)
o in 2.5.6    smbfs Unicode and large file support            (Urban 
Widmark) 
o in 2.5.7    New driver API for Wireless Extensions          (Jean 
Tourrilhes)
o in 2.5.7    Video for Linux (V4L) redesign                  (Gerd Knorr)
o in 2.5.7    Futexes (Fast Lightweight Userspace Semaphores) (Rusty 
Russell, etc.)
o in 2.5.7+   NAPI network interrupt mitigation               (Jamal Hadi 
Salim, Robert Olsson, Alexey Kuznetsov)
* in 2.5.7+   ACPI (Advanced Configuration & Power Interface) (Andy Grover, 
ACPI team)

o Pending     Finalize new device naming convention           (Linus 
Torvalds)
o in -dj      Rewrite of the framebuffer layer                (James 
Simmons)
* in -ac      Strict address space accounting                 (Alan Cox)
* in -ac      PCMCIA Zoom video support                       (Alan Cox)

o Ready       Add hardware sensors drivers                    (lm_sensors 
team)
o Ready       New kernel config system: CML2                  (Eric Raymond)
o Ready       Read-Copy Update Mutual Exclusion               (Dipankar 
Sarma, Rusty Russell, Andrea Arcangeli, LSE Team)
o Ready       Better event logging for enterprise systems     (Larry 
Kessler, evlog team)
o Ready       New quota system supporting plugins             (Jan Kara)

o Beta        New kernel build system (kbuild 2.5)            (Keith Owens)
o Beta        Add support for CPU clock/voltage scaling       (Erik Mouw, 
Dave Jones, Russell King, Arjan van de Ven)
o Beta        Serial driver restructure                       (Russell King)
o Beta        New IO scheduler                                (Jens Axboe)
o Beta        Add XFS (A journaling filesystem from SGI)      (XFS team)
o Beta        New VM with reverse mappings                    (Rik van Riel)
o Beta        Fix long-held locks for low scheduling latency  (Andrew 
Morton, Robert Love, etc.)
o Beta        Build option for Linux Trace Toolkit (LTT)      (Karim 
Yaghmour)
o Beta        Add Linux Security Module (LSM)                 (LSM team)
o Beta        Hotplug CPU support                             (Rusty 
Russell)
o Beta        Per-mountpoint read-only, union-mounts, unionfs (Al Viro)
o Beta        EVMS (Enterprise Volume Management System)      (EVMS team)
o Beta        LVM (Logical Volume Manager) v2.0               (LVM team)
o Beta        Linux booting ELF images                        (Eric 
Biederman)
o Beta        First pass at LinuxBIOS support                 (Eric 
Biederman)
o Beta        Dynamic Probes                                  (Suparna 
Bhattacharya, dprobes team)
o Beta        Scalable CPU bitmasks                           (Russ Weight)
o Beta        Page table sharing                              (Daniel 
Phillips)
o Beta        Rewrite of the console layer                    (James 
Simmons)
o Beta        ext2/ext3 online resize support                 (Andreas 
Dilger)
o Beta        Radix-tree pagecache                            (Momchil 
Velikov, Christoph Hellwig)
o Beta        Replace old NTFS driver with NTFS TNG driver    (Anton 
Altaparmakov)
o Beta        Fast walk dcache                                (Hanna Linder)
o Beta        Add User-Mode Linux (UML)                       (Jeff Dike)

o Alpha       Better support of high-end NUMA machines        (NUMA team)
o Alpha       Add Asynchronous IO (aio) support               (Ben LaHaise)
o Alpha       Overhaul PCMCIA support                         (David 
Woodhouse, David Hinds)
o Alpha       More complete IEEE 802.2 stack                  (Arnaldo, Jay 
Schullist, from Procom donated code)
o Alpha       Full compliance with IPv6                       (Alexey 
Kuznetzov, Jun Murai, Yoshifuji Hideaki, USAGI team)
o Alpha       UMSDOS (Unix under MS-DOS) Rewrite              (Al Viro)
o Alpha       Scalable Statistics Counter                     (Ravikiran 
Thirumalai)
o Alpha       Linux Kernel Crash Dumps                        (Matt 
Robinson, LKCD team)
o Alpha       Add support for NFS v4                          (NFS v4 team)
o Alpha       ext2/ext3 large directory support: HTree index  (Daniel 
Phillips, Christopher Li, Ted Ts'o)
o Alpha       Delayed disk block allocation                   (Andrew 
Morton)
* Alpha       Improved i2o (Intelligent Input/Ouput) layer    (Alan Cox)

o Started     More complete NetBEUI stack                     (Arnaldo 
Carvalho de Melo, from Procom donated code)
o Started     Remove use of the BKL (Big Kernel Lock)         (Alan Cox, 
Robert Love, Neil Brown, etc.)
o Started     Change all drivers to new driver model          (All 
maintainers)
o Started     Reiserfs v4                                     (Reiserfs 
team)
o Started     Move ISDN4Linux to CAPI based interface         (ISDN4Linux 
team)

o Draft #2    New lightweight library (klibc)                 (Greg Kroah-
Hartman)
o Draft #3    Replace initrd by initramfs                     (H. Peter 
Anvin, Al Viro)
o Planning    Add thrashing control                           (Rik van Riel)
o Planning    Remove all hardwired drivers from kernel        (Alan Cox, 
etc.)
o Planning    Generic parameter/command line interface        (Keith Owens)
o Planning    New mount API                                   (Al Viro)
o Planning    New MTRR (Memory Type Range Register) driver    (Dave Jones)


Cleanups:

Merged
o in 2.5.3    Break Configure.help into multiple files        (Linus 
Torvalds)
o in 2.5.3    Untangle include file dependancies              (Dave Jones, 
Roman Zippel)
o in 2.5.4    Per network protocol slabcache & sock.h         (Arnaldo 
Carvalho de Melo)
o in 2.5.4    Per filesystem slabcache & fs.h                 (Daniel 
Phillips, Jeff Garzik, Al Viro)
o in 2.5.6    Killing kdev_t for block devices                (Al Viro)

o Ready       Switch to ->get_super() for file_system_type    (Al Viro)
o Ready       ->getattr() ->setattr() ->permission() changes  (Al Viro)
o Ready       Remove dcache_lock                              (Maneesh 
Soni, IBM team)

o Beta        file.h and INIT_TASK                            (Benjamin 
LaHaise)
o Beta        Proper UFS fixes, ext2 and locking cleanups     (Al Viro)
o Beta        Lifting limitations on mount(2)                 (Al Viro)

o Started     Split up x86 setup.c into managable pieces      (Dave Jones, 
Randy Dunlap)
o Started     Reorder x86 initialization                      (Dave Jones, 
Randy Dunlap)

Have some free time and want to help?  Check out the Kernel Janitor 
TO DO list for a list of source code cleanups you can work on.  
A great place to start learning more about kernel internals!



