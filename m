Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261738AbSJIQAR>; Wed, 9 Oct 2002 12:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261840AbSJIQAQ>; Wed, 9 Oct 2002 12:00:16 -0400
Received: from out001pub.verizon.net ([206.46.170.140]:62929 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP
	id <S261738AbSJIQAK>; Wed, 9 Oct 2002 12:00:10 -0400
From: "Guillaume Boissiere" <boissiere@adiglobal.com>
To: linux-kernel@vger.kernel.org
Date: Wed, 9 Oct 2002 12:05:28 -0400
MIME-Version: 1.0
Subject: [STATUS 2.5]  October 9, 2002
Message-ID: <3DA41B88.14599.2336B580@localhost>
X-mailer: Pegasus Mail for Windows (v4.01)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at out001.verizon.net from [64.152.17.166] at Wed, 9 Oct 2002 11:05:45 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest 2.5 status update is available at 
    http://www.kernelnewbies.org/status

Only 3 weeks left till Halloween, and still way to many 
items left on the list to be merged in that timeframe.

Come on, be real and tell me what to remove!  :-)

-- Guillaume


---------------------------------
Linux Kernel 2.5 Status - October 9th, 2002
(Latest kernel release is 2.5.41)

Items in bold have changed since last week.
Items in grey are post Halloween (feature freeze).

Features:  
 
Merged  
o in 2.5.1+  Rewrite of the block IO (bio) layer  (Jens Axboe)  
o in 2.5.2  Initial support for USB 2.0  (David Brownell, Greg Kroah-Hartman, etc.)  
o in 2.5.2  Per-process namespaces, late-boot cleanups  (Al Viro, Manfred Spraul)  
o in 2.5.2+  New scheduler for improved scalability  (Ingo Molnar)  
o in 2.5.2+  New kernel device structure (kdev_t)  (Linus Torvalds, etc.)  
o in 2.5.3  IDE layer update  (Andre Hedrick)  
o in 2.5.3  Support reiserfs external journal  (Reiserfs team)  
o in 2.5.3  Generic ACL (Access Control List) support  (Nathan Scott)  
o in 2.5.3  PnP BIOS driver  (Alan Cox, Thomas Hood, Dave Jones, etc.)  
o in 2.5.3+  New driver model & unified device tree  (Patrick Mochel)  
o in 2.5.4  Add preempt kernel option  (Robert Love, MontaVista team)  
o in 2.5.4  Support for Next Generation POSIX Threading  (NGPT team)  
o in 2.5.5  Add ALSA (Advanced Linux Sound Architecture)  (ALSA team)  
o in 2.5.5  Pagetables in highmem support  (Ingo Molnar, Arjan van de Ven)  
o in 2.5.5  New architecture: AMD 64-bit (x86-64)  (Andi Kleen, x86-64 Linux team)  
o in 2.5.5  New architecture: PowerPC 64-bit (ppc64)  (Anton Blanchard, ppc64 team)  
o in 2.5.6  Add JFS (Journaling FileSystem from IBM)  (JFS team)  
o in 2.5.6  per_cpu infrastructure  (Rusty Russell)  
o in 2.5.6  HDLC (High-level Data Link Control) update  (Krzysztof Halasa)  
o in 2.5.6  smbfs Unicode and large file support  (Urban Widmark)  
o in 2.5.7  New driver API for Wireless Extensions  (Jean Tourrilhes)  
o in 2.5.7  Video for Linux (V4L) redesign  (Gerd Knorr)  
o in 2.5.7  Futexes (Fast Lightweight Userspace Semaphores)  (Rusty Russell, etc.)  
o in 2.5.7+  NAPI network interrupt mitigation  (Jamal Hadi Salim, Robert Olsson, Alexey Kuznetsov)  
o in 2.5.7+  ACPI (Advanced Configuration & Power Interface)  (Andy Grover, ACPI team)  
o in 2.5.8  Syscall interface for CPU task affinity  (Robert Love)  
o in 2.5.8  Radix-tree pagecache  (Momchil Velikov, Christoph Hellwig)  
o in 2.5.9  Smarter IRQ balancing  (Ingo Molnar)  
o in 2.5.11  Replace old NTFS driver with NTFS TNG driver  (Anton Altaparmakov)  
o in 2.5.11  Fast walk dcache  (Hanna Linder)  
o in 2.5.11+  Rewrite of the framebuffer layer  (James Simmons)  
o in 2.5.12+  Rewrite of the buffer layer  (Andrew Morton)  
o in 2.5.14  Support for IDE TCQ (Tagged Command Queueing)  (Jens Axboe)  
o in 2.5.14  Bluetooth support (no longer experimental!)  (Maxim Krasnyansky, Bluetooth team)  
o in 2.5.17  New quota system supporting plugins  (Jan Kara)  
o in 2.5.17+  Move ISDN4Linux to CAPI based interface  (Kai Germaschewski, ISDN4Linux team)  
o in 2.5.18  Software suspend (to disk & RAM)  (Pavel Machek)  
o in 2.5.23  More complete IEEE 802.2 stack  (Arnaldo, Jay Schullist, from Procom donated code)  
o in 2.5.23+  Hotplug CPU support  (Rusty Russell)  
o in 2.5.25  Faster internal kernel clock frequency  (Linus Torvalds)  
o in 2.5.26  Direct pagecache <-> BIO disk I/O  (Andrew Morton)  
o in 2.5.27+  New VM with reverse mappings  (Rik van Riel)  
o in 2.5.28+  Serial driver restructure  (Russell King)  
o in 2.5.28  Remove the "Big IRQ lock"  (Ingo Molnar)  
o in 2.5.29+  Thread-Local Storage (TLS) support  (Ingo Molnar)  
o in 2.5.29+  Add Linux Security Module (LSM)  (LSM team)  
o in 2.5.29+  Strict address space accounting  (Alan Cox)  
o in 2.5.31+  Disk description cleanups  (Al Viro)  
o in 2.5.31  Support insane number of processes  (Linus Torvalds)  
o in 2.5.32  New MTRR (Memory Type Range Register) driver  (Patrick Mochel)  
o in 2.5.32+  Porting all input devices over to input API  (Vojtech Pavlik, James Simmons)  
o in 2.5.32+    Asynchronous IO (aio) support  (Ben LaHaise)  
o in 2.5.32+  Add support for NFS v4  (NFS v4 team)  
o in 2.5.32+  Improved POSIX threading support  (Ingo Molnar)  
o in 2.5.33  SCTP (Stream Control Transmission Protocol)  (lksctp team)  
o in 2.5.33  TCP segmentation offload  (Alexey Kuznetsov)  
o in 2.5.34  discontigmem support (ia32)  (Pat Gaughen, Martin Bligh, Jack Steiner, Tony Luck)  
o in 2.5.34  POSIX threading support for signals  (Ingo Molnar)  
o in 2.5.35  Add User-Mode Linux (UML)  (Jeff Dike)  
o in 2.5.36  Add XFS (A journaling filesystem from SGI)  (XFS team)  
o in 2.5.39  New IO scheduler  (Jens Axboe)  
o in 2.5.40  Add support for CPU clock/voltage scaling  (Dominik Brodowski, Erik Mouw, Dave Jones, Russell King, Arjan van 
de Ven)  
o in 2.5.40  NUMA topology support  (Matt Dobson)  
o in 2.5.42  Improved i2o (Intelligent Input/Ouput) layer  (Alan Cox)  

 
o in -dj  Rewrite of the console layer  (James Simmons)  
o in -ac  PCMCIA Zoom video support  (Alan Cox)  
o in -mm  Read-Copy Update (RCU) Mutual Exclusion  (Dipankar Sarma, Rusty Russell, Andrea Arcangeli, LSE Team)  
o in -mm  VM large page support  (Many people)  

 
o Ready  Build option for Linux Trace Toolkit (LTT)  (Karim Yaghmour)  
o Ready  Remove the 2TB block device limit  (Peter Chubb)  
o Ready  Serial ATA support  (Andre Hedrick)  
o Ready  Dynamic Probes  (dprobes team)  
o Ready  Zerocopy NFS  (Hirokazu Takahashi)  
o Ready  High resolution timers  (George Anzinger, etc.)  
o Ready  ext2/ext3 large directory support: HTree index  (Daniel Phillips, Christopher Li, Andrew Morton, Ted Ts'o)  
o Ready  EVMS (Enterprise Volume Management System)  (EVMS team)  
o Ready  Add new CIFS (Common Internet File System)  (Steve French)  

 
o Beta  Device mapper for Logical Volume Manager (LVM2)  (LVM team)  
o Beta  Full compliance with IPv6  (Alexey Kuznetsov, Jun Murai, Yoshifuji Hideaki, USAGI team)  
o Beta  Page table sharing  (Daniel Phillips, Dave McCracken)  
o Beta  ext2/ext3 online resize support  (Andreas Dilger)  
o Beta  UDF Write support for CD-R/RW (packet writing)  (Jens Axboe, Peter Osterlund)  
o Beta  Better event logging for enterprise systems  (Larry Kessler, evlog team)  
o Beta  Add hardware sensors drivers  (lm_sensors team)  
o Beta  New Linux configuration system  (Roman Zippel)  
o Beta  Per-mountpoint read-only, union-mounts, unionfs  (Al Viro)  
o Beta  More complete NetBEUI stack  (Arnaldo Carvalho de Melo, from Procom donated code)  
o Beta  Plug'N Play Layer Rewrite  (Adam Belay)  

 
o Alpha  Scalable Statistics Counter  (Ravikiran Thirumalai)  
o Alpha  Linux Kernel Crash Dumps  (Matt Robinson, LKCD team)  
o Alpha  Change all drivers to new driver model  (All maintainers)  
o Alpha  NUMA aware scheduler extensions  (Erich Focht)  
o Alpha  Basic NUMA API  (Matt Dobson)  
o Alpha  Non-linear memory support  (Martin Bligh, Daniel Phillips)  
o Alpha  Remove waitqueue heads from kernel structures  (William Lee Irwin)  
o Alpha  New lightweight library (klibc)  (H. Peter Anvin)  
o Alpha  Reiserfs v4  (Reiserfs team)  
o Alpha  Replace initrd by initramfs  (H. Peter Anvin, Al Viro)  
o Alpha  Fix device naming issues  (Patrick Mochel, Greg Kroah-Hartman)  
o Alpha  Page table reclamation  (William Lee Irwin, Rik Van Riel)  
o Alpha  UMSDOS (Unix under MS-DOS) Rewrite  (Al Viro)  
o Alpha  USB gadget support  (Stuart Lynne, Greg Kroah-Hartman)  

 
o Started  Make AppleTalk use shared skbs and refcounting  (Arnaldo Carvalho de Melo)  
o Started  NUMA aware slab allocator  (Martin Bligh)  
o Started  x86 BIOS Enhanced Disk Device (EDD) polling  (Matt Domsch)  
o Started  SCSI multipath IO (with NUMA support)  (Patrick Mansfield, Mike Anderson)  
o Started  Overhaul PCMCIA support  (David Woodhouse, David Hinds)  
o Started  InfiniBand support  (InfiniBand team)  

 
o Planning  New mount API  (Al Viro)  
o Planning  Add thrashing control  (Rik van Riel)  
o Planning  Remove all hardwired drivers from kernel  (Alan Cox, etc.)  


 
Cleanups:  
 
Merged  
o in 2.5.3  Break Configure.help into multiple files  (Linus Torvalds)  
o in 2.5.3  Untangle sched.h & fs.h include dependancies  (Dave Jones, Roman Zippel)  
o in 2.5.4  Per network protocol slabcache & sock.h  (Arnaldo Carvalho de Melo)  
o in 2.5.4  Per filesystem slabcache & fs.h  (Daniel Phillips, Jeff Garzik, Al Viro)  
o in 2.5.6  Killing kdev_t for block devices  (Al Viro)  
o in 2.5.18+  ->getattr() ->setattr() ->permission() changes  (Al Viro)  
o in 2.5.21  Split up x86 setup.c into managable pieces  (Patrick Mochel)  
o in 2.5.23+  Major MD tool (RAID 5) cleanup  (Neil Brown)  
o in 2.5.31  Rework datalink protocols to not use cli/sti  (Arnaldo Carvalho de Melo)  
o in 2.5.31  Remove incomplete SPX network stack  (Arnaldo Carvalho de Melo)  

 
o Beta  Remove dcache_lock  (Maneesh Soni, IBM team)  

 
o Ready  Switch to ->get_super() for file_system_type  (Al Viro)  

 
o Beta  file.h and INIT_TASK  (Benjamin LaHaise)  
o Beta  Proper UFS fixes, ext2 and locking cleanups  (Al Viro)  
o Beta  Lifting limitations on mount(2)  (Al Viro)  

 
o Started  Reorder x86 initialization  (Dave Jones, Randy Dunlap)  



Have some free time and want to help? Check out the Kernel Janitor
TO DO list for a list of source code cleanups you can work on.
A great place to start learning more about kernel internals!

