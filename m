Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263661AbTLECWN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 21:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263796AbTLECWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 21:22:13 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:33152
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263661AbTLECWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 21:22:06 -0500
Date: Fri, 5 Dec 2003 03:22:25 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.23aa1
Message-ID: <20031205022225.GA1565@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This should be the last 2.4-aa kernel ;)

URL:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.23aa1.gz

Changelog diff between 2.4.22pre6aa3 and 2.4.23aa1:

Only in 2.4.23pre6aa3: 00_binfmt-elf-checks-3
Only in 2.4.23aa1: 00_binfmt-elf-checks-4
Only in 2.4.23pre6aa3: 00_extraversion-32
Only in 2.4.23aa1: 00_extraversion-33
Only in 2.4.23pre6aa3: 00_nfs_writeback-1
Only in 2.4.23aa1: 00_nfs_writeback-2
Only in 2.4.23pre6aa3: 00_silent-stack-overflow-19
Only in 2.4.23aa1: 00_silent-stack-overflow-20
Only in 2.4.23pre6aa3: 05_vm_22_vm-anon-lru-2
Only in 2.4.23aa1: 05_vm_22_vm-anon-lru-3
Only in 2.4.23pre6aa3: 05_vm_26-rest-1
Only in 2.4.23aa1: 05_vm_26-rest-2
Only in 2.4.23pre6aa3: 10_inode-highmem-2
Only in 2.4.23aa1: 10_inode-highmem-3
Only in 2.4.23pre6aa3: 60_tux-exports-7
Only in 2.4.23aa1: 60_tux-exports-8
Only in 2.4.23pre6aa3: 70_iget-1
Only in 2.4.23aa1: 70_iget-2
Only in 2.4.23pre6aa3: 93_NUMAQ-14
Only in 2.4.23aa1: 93_NUMAQ-16
Only in 2.4.23pre6aa3: 9900_aio-24.gz
Only in 2.4.23aa1: 9900_aio-25.gz
Only in 2.4.23pre6aa3: 9910_shm-largepage-17.gz
Only in 2.4.23aa1: 9910_shm-largepage-18.gz
Only in 2.4.23pre6aa3: 9920_kgdb-12.gz
Only in 2.4.23aa1: 9920_kgdb-13.gz
Only in 2.4.23pre6aa3: 9925_kmsgdump-0.4.4-4.gz
Only in 2.4.23aa1: 9925_kmsgdump-0.4.4-5.gz
Only in 2.4.23pre6aa3: 9980_fix-pausing-6
Only in 2.4.23aa1: 9980_fix-pausing-7
Only in 2.4.23pre6aa3: 9985_blk-atomic-12
Only in 2.4.23aa1: 9985_blk-atomic-13
Only in 2.4.23pre6aa3: 9999900_q-full-1
Only in 2.4.23aa1: 9999900_q-full-2
Only in 2.4.23pre6aa3: 9999_mmap-cache-2
Only in 2.4.23aa1: 9999_mmap-cache-3
Only in 2.4.23pre6aa3: 9999_sched_yield_scale-8
Only in 2.4.23aa1: 9999_sched_yield_scale-9
Only in 2.4.23pre6aa3: 9999_zzz-dynamic-hz-3.gz
Only in 2.4.23aa1: 9999_zzz-dynamic-hz-4.gz

	Rediffed.

Only in 2.4.23pre6aa3: 00_do_brk-1
Only in 2.4.23pre6aa3: 00_pppoe-release-1
Only in 2.4.23pre6aa3: 00_proc-readlink-1
Only in 2.4.23pre6aa3: 00_sk98lin-char-fix-1
Only in 2.4.23pre6aa3: 00_tcp-conntrack-fin-1
Only in 2.4.23pre6aa3: 9999_01_x86_64-fault32-wrap-1
Only in 2.4.23pre6aa3: 9999900_shmem_truncate-against-swapoff-1
Only in 2.4.23pre6aa3: 9999_z-laptopmode-1

	Merged in mainline.

Only in 2.4.23aa1: 00_readahead-last-page-1

	Make sure to read the last page of a file via readahead if possible,
	otherwise we could send two synchronous requests down to the fs instead
	of a single one. Fix from Chuck Lever.

Only in 2.4.23aa1: 05_vm_00_anon-lru-race-better-fix-1

	Serialize inserction in swapcache with the pagemap_lru_lock
	spinlock, to avoid having to use a flood of atomic ops
	(this benefits especially non x86 archs, for x86 if the
	cacheline is in l1 it's not a big cost). pagecache
	operations are unaffected this way.

Only in 2.4.23pre6aa3: 9999_z-execve-race-1
Only in 2.4.23aa1: 05_vm_02-execve-mm-fast-path-safe-1

	Avoid dropping the fast path in execve when mm_users == 1.
	Original fix from Ernie Petrides.

Only in 2.4.23aa1: 30_00_posix-race-1
Only in 2.4.23aa1: 30_02_fix-commit-1
Only in 2.4.23aa1: 30_03_fix-osx-1
Only in 2.4.23aa1: 30_04_soft2-1
Only in 2.4.23pre6aa3: 30_05_seekdir-1
Only in 2.4.23aa1: 30_05_seekdir-2
Only in 2.4.23pre6aa3: 30_08_rdplus-1
Only in 2.4.23aa1: 30_08_rdplus-2
Only in 2.4.23aa1: 30_09_fix-unlink-1
Only in 2.4.23aa1: 30_10-sock-disconnect-1
Only in 2.4.23pre6aa3: 30_12-lockd3-1
Only in 2.4.23aa1: 30_12-lockd3-2
Only in 2.4.23pre6aa3: 30_14-pathconf-2
Only in 2.4.23aa1: 30_14-pathconf-3
Only in 2.4.23pre6aa3: 30_18-busy-inodes-1

	NFS updates from Trond's website.

Only in 2.4.23pre6aa3: 50_uml-patch-2.4.20-5-2.gz
Only in 2.4.23aa1: 50_uml-patch-2.4.20-5-3.gz

	Rediffed. The new version pretents to change the API
	for munmap in the f_ops, that's too invasive for 2.4 IMHO.

Only in 2.4.23pre6aa3: 90_ext3-commit-interval-5

	Obsoleted by the laptop mode (I hope it's "fully" obsoleted ;).

Only in 2.4.23pre6aa3: 9986_elevator-merge-fast-path-2

	Dropped, seems to have a race of some sort (triggers on some
	ia64).
