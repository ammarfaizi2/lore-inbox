Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315191AbSEKVwn>; Sat, 11 May 2002 17:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315199AbSEKVwm>; Sat, 11 May 2002 17:52:42 -0400
Received: from revdns.flarg.info ([213.152.47.19]:39040 "EHLO noodles.internal")
	by vger.kernel.org with ESMTP id <S315191AbSEKVwm>;
	Sat, 11 May 2002 17:52:42 -0400
Date: Sat, 11 May 2002 22:53:34 +0100
From: Dave Jones <davej@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.15-dj1
Message-ID: <20020511215334.GA2918@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clearing out the pending folder once again.
I cheated a little this time, and took a bunch of pending items from
Linus' bitkeeper tree in a vain hope to cut down merging time later.
This also drops a few 'stagnant' items from my tree as well as those
mentioned further down the changelog.

As usual,..

Patch against 2.5.15 vanilla is available from:
ftp://ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.5/

Merged patch archive: http://www.codemonkey.org.uk/patches/merged/

Check http://www.codemonkey.org.uk/Linux-2.5.html before reporting
known bugs that are also in mainline.

 -- Davej.

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
							 David Gomez Espinosa)
o   Incorrect sizeof in kmem_cache_sizes_init()		(Manfred Spraul)
o   try_atomic_semop() cleanup.				(Manfred Spraul)

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
