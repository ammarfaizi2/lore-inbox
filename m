Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313264AbSDYSNP>; Thu, 25 Apr 2002 14:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313300AbSDYSNP>; Thu, 25 Apr 2002 14:13:15 -0400
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:62443 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S313264AbSDYSNN>; Thu, 25 Apr 2002 14:13:13 -0400
From: "Guillaume Boissiere" <boissiere@attbi.com>
To: linux-kernel@vger.kernel.org
Date: Thu, 25 Apr 2002 13:48:02 -0400
MIME-Version: 1.0
Subject: [STATUS 2.5]  April 25, 2002
Message-ID: <3CC80912.1394.5A7B5285@localhost>
X-mailer: Pegasus Mail for Windows (v4.01)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest kernel 2.5 status update is available at 
    http://kernelnewbies.org/status/
for your enjoyment. 

As always, feedback welcome! 
Cheers,

-- Guillaume


-----------------------------------------------------
Kernel 2.5 status  -  April 25th, 2002
(Latest kernel release is 2.5.10)


Features:

Merged
o in 2.5.1+   Rewrite of the block IO (bio) layer             (Jens 
Axboe)
o in 2.5.2    Initial support for USB 2.0                     
(David Brownell, Greg Kroah-Hartman, etc.)
o in 2.5.2    Per-process namespaces, late-boot cleanups      (Al 
Viro, Manfred Spraul)
o in 2.5.2+   New scheduler for improved scalability          (Ingo 
Molnar)
o in 2.5.2+   New kernel device structure (kdev_t)            
(Linus Torvalds, etc.)
o in 2.5.3    IDE layer update                                
(Andre Hedrick)
o in 2.5.3    Support reiserfs external journal               
(Reiserfs team)
o in 2.5.3    Generic ACL (Access Control List) support       
(Nathan Scott)
o in 2.5.3    PnP BIOS driver                                 (Alan 
Cox, Thomas Hood, Dave Jones, etc.)
o in 2.5.3+   New driver model & unified device tree          
(Patrick Mochel)
o in 2.5.4    Add preempt kernel option                       
(Robert Love, MontaVista team)
o in 2.5.4    Support for Next Generation POSIX Threading     (NGPT 
team)
o in 2.5.4+   Porting all input devices over to input API     
(Vojtech Pavlik, James Simmons)
o in 2.5.5    Add ALSA (Advanced Linux Sound Architecture)    (ALSA 
team)
o in 2.5.5    Pagetables in highmem support                   (Ingo 
Molnar, Arjan van de Ven)
o in 2.5.5    New architecture: AMD 64-bit (x86-64)           (Andi 
Kleen, x86-64 Linux team)
o in 2.5.5    New architecture: PowerPC 64-bit (ppc64)        
(Anton Blanchard, ppc64 team)
* in 2.5.5+   IDE subsystem major cleanup                     
(Martin Dalecki, Vojtech Pavlik)
o in 2.5.6    Add JFS (Journaling FileSystem from IBM)        (JFS 
team)
o in 2.5.6    per_cpu infrastructure                          
(Rusty Russell)
o in 2.5.6    HDLC (High-level Data Link Control) update      
(Krzysztof Halasa)
o in 2.5.6    smbfs Unicode and large file support            
(Urban Widmark) 
o in 2.5.7    New driver API for Wireless Extensions          (Jean 
Tourrilhes)
o in 2.5.7    Video for Linux (V4L) redesign                  (Gerd 
Knorr)
o in 2.5.7    Futexes (Fast Lightweight Userspace Semaphores) 
(Rusty Russell, etc.)
o in 2.5.7+   NAPI network interrupt mitigation               
(Jamal Hadi Salim, Robert Olsson, Alexey Kuznetsov)
o in 2.5.7+   ACPI (Advanced Configuration & Power Interface) (Andy 
Grover, ACPI team)
o in 2.5.8    Syscall interface for CPU task affinity         
(Robert Love)
o in 2.5.8    Radix-tree pagecache                            
(Momchil Velikov, Christoph Hellwig)
* in 2.5.8+   Support for IDE TCQ (Tagged Command Queueing)   (Jens 
Axboe)
* in 2.5.8+   Delayed allocation on write                     
(Andrew Morton)
* in 2.5.9    IRQ balancing                                   (Ingo 
Molnar)

o Pending     Rewrite of the framebuffer layer                
(James Simmons)
o in -ac      Strict address space accounting                 (Alan 
Cox)
o in -ac      PCMCIA Zoom video support                       (Alan 
Cox)
o in -ac      More complete IEEE 802.2 stack                  
(Arnaldo, Jay Schullist, from Procom donated code)

o Ready       Better event logging for enterprise systems     
(Larry Kessler, evlog team)
o Ready       New quota system supporting plugins             (Jan 
Kara)
o Ready       Replace old NTFS driver with NTFS TNG driver    
(Anton Altaparmakov)
o Ready       Linux booting ELF images                        (Eric 
Biederman)
o Ready       First pass at LinuxBIOS support                 (Eric 
Biederman)
o Ready       Build option for Linux Trace Toolkit (LTT)      
(Karim Yaghmour)

o Beta        New kernel build system (kbuild 2.5)            
(Keith Owens)
o Beta        Add support for CPU clock/voltage scaling       (Erik 
Mouw, Dave Jones, Russell King, Arjan van de Ven)
o Beta        Serial driver restructure                       
(Russell King)
o Beta        New IO scheduler                                (Jens 
Axboe)
o Beta        Add XFS (A journaling filesystem from SGI)      (XFS 
team)
* Beta        New VM with reverse mappings                    (Rik 
van Riel)
o Beta        Fix long-held locks for low scheduling latency  
(Andrew Morton, Robert Love, etc.)
o Beta        Add Linux Security Module (LSM)                 (LSM 
team)
o Beta        Hotplug CPU support                             
(Rusty Russell)
o Beta        Per-mountpoint read-only, union-mounts, unionfs (Al 
Viro)
o Beta        EVMS (Enterprise Volume Management System)      (EVMS 
team)
o Beta        LVM (Logical Volume Manager) v2.0               (LVM 
team)
o Beta        Dynamic Probes                                  
(Suparna Bhattacharya, dprobes team)
o Beta        Scalable CPU bitmasks                           (Russ 
Weight)
o Beta        Page table sharing                              
(Daniel Phillips)
o Beta        Rewrite of the console layer                    
(James Simmons)
o Beta        ext2/ext3 online resize support                 
(Andreas Dilger)
o Beta        Fast walk dcache                                
(Hanna Linder)
o Beta        Add User-Mode Linux (UML)                       (Jeff 
Dike)
o Beta        UDF Write support for CD-R/RW (packet writing)  (Jens 
Axboe, Peter Osterlund)
o Beta        Add hardware sensors drivers                    
(lm_sensors team)
o Beta        New kernel config system: CML2                  (Eric 
Raymond)
o Beta        Read-Copy Update Mutual Exclusion               
(Dipankar Sarma, Rusty Russell, Andrea Arcangeli, LSE Team)
* Beta        USB device (not host) support                   
(Stuart Lynne, Greg Kroah-Hartman)

o Alpha       Better support of high-end NUMA machines        (NUMA 
team)
o Alpha       Add Asynchronous IO (aio) support               (Ben 
LaHaise)
o Alpha       Overhaul PCMCIA support                         
(David Woodhouse, David Hinds)
o Alpha       Full compliance with IPv6                       
(Alexey Kuznetzov, Jun Murai, Yoshifuji Hideaki, USAGI team)
o Alpha       UMSDOS (Unix under MS-DOS) Rewrite              (Al 
Viro)
o Alpha       Scalable Statistics Counter                     
(Ravikiran Thirumalai)
o Alpha       Linux Kernel Crash Dumps                        (Matt 
Robinson, LKCD team)
o Alpha       Add support for NFS v4                          (NFS 
v4 team)
o Alpha       ext2/ext3 large directory support: HTree index  
(Daniel Phillips, Christopher Li, Ted Ts'o)
o Alpha       Delayed disk block allocation                   
(Andrew Morton)
o Alpha       Improved i2o (Intelligent Input/Ouput) layer    (Alan 
Cox)
o Alpha       New MTRR (Memory Type Range Register) driver    
(Patrick Mochel)
o Alpha       Remove use of the BKL (Big Kernel Lock)         (Alan 
Cox, Robert Love, Neil Brown, Dave Hansen, etc.)
o Alpha       Zerocopy NFS                                    
(Hirokazu Takahashi)

o Started     More complete NetBEUI stack                     
(Arnaldo Carvalho de Melo, from Procom donated code)
o Started     Change all drivers to new driver model          (All 
maintainers)
o Started     Reiserfs v4                                     
(Reiserfs team)
o Started     Move ISDN4Linux to CAPI based interface         
(ISDN4Linux team)

o Draft #2    New lightweight library (klibc)                 (Greg 
Kroah-Hartman)
o Draft #3    Replace initrd by initramfs                     (H. 
Peter Anvin, Al Viro)
o Planning    Add thrashing control                           (Rik 
van Riel)
o Planning    Remove all hardwired drivers from kernel        (Alan 
Cox, etc.)
o Planning    Generic parameter/command line interface        
(Keith Owens)
o Planning    New mount API                                   (Al 
Viro)
o Planning    Implement new device naming convention          
(Device naming team)


Cleanups:

Merged
o in 2.5.3    Break Configure.help into multiple files        
(Linus Torvalds)
o in 2.5.3    Untangle include file dependancies              (Dave 
Jones, Roman Zippel)
o in 2.5.4    Per network protocol slabcache & sock.h         
(Arnaldo Carvalho de Melo)
o in 2.5.4    Per filesystem slabcache & fs.h                 
(Daniel Phillips, Jeff Garzik, Al Viro)
o in 2.5.6    Killing kdev_t for block devices                (Al 
Viro)

o Ready       Switch to ->get_super() for file_system_type    (Al 
Viro)
o Ready       ->getattr() ->setattr() ->permission() changes  (Al 
Viro)
o Ready       Remove dcache_lock                              
(Maneesh Soni, IBM team)

o Beta        file.h and INIT_TASK                            
(Benjamin LaHaise)
o Beta        Proper UFS fixes, ext2 and locking cleanups     (Al 
Viro)
o Beta        Lifting limitations on mount(2)                 (Al 
Viro)

o Alpha       Split up x86 setup.c into managable pieces      
(Patrick Mochel)

o Started     Reorder x86 initialization                      (Dave 
Jones, Randy Dunlap)

Have some free time and want to help?  Check out the Kernel Janitor 
TO DO list for a list of source code cleanups you can work on.  
A great place to start learning more about kernel internals!



