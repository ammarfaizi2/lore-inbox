Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292283AbSBTU3y>; Wed, 20 Feb 2002 15:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292285AbSBTU3s>; Wed, 20 Feb 2002 15:29:48 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:346 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S292283AbSBTU3d>; Wed, 20 Feb 2002 15:29:33 -0500
Date: Wed, 20 Feb 2002 21:29:31 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.18rc2aa1
Message-ID: <20020220212931.B1291@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

URL:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.18rc2aa1.gz
	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.18rc2aa1/

Only in 2.4.18rc2aa1: 00_VM_IO-2
Only in 2.4.18pre7aa2: 00_VM_IO-fbmem-1

	VM_IO updated from Andrew.

Only in 2.4.18rc2aa1: 00_dcache-inline-1

	Optimize cachelines and 64bit archs (and longer names) from Andi.

Only in 2.4.18pre7aa2: 00_get_user_pages-2
Only in 2.4.18pre7aa2: 00_netfilter-missing-1

	Merged into mainline.

Only in 2.4.18rc2aa1: 00_hpfs-oops-1

	Oops fix from Chris Mason.

Only in 2.4.18rc2aa1: 00_max_bytes-1

	Sanitize max_bytes from Andi.

Only in 2.4.18pre7aa2: 00_nanosleep-5
Only in 2.4.18rc2aa1: 00_nanosleep-6

	Rediffed.

Only in 2.4.18pre7aa2: 00_nfs-2.4.17-cto-2
Only in 2.4.18rc2aa1: 00_nfs-2.4.17-cto-3
Only in 2.4.18pre7aa2: 00_nfs-tcp-tweaks-2
Only in 2.4.18rc2aa1: 00_nfs-tcp-tweaks-3
Only in 2.4.18pre7aa2: 10_nfs-o_direct-2
Only in 2.4.18rc2aa1: 10_nfs-o_direct-3

	Latest updates from Trond.

Only in 2.4.18rc2aa1: 00_ptrace-fix-1

	Fix ptrace MAY bits from Linus.

Only in 2.4.18pre7aa2: 00_xtime-lock-1

	Not needed anymore (do_gettimeofday locks internally).

Only in 2.4.18pre7aa2: 10_rawio-vary-io-1
Only in 2.4.18rc2aa1: 10_rawio-vary-io-2

	Fix sd_mod linking with the kernel.

Only in 2.4.18pre7aa2: 10_vm-24
Only in 2.4.18rc2aa1: 10_vm-25

	Updates (also change BH_Wait_IO not to deal with dirty buffers).

Only in 2.4.18pre7aa2: 20_highmem-debug-8
Only in 2.4.18rc2aa1: 20_highmem-debug-9

	Rediffed.

Only in 2.4.18pre7aa2: 20_pte-highmem-11
Only in 2.4.18rc2aa1: 20_pte-highmem-12

	Merged cleanups and optimizations from Hugh, now persistence is
	fully functional for ptes too and shared across all series.
	This has an API to drivers incompatible with the ""simpler"" inferior
	version from Ingo and Arjan merged in mainline since 2.5.5. I'll
	probably be forced to add the vmalloc horrible changes because their
	API doesn't contemplate an unmap for the vmalloc ptes and so I couldn't
	be compatible with the inferior implementation by just adding a pair of
	#defines. The only difference is that their version clobbers all the
	page fault fast path slowing it down for non-highmem and 64bit archs
	too, plus they are forced to mess with the tlb at every pte_offset
	while we don't thanks to the persistence that also optimizes the
	non-highmem and 64bit archs, and so pte-highmem patch leads to much
	cleaner and _simpler_ code in general. If a daedlock happens with this
	code it could happen also without it. The config -highpte options also
	are overkill, before you are interested about 4G/64G-highpte, you will
	want 4G/64G-highpagecache, and binary kernels will have those options
	enabled to be generic.

Only in 2.4.18rc2aa1: 20_reiser-o_direct-1

	Add O_DIRECT to reiserfs.

Only in 2.4.18rc2aa1: 30_get_request-starvation-1

	Avoid non blocking tasks to eat requests under blocked tasks, give
	fairness to get_request. As written in the patch, from Andrew.

Only in 2.4.18rc2aa1: 50_uml-patch-2.4.17-12.gz
Only in 2.4.18pre7aa2: 50_uml-patch-2.4.17-9.gz

	Latest update from Jeff (probably doesn't compile due the lack of
	pte-highmem updates).

Only in 2.4.18pre7aa2: 51_uml-ac-to-aa-5
Only in 2.4.18rc2aa1: 51_uml-ac-to-aa-6

	Rediffed.

Only in 2.4.18pre7aa2: 60_tux-2.4.17-final-A0.gz
Only in 2.4.18rc2aa1: 60_tux-2.4.17-final-A1.gz

	Latest update from Ingo.

Andrea
