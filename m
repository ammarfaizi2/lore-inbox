Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289142AbSA3M0T>; Wed, 30 Jan 2002 07:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289139AbSA3M0K>; Wed, 30 Jan 2002 07:26:10 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:450 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S289136AbSA3MZv>;
	Wed, 30 Jan 2002 07:25:51 -0500
Date: Wed, 30 Jan 2002 17:58:24 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: boissiere@mediaone.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [STATUS 2.5]  January 30, 2002
Message-ID: <20020130175824.A19450@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guillaume,

Another work in progress in our group - Scalable statistics counters
by Ravikiran Thirumalai.

Here is the lkml discussion - 
http://marc.theaimsgroup.com/?t=100755030000002&r=1&w=2

We are working on the suggestions regarding /proc integration.

Thanks
Dipankar
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.

In article <3C573F6B.19221.1E703BBF@localhost> Guillaume Boissiere wrote:
> The latest list is available at:  http://kernelnewbies.org/status/
> Items in bold are changes since last week.

> The big thing in the past week is the work done on driverfs by 
> Patrick Mochel, which started to appear in 2.5
> If you are a driver maintainer, you may want to look at this :-)

> As usual, let me know of any inaccuracies, and I'll be happy to 
> correct them.
> Enjoy!

> -- Guillaume

> --------------------------------------------------
> Kernel 2.5 status  -  January 30th, 2002
> (Latest kernel release is 2.5.3pre6)


> Features:

> o Merged     New scheduler for improved scalability          (Ingo Molnar, Davide Libenzi)
> o Merged     Rewrite of the block IO (bio) layer             (Jens Axboe)
> o Merged     New kernel device structure (kdev_t)            (Linus Torvalds, etc.)
> o Merged     Initial support for USB 2.0                     (David Brownell, Greg Kroah-Hartman, etc.)
> o Merged     Per-process namespaces, late-boot cleanups      (Al Viro, Manfred Spraul)
> o Merged     IDE layer update                                (Andre Hedrick)
> o Merged     New driver API for Wireless Extensions (1/2)    (Jean Tourrilhes)

> o Pending    Finalize new device naming convention           (Linus Torvalds)
> o Pending    New driver model & unified device tree          (Patrick Mochel)
> o in -dj     Porting all input devices over to input API     (Vojtech Pavlik, James Simmons)

> o Ready      Add User-Mode Linux (UML)                       (Jeff Dike)
> o Ready      HDLC (High-level Data Link Control) update      (Krzysztof Halasa)
> o Ready      Add ALSA (Advanced Linux Sound Architecture)    (ALSA team)
> o Ready      Support reiserfs external journal               (Reiserfs team)
> o Ready      Add hardware sensors drivers                    (lm_sensors team)
> o Ready      Add preempt kernel option                       (Robert Love)
> o Ready      Generic ACL (Access Control List) support       (Nathan Scott)

> o <1 month   New kernel build system (kbuild 2.5)            (Keith Owens)
> o <1 month   New kernel config system: CML2                  (Eric Raymond)

> o Beta       Add support for CPU clock/voltage scaling       (Erik Mouw, Dave Jones, Russell King, Arjan van de Ven)
> o Beta       Serial driver restructure                       (Russell King)
> o Beta       New IO scheduler                                (Jens Axboe)
> o Beta       NAPI Network interrupt mitigation               (Jamal Hadi Salim, Robert Olsson, Alexey Kuznetsov)
> o Beta       Add XFS (A journaling filesystem from SGI)      (XFS team)
> o Beta       New VM with reverse mappings                    (Rik van Riel)
> o Beta       Add resheduling points to remove latency        (Andrew Morton)
> o Beta       Build option for Linux Trace Toolkit (LTT)      (Karim Yaghmour)
> o Beta       Better event logging for enterprise systems     (evlog team)
> o Beta       Add Linux Security Module (LSM)                 (LSM team)
> o Beta       Hotplug CPU support                             (Rusty Russell)
> o Beta       Per-mountpoint read-only, union-mounts, unionfs (Al Viro)
> o Beta       EVMS (Enterprise Volume Management System)      (EVMS team)

> o Alpha      Better support of high-end NUMA machines        (NUMA team)
> o Alpha      Add Asynchronous IO (aio) support               (Ben LaHaise)
> o Alpha      Overhaul PCMCIA support                         (David Woodhouse, David Hinds)
> o Alpha      Replace old NTFS driver with NTFS TNG driver    (Anton Altaparmakov)
> o Alpha      More complete IEEE 802.2 stack                  (Arnaldo, Jay Schullist, from Procom donated code)
> o Alpha      LVM (Logical Volume Manager) v2.0               (Heintz Mauelshagen, Andreas Dilger, LVM team)
> o Alpha      Read-Copy Update Mutual Exclusion               (Dipankar Sarma, Rusty Russell, LSE Team)
> o Alpha      Full compliance with IPv6                       (Alexey Kuznetzov, Jun Murai, Yoshifuji Hideaki, USAGI 
> team)
> o Alpha      Linux booting ELF images                        (Eric Biederman)
> o Alpha      First pass at LinuxBIOS support                 (Eric Biederman)
> o Alpha      UMSDOS (Unix under MS-DOS) Rewrite              (Al Viro)
> * Alpha      Scalable CPU bitmaps                            (Russ Weight)

> o Started    Rewrite of the framebuffer layer                (James Simmons)
> o Started    Rewrite of the console layer                    (James Simmons)
> o Started    More complete NetBEUI stack                     (Arnaldo Carvalho de Melo, from Procom donated code)
> o Started    Remove use of the BKL (Big Kernel Lock)         (Alan Cox, Robert Love, Neil Brown, etc.)
> o Started    Change all drivers to new driver model          (All maintainers)
> * Started    Reiserfs v4                                     (Reiserfs team)
> * Started    Move ISDN4Linux to CAPI based interface         (ISDN4Linux team)

> o Draft #2   New lightweight library (klibc)                 (Greg Kroah-Hartman)
> o Draft #3   Replace initrd by initramfs                     (H. Peter Anvin, Al Viro)
> o Planning   Add thrashing control                           (Rik van Riel)
> o Planning   Remove all hardwired drivers from kernel        (Alan Cox, etc.)
> o Planning   Generic parameter/command line interface        (Keith Owens)
> o Planning   New mount API                                   (Al Viro)
> * Planning   New MTRR (Memory Type Range Register) driver    (Dave Jones)


> Cleanups:

> * Merged     Break Configure.help into multiple files        (Linus Torvalds)

> o Ready      Per network protocol slabcache & sock.h         (Arnaldo Carvalho de Melo)
> o Ready      Switch to ->get_super() for file_system_type    (Al Viro)
> o Ready      ->getattr() ->setattr() ->permission() changes  (Al Viro)

> o Beta       file.h and INIT_TASK                            (Benjamin LaHaise)
> o Beta       Remove dcache_lock                              (Maneesh Soni, IBM team)
> o Beta       Proper UFS fixes, ext2 and locking cleanups     (Al Viro)
> o Beta       Lifting limitations on mount(2)                 (Al Viro)

> o Started    Per filesystem slabcache & fs.h                 (Daniel Phillips, Jeff Garzik)
> o Started    Killing kdev_t for block devices                (Al Viro)
> * Started    Split up x86 setup.c into managable pieces      (Dave Jones, Randy Dunlap)
> * Started    Reorder x86 initialization		                  (Dave Jones, Randy Dunlap)

> Have some free time and want to help?  Check out the Kernel Janitor TO DO list for a list of source code 
> cleanups you can work on.  A great place to start learning more about kernel internals!



> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


