Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314080AbSGREqt>; Thu, 18 Jul 2002 00:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314403AbSGREqs>; Thu, 18 Jul 2002 00:46:48 -0400
Received: from pop.adiglobal.com ([66.207.47.93]:15108 "EHLO
	mail.adiglobal.com") by vger.kernel.org with ESMTP
	id <S314080AbSGREqr>; Thu, 18 Jul 2002 00:46:47 -0400
From: "Guillaume Boissiere" <boissiere@adiglobal.com>
To: linux-kernel@vger.kernel.org
Date: Thu, 18 Jul 2002 00:49:21 -0400
MIME-Version: 1.0
Subject: [2.6] Most likely to be merged by Halloween... THE LIST
Message-ID: <3D361091.13618.16DC46FB@localhost>
X-mailer: Pegasus Mail for Windows (v4.01)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I broke down my status list into 3 categories: 
- likely to be merged before the Halloween feature freeze
- likely not to be ready by Halloween
- ongoing work

Do you think the breakdown is realistic?

-- Guillaume

PS: Remember, no more than 15-20 big features get usually 
    merged in 3 months :-)


-------------------------------------------
Before feature freeze:

o New VM with reverse mappings                    (Rik van Riel)
o Add Linux Security Module (LSM)                 (LSM team)
o Rewrite of the console layer                    (James Simmons)
o New MTRR (Memory Type Range Register) driver    (Patrick Mochel)
o Add support for CPU clock/voltage scaling       (Erik Mouw, Dave Jones, Russell King, Arjan van de Ven)
o Strict address space accounting                 (Alan Cox)
o USB gadget support                              (Stuart Lynne, Greg Kroah-Hartman)
o Add hardware sensors drivers                    (lm_sensors team)
o Serial driver restructure                       (Russell King)
o Add User-Mode Linux (UML)                       (Jeff Dike)
o Direct pagecache <-> BIO disk I/O               (Andrew Morton)
o More complete NetBEUI stack                     (Arnaldo Carvalho de Melo, from Procom donated code)
o Fix device naming issues                        (Patrick Mochel, Greg Kroah-Hartman)


After feature freeze:

o Improved i2o (Intelligent Input/Ouput) layer    (Alan Cox)
o Read-Copy Update Mutual Exclusion               (Dipankar Sarma, Rusty Russell, Andrea Arcangeli, LSE Team)
o New kernel build system (kbuild 2.5)            (Keith Owens)
o PCMCIA Zoom video support                       (Alan Cox)
o Add XFS (A journaling filesystem from SGI)      (XFS team)
o New IO scheduler                                (Jens Axboe)
o Per-mountpoint read-only, union-mounts, unionfs (Al Viro)
o Asynchronous IO (aio) support                   (Ben LaHaise)
o EVMS (Enterprise Volume Management System)      (EVMS team)
o LVM (Logical Volume Manager) v2.0               (LVM team)
o Dynamic Probes                                  (Suparna Bhattacharya, dprobes team)
o Page table sharing                              (Daniel Phillips)
o ext2/ext3 online resize support                 (Andreas Dilger)
o UDF Write support for CD-R/RW (packet writing)  (Jens Axboe, Peter Osterlund)
o Better event logging for enterprise systems     (Larry Kessler, evlog team)
o Full compliance with IPv6                       (Alexey Kuznetzov, Jun Murai, Yoshifuji Hideaki, USAGI team)
o UMSDOS (Unix under MS-DOS) Rewrite              (Al Viro)
o Scalable Statistics Counter                     (Ravikiran Thirumalai)
o Linux Kernel Crash Dumps                        (Matt Robinson, LKCD team)
o Add support for NFS v4                          (NFS v4 team)
o ext2/ext3 large directory support: HTree index  (Daniel Phillips, Christopher Li, Ted Ts'o)
o Zerocopy NFS                                    (Hirokazu Takahashi)
o Remove the 2TB block device limit               (Peter Chubb)
o SCTP (Stream Control Transmission Protocol)     (lksctp team)
o High resolution timers                          (George Anzinger, etc.)
o Overhaul PCMCIA support                         (David Woodhouse, David Hinds)
o Reiserfs v4                                     (Reiserfs team)
o Serial ATA support                              (Andre Hedrick)
o InfiniBand support                              (InfiniBand team)
o New lightweight library (klibc)                 (Greg Kroah-Hartman)
o Replace initrd by initramfs                     (H. Peter Anvin, Al Viro)
o Add thrashing control                           (Rik van Riel)
o Remove all hardwired drivers from kernel        (Alan Cox, etc.)
o Generic parameter/command line interface        (Keith Owens)
o New mount API                                   (Al Viro)


Ongoing work:

o Fix long-held locks for low scheduling latency  (Andrew Morton, Robert Love, etc.)
o Better support of high-end NUMA machines        (NUMA team)
o Remove use of the BKL (Big Kernel Lock)         (Alan Cox, Robert Love, Neil Brown, Dave Hansen, etc.)
o Change all drivers to new driver model          (All maintainers)
