Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265936AbSLCC0U>; Mon, 2 Dec 2002 21:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265947AbSLCC0U>; Mon, 2 Dec 2002 21:26:20 -0500
Received: from [195.223.140.107] ([195.223.140.107]:21679 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S265936AbSLCC0P>;
	Mon, 2 Dec 2002 21:26:15 -0500
Date: Tue, 3 Dec 2002 03:33:49 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20aa1
Message-ID: <20021203023349.GF1205@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

URL:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.20aa1.gz
	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.20aa1/

Changelog diff between 2.4.20rc2aa1 and 2.4.20aa1:

Only in 2.4.20aa1: 00_config-smp-1

	Fixes places using __SMP__ thinking it would work
	as well as CONFIG_SMP.

Only in 2.4.20rc2aa1: 00_drop-inetpeer-cache-2.gz
Only in 2.4.20aa1: 00_drop-inetpeer-cache-3.gz

	Fix smp race due __SMP__ and increase the wrap around
	time per-cpu. from Andi and meissner.

Only in 2.4.20rc2aa1: 00_extraversion-13
Only in 2.4.20aa1: 00_extraversion-14

	Rediffed.

Only in 2.4.20aa1: 00_getcwd-err-1

	Report an error to userspace is getcwd can't return a correct
	value. From Jirka Kosina.

Only in 2.4.20rc2aa1: 00_highio-nohighmem-fix-1
Only in 2.4.20rc2aa1: 00_prepare-write-fixes-3
Only in 2.4.20rc2aa1: 00_presto-dentry-slab-1
Only in 2.4.20rc2aa1: 00_vmalloc-leak-fix-1

	Merged in mainline.

Only in 2.4.20aa1: 00_nfs-xid-smp-1

	Avoid xid races with different mountpoints (in case the highlevel
	locks don't serialize). From Olaf Kirch.

Only in 2.4.20aa1: 00_nfs_writeback-1

	Make sure not to lose writebacks in case of network errors during
	the pageouts from the vm.

Only in 2.4.20aa1: 00_nfsd-reply-cache-smp-1

	More smp locking in nfsd from Olaf Kirch.

Only in 2.4.20aa1: 00_tcp-syn-rst-fin-1

	Don't accept syns if they've rst or fin set too, from Andi Kleen.

Only in 2.4.20rc2aa1: 00_umount-against-unused-dirty-inodes-race-1
Only in 2.4.20aa1: 00_umount-against-unused-dirty-inodes-race-2

	Fix an UP deadlock in 2.4.20rc2aa1.

Only in 2.4.20aa1: 10_sched-o1-bluetooth-1

	o1 sched compile fix, problem noted by Eyal Lebedinsky.
	Eyal, FYI, DAC960 won't compile yet, if you need DAC960
	simply backout elevator-lowlatency until I/somebody will fix it.

Only in 2.4.20aa1: 9925_kmsgdump-0.4.4-1.gz

	Merged kmsgdump, from Willy Tarreau.

Only in 2.4.20rc2aa1: 9942_ocfs-compile-1
Only in 2.4.20aa1: 9942_ocfs-compile-2

	Delete the .c version file.

Only in 2.4.20rc2aa1: 9981_elevator-lowlatency-1
Only in 2.4.20aa1: 9981_elevator-lowlatency-2

	Increase the size to 2M and left unchanged the elvtune settings.  Also
	reduce the cost of a seek, first we don't know if the newly inserted
	request will eventually become big (like a merge), secondly we want
	seeks to be passed over easily by other seeks because the elevator will
	matter more with lots of seeks. We'll see if these changes helps or
	hurts.

Andrea
