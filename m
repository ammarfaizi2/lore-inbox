Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313476AbSDETJD>; Fri, 5 Apr 2002 14:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313479AbSDETIz>; Fri, 5 Apr 2002 14:08:55 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:46188 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S313476AbSDETIg>; Fri, 5 Apr 2002 14:08:36 -0500
Date: Fri, 5 Apr 2002 21:09:00 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19pre6aa1
Message-ID: <20020405210900.A1299@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

URL:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre6aa1/
	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre6aa1.gz

Changelog diff between 2.4.19pre5aa1 and 2.4.19pre6aa1:

Only in 2.4.19pre5aa1: 00_blkdev-close-1
Only in 2.4.19pre5aa1: 00_vm_start-drivers-1

	Merged in mainline.

Only in 2.4.19pre5aa1: 00_block-highmem-all-18b-8.gz
Only in 2.4.19pre6aa1: 00_block-highmem-all-18b-9.gz
Only in 2.4.19pre5aa1: 00_cpu-affinity-rml-1
Only in 2.4.19pre6aa1: 00_cpu-affinity-rml-2
Only in 2.4.19pre5aa1: 00_max_bytes-2
Only in 2.4.19pre6aa1: 00_max_bytes-3
Only in 2.4.19pre5aa1: 00_pgt-cache-leak-1
Only in 2.4.19pre6aa1: 00_pgt-cache-leak-2
Only in 2.4.19pre5aa1: 20_highmem-debug-10
Only in 2.4.19pre6aa1: 20_highmem-debug-11
Only in 2.4.19pre5aa1: 20_numa-mm-3
Only in 2.4.19pre6aa1: 20_numa-mm-4
Only in 2.4.19pre5aa1: 80_x86_64-common-code-1
Only in 2.4.19pre6aa1: 80_x86_64-common-code-2

	Rediffed.

Only in 2.4.19pre6aa1: 00_export-vmalloc_to_page-1

	Linus and Ingo agreed in exporting this symbol to non GPL modules.
	(and logic deduction says I'd be allowed to change this anyways, either
	that or all binary only modules are illegal in the first place, still
	not me)

Only in 2.4.19pre6aa1: 00_k7-prefetch-1

	Avoid prefetching out of bounds (I recall prefetch should remain transparent
	regardless if the vaddr is valid or not, but this is saner anyways).
	Extracted from 2.4.19pre4ac3.

Only in 2.4.19pre6aa1: 00_nfs-backout-cto-1
Only in 2.4.19pre5aa1: 00_nfs-rdplus-3

	Temporarly backout rdplus and cto (btw, cto is been merged in pre4).
	This should give the usual x2 faster nfs performnce while handling
	hundred thousand files. Mario, confirm? As said this is a temporary
	measure.

Only in 2.4.19pre5aa1: 00_nfs-tcp-tweaks-4-rmv-cong-nonsense-3
Only in 2.4.19pre6aa1: 00_nfs-tcp-tweaks-4-try-new-1

	Replaced the vanilla 2.4 congestion control algorithm of nfs
	with the new one proposed by Trond on l-k.

Only in 2.4.19pre6aa1: 00_sd_softerr-1

	Fix a bug in soft error handling of scsi disks.

Only in 2.4.19pre5aa1: 00_tty-poll-1
Only in 2.4.19pre6aa1: 00_tty-poll-2

	New version (the previous one had a minor bug).

Only in 2.4.19pre5aa1: 00_vm86-1
Only in 2.4.19pre6aa1: 00_vm86-2

	vm86 updates extracted from 2.4.19pre4ac3.

Only in 2.4.19pre6aa1: 30_x86_memfree-boot-cleanup-1
Only in 2.4.19pre6aa1: 30_x86_setup-boot-cleanup-1

	Restructuring the memfreeing and setup_arch boot stage.  Meant to make
	easier NUMA-Q incremental patching. Original patches are from Patricia
	Gaughen, those have some further additional cleanup from me.

Only in 2.4.19pre6aa1: 72_xfs-O_DIRECT-1

	Make possible to open files with O_DIRECT with xfs. (many thanks to
	Christoph Hellwig for spotting such subtle bug)

Andrea
