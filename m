Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315276AbSEQB63>; Thu, 16 May 2002 21:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315275AbSEQB62>; Thu, 16 May 2002 21:58:28 -0400
Received: from revdns.flarg.info ([213.152.47.19]:54702 "EHLO noodles.internal")
	by vger.kernel.org with ESMTP id <S315274AbSEQB61>;
	Thu, 16 May 2002 21:58:27 -0400
Date: Fri, 17 May 2002 02:58:59 +0100
From: Dave Jones <davej@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.15-dj2
Message-ID: <20020517015859.GA523@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grab some of the more fun bits from Linus' public bk tree, and
merge in another boatload of patches that turned up elsewhere.
Quite a large set of changes, so tread carefully.

As usual,..

Patch against 2.5.15 vanilla is available from:
ftp://ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.5/

Merged patch archive: http://www.codemonkey.org.uk/patches/merged/

Check http://www.codemonkey.org.uk/Linux-2.5.html before reporting
known bugs that are also in mainline.

 -- Davej.

2.5.15-dj2
o   Fix ADFS map scanning code.				(Russell King)
o   Drop userspace utilities from 8253x driver.		(Keith Owens)
o   Remove duplicate apic init code.			(Ishan O Jayawardena)
o   zlib_inflate return code fix.			(David Woodhouse)
o   Hotplug CPU preparations.				(Rusty Russell)
o   More conversions to use standard AS rule.		(Kai Germaschewski)
o   AVM CAPI init/remove cleanups.			(Kai Germaschewski)
o   64 bit jiffies.					(George Anzinger)
o   More Pentium4 thermal interrupt fixes.		(Zwane Mwaikambo)
o   Fix typo in serial unload message..			(Zwane Mwaikambo)
o   Allow disabling of P4 Xeon hyperthreading.		(Hugh Dickins, Me)
    | I mangled Hugh's 2.4 patch quite a bit to work
    | with Pat Mochels reworked x86 setup code.
o   set_cpus_allowed() optimisation.			(Mike Kravetz)
o   Further ps2esdi resource cleanups.			(William Stinson)
o   Re-add dropped compile fix for hd.c			(Adrian Bunk)
o   Remove event from block_dev.c			(Manfred Spraul)
o   Intel I845G AGPGART support.			(Graeme Fisher)
o   ni65 driver region handling cleanup.		(William Stinson)
o   Add Farallon PN9100-T ident to acenic driver.	(Eric Smith)
o   Remove spurious timer interrupts on clustered APIC.	(Martin J Bligh)
o   Various typo fixes.					(Marko Myllynen)
o   Some more malloc.h -> slab.h conversions.		(Marko Myllynen)
o   Add missing bootmem include.			(Johan Adolfsson)
o   Reword exiting with non-zero preempt count warning.	(Robert Love)
o   Numerous RAID5 fixes.				(Neil Brown)
o   Remove Documentation/man on make mrproper.		(Marko Myllynen)
o   menuconfig -Wshadow fixes.				(Marko Myllynen)
o   Use named initialisers for net/sched/	(Thomas 'Dent' Wirlacher)
o   sys_[p]read/sys_[p]write cleanup.			(Christoph Hellwig)
o   sdla_main region handling cleanup.			(William Stinson)
o   FATFS extension filters.				(OGAWA Hirofumi)
o   Various soft accel fb bugfixes.			(James Simmons)
o   Appletalk ltpc region handling cleanup.		(William Stinson)

2.5.15-dj1
o   Several pipe cleanups.				(Manfred Spraul)
o   Remove duplicated function in irlmp			(Adrian Bunk)
o   Throw out some more bogons found whilst splitting.
o   Compile warning fix for ikconfig.			(Adrian Bunk)
o   Kill unused var in bpck6				(Adrian Bunk)
o   Compilation fix for 586TSC				(Manfred Spraul)
o   Add missing VM86 exception handlers.		(Manfred Spraul)
o   Fix d_subdir counting in dcache_readdir		(Charles A. Clinton)
    | Munged to apply to 2.5 by me.
o   Fix exports in pci makefile.			(Greg KH)
o   Convert pidhash to use list_t			(William Lee Irwin III)
o   Fix compile warning in dnotify.			(Steven Rothwell)
o   Fix zftape bit function abuse.			(Mikael Pettersson)
o   Drop various USB bits.
    | Larger updates in mainline soon.
o   Do not increment TcpAttemptFails twice.		(David S. Miller)
o   Remove pointless CONFIG_SYN_COOKIES ifdef.		(Christoph Hellwig)
o   Fix export-objs usage in Makefiles.			(Keith Owens)
o   Fix compile error with CONFIG_NET_CLS_POLICE	(David S. Miller)
o   Fix JFS deadlock when flushing data during commit.	(Dave Kleikamp)
o   kNFSd export_operations support for isofs.		(Neil Brown)
o   Make setresuid/setresgid more consistent wrt fsuid	(Linus Torvalds)
o   Fix tasklet leak in PPPoATM.			(Luca Barbieri)
o   Update to IDE-60.					(Martin Dalecki)
o   Minor NTFS clean ups.				(Anton Altaparmakov)
o   Fix use after __init bug in 3c509.			(Kasper Dupont)
o   Dump extended MSRs in P4/Xeon MCE handler.		(Zwane Mwaikambo)
o   block_dev doesn't need f_version.			(Manfred Spraul)
o   Remove unused vars from paride.			(Frank Davis)
o   mmap() correctness fix.				("DervishD",
							 David G?mez Espinosa)
o   Incorrect sizeof in kmem_cache_sizes_init()		(Manfred Spraul)
o   try_atomic_semop() cleanup.				(Manfred Spraul)


-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
