Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbTEFFUq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 01:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbTEFFUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 01:20:46 -0400
Received: from smtp.vzavenue.net ([66.171.59.140]:42865 "EHLO
	smtp.vzavenue.net") by vger.kernel.org with ESMTP id S261428AbTEFFUj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 01:20:39 -0400
From: "Guillaume Boissiere" <boissiere@adiglobal.com>
To: linux-kernel@vger.kernel.org
Date: Tue, 06 May 2003 01:32:54 -0400
MIME-Version: 1.0
Subject: [STATUS 2.5]  May 6, 2003
Message-ID: <3EB710C6.11979.32A6D57@localhost>
X-mailer: Pegasus Mail for Windows (v4.02)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The development kernel seems to be well on its way to stabilizing, with 
hundreds of small fixes making their way to the BK tree in the past 
month.

Here is a snapshot of the latest status as of May 6th.  It is also 
available at http://www.kernelnewbies.org/status/

Let me know if anything is missing or inaccurate.
Cheers,

-- Guillaume


----------------------------------------
Linux Kernel 2.5 Status - May 6th, 2003
(Latest kernel release is 2.5.69)

Items in bold have changed since the last update.

Features:  
 
Merged  
o in 2.5.1+  Rewrite of the block IO (bio) layer  (Jens Axboe)  
o in 2.5.2  Initial support for USB 2.0  (David Brownell, Greg Kroah-Hartman, etc.)  
o in 2.5.2  Per-process namespaces, late-boot cleanups  (Al Viro, Manfred Spraul)  
o in 2.5.2+  O(1) scheduler for improved scalability  (Ingo Molnar)  
o in 2.5.2+  New kernel device structure (kdev_t)  (Linus Torvalds, etc.)  
o in 2.5.3  IDE layer update  (Andre Hedrick)  
o in 2.5.3  Support reiserfs external journal  (Reiserfs team)  
o in 2.5.3  Generic Extended Attribute support  (Nathan Scott)  
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
o in 2.5.32+  Improved POSIX threading support  (Ingo Molnar, Ulrich Drepper)  
o in 2.5.33  SCTP (Stream Control Transmission Protocol)  (lksctp team)  
o in 2.5.33  TCP segmentation offload  (Alexey Kuznetsov)  
o in 2.5.34  discontigmem support (ia32)  (Pat Gaughen, Martin Bligh, Jack Steiner, Tony Luck)  
o in 2.5.34  POSIX threading support for signals  (Ingo Molnar)  
o in 2.5.35  Add User-Mode Linux (UML)  (Jeff Dike)  
o in 2.5.35  Serial ATA support  (Andre Hedrick)  
o in 2.5.36  Add XFS (A journaling filesystem from SGI)  (XFS team)  
o in 2.5.36  Hugepage support  (Rohit Seth)  
o in 2.5.37  Remove the global tasklist  (Ingo Molnar, William Lee Irwin)  
o in 2.5.37  Ethernet bridge tables support  (Bart De Schuymer)  
o in 2.5.39  New IO scheduler  (Jens Axboe)  
o in 2.5.40  Add support for CPU clock/voltage scaling  (Dominik Brodowski, Erik Mouw, Dave Jones, Russell King, Arjan van de Ven)  
o in 2.5.40  NUMA topology support  (Matt Dobson)  
o in 2.5.40  Parallelizing page replacement  (Andrew Morton, Momchil Velikov, Dave Hansen, William Lee Irwin)  
o in 2.5.42  Improved i2o (Intelligent Input/Ouput) layer  (Alan Cox)  
o in 2.5.42  Remove the 2TB block device limit  (Peter Chubb)  
o in 2.5.42  Add new CIFS (Common Internet File System)  (Steve French)  
o in 2.5.42  ext2/ext3 large directory support: HTree index  (Daniel Phillips, Christopher Li, Andrew Morton, Ted Ts'o)  
o in 2.5.43  Add support for NFS v4  (NFS v4 team, Trond Myklebust, Neil Brown)  
o in 2.5.43  Read-Copy Update (RCU) Mutual Exclusion  (Dipankar Sarma, Rusty Russell, Andrea Arcangeli, LSE Team)  
o in 2.5.43  Add OProfile, a low-overhead profiler  (John Levon)  
o in 2.5.43  Andrew File System (AFS) support  (David Howells)  
o in 2.5.44  x86 BIOS Enhanced Disk Device (EDD) polling  (Matt Domsch)  
o in 2.5.44  Plug'N Play Layer Rewrite  (Adam Belay)  
o in 2.5.44+  New sysfs filesystem (formerly known as driverfs)  (Patrick Mochel)  
o in 2.5.45  Device mapper for Logical Volume Manager (LVM2)  (Alasdair Kergon, Patrick Caulfield, Joe Thornber)  
o in 2.5.45  Digital Video Broadcasting (DVB) layer  (LinuxTV team)  
o in 2.5.45  IPsec support  (Alexey Kuznetsov, Dave Miller, USAGI team)  
o in 2.5.45  CryptoAPI  (James Morris)  
o in 2.5.45  New Linux configuration system: kconfig  (Roman Zippel)  
o in 2.5.46  Extended Attributes and ACLs for ext2/ext3  (Ted Ts'o)  
o in 2.5.46  Replace initrd by initramfs  (H. Peter Anvin, Al Viro, Jeff Garzik)  
o in 2.5.46  MMU-less processor support (ucLinux)  (Greg Ungerer)  
o in 2.5.46  Per-cpu hot & cold page lists  (Andrew Morton, Martin Bligh)  
o in 2.5.46+  Better I/O performance with epoll  (Davide Libenzi)  
o in 2.5.47  Zerocopy NFS  (Hirokazu Takahashi)  
o in 2.5.48  In-kernel module loader  (Rusty Russell)  
o in 2.5.51  Compatibility syscall layer  (Stephen Rothwell)  
o in 2.5.51+  Rewrite of the console layer  (James Simmons)  
o in 2.5.53  "sysenter" support  (Linus Torvalds, etc.)  
o in 2.5.54  Support for AGP 3.0  (Dave Jones)  
o in 2.5.54+  Add drivers for hardware health monitoring  (lm_sensors team)  
o in 2.5.57  Remove long-held locks for low scheduling latency  (Andrew Morton, etc.)  
o in 2.5.59  NUMA aware scheduler extensions  (Erich Focht, Michael Hohnbaum, Martin Bligh)  
o in 2.5.60  64-bit jiffies  (Tim Schmielau)  
o in 2.5.60  New modversions implementation  (Kai Germaschewski)  
o in 2.5.63  POSIX timers  (George Anzinger)  
o in 2.5.65  Desktop Interactivity Improvements  (Linus Torvalds, Ingo Molnar)  
o in 2.5.69  New interrupt handling API  (Linus Torvalds, Andrew Morton, etc.)  
 
o in -mm  Anticipatory Scheduler  (Nick Piggin, Andrew Morton)  
o in -mm  64-bit dev_t  (Andries Brouwer, Al Viro)  
o in -mm  Complete Fair Queueing (CFQ) disk scheduler  (Jens Axboe, Andrea Arcangeli)  
o in -mm  Kexec, syscall to load kernel from kernel  (Eric Biederman)  
o in -ac  Switch the IDE I/O layers to taskfile  (Bartlomiej Zolnierkiewicz, Alan Cox)  
o in -osdl  Build option for Linux Trace Toolkit (LTT)  (Karim Yaghmour)  
 
o before 2.6.0    Support insane number of groups  (Tim Hockin)  
o before 2.6.0  Worldclass support for IPv6  (Alexey Kuznetsov, Dave Miller, Jun Murai, Yoshifuji Hideaki, USAGI team)  
o before 2.6.0  Reiserfs v4  (Reiserfs team)  
o before 2.6.0  Fix device naming issues  (Patrick Mochel, Greg Kroah-Hartman)  
o before 2.6.0  Change all drivers to new driver model  (All maintainers)  
o before 2.6.0  USB gadget support  (David Brownell, Stuart Lynne, Greg Kroah-Hartman)  
o before 2.6.0  Improved AppleTalk stack  (Arnaldo Carvalho de Melo)  
o before 2.6.0  ext2/ext3 online resize support  (Andreas Dilger)  
o before 2.6.0  UDF Write support for CD-R/RW (packet writing)  (Jens Axboe, Peter Osterlund)  

o post 2.6.0  Unified boot/parameter support  (Rusty Russell)  
o post 2.6.0  SCSI multipath IO (with NUMA support)  (Patrick Mansfield, Mike Anderson)  
o post 2.6.0  Basic NUMA API  (Matt Dobson)  
o post 2.6.0  Remove waitqueue heads from kernel structures  (William Lee Irwin)  
o post 2.6.0  NUMA aware slab allocator  (Manfred Spraul, Martin Bligh)  
o post 2.6.0  Better event logging for enterprise systems  (Larry Kessler, evlog team)  
o post 2.6.0  Page table reclamation  (William Lee Irwin, Rik Van Riel)  
o post 2.6.0  UMSDOS (Unix under MS-DOS) Rewrite  (Al Viro)  
o post 2.6.0  Overhaul PCMCIA support  (David Woodhouse, David Hinds)  
o post 2.6.0  InfiniBand support  (InfiniBand team)  
o post 2.6.0  Per-mountpoint read-only, union-mounts, unionfs  (Al Viro)  
o post 2.6.0  More complete NetBEUI stack  (Arnaldo Carvalho de Melo, from Procom donated code)  
o post 2.6.0  New mount API  (Al Viro)  
o post 2.6.0  Add thrashing control  (Rik van Riel)  
o post 2.6.0  Remove all hardwired drivers from kernel  (Alan Cox, etc.)  
o post 2.6.0  New lightweight library (klibc)  (H. Peter Anvin)  
o post 2.6.0  Scalable Statistics Counter  (Ravikiran Thirumalai)  
o post 2.6.0  SCSI and FibreChannel Hotswap Support  (Steven Dake)  
o post 2.6.0  Page table sharing  (Daniel Phillips, Dave McCracken)  
o post 2.6.0  Kernel Probes (kprobes)  (Vamsi Krishna, kprobes team)  
o post 2.6.0  Object-based rmap  (Dave McCraken)  
o post 2.6.0  Linux Kernel Crash Dumps  (Matt Robinson, LKCD team)  

 
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
o in 2.5.30  Remove khttpd  (Christoph Hellwig)  
o in 2.5.31  Rework datalink protocols to not use cli/sti  (Arnaldo Carvalho de Melo)  
o in 2.5.31  Remove incomplete SPX network stack  (Arnaldo Carvalho de Melo)  
o in 2.5.43  Remove kiobufs  (Andrew Morton)  
o in 2.5.46  Reorder x86 initialization  (Dave Jones)  
o in 2.5.62  Avoid dcache_lock while path walking  (Maneesh Soni, IBM team)  


Have some free time and want to help? Check out the Kernel Janitor
TO DO list for a list of source code cleanups you can work on.
A great place to start learning more about kernel internals!


