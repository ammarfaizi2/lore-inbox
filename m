Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292383AbSB0MvB>; Wed, 27 Feb 2002 07:51:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292402AbSB0Mum>; Wed, 27 Feb 2002 07:50:42 -0500
Received: from ns.suse.de ([213.95.15.193]:38919 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S292339AbSB0Mub>;
	Wed, 27 Feb 2002 07:50:31 -0500
Date: Wed, 27 Feb 2002 13:50:01 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19pre1aa1
Message-ID: <20020227135001.I1495@inspiron.school.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to have feedback about this VM update, if nobody can find
any serious issue I'd try to push vm-28 into mainline during 2.4.19pre.
Please test oom conditions as well.

Thanks!

URL:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre1aa1.gz
	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre1aa1/

Only in 2.4.18rc4aa1: 00_block-highmem-all-18b-3.gz
Only in 2.4.19pre1aa1: 00_block-highmem-all-18b-4.gz

	Fix leftover setting.

Only in 2.4.18rc4aa1: 00_hpfs-oops-1
Only in 2.4.18rc4aa1: 30_get_request-starvation-1
Only in 2.4.18rc4aa1: 00_init-blk-freelist-1

	Now in mainline.

Only in 2.4.19pre1aa1: 00_lcall_trace-1

	call gate entry point speciality.

Only in 2.4.18rc4aa1: 00_prepare-write-fixes-1
Only in 2.4.19pre1aa1: 00_prepare-write-fixes-2

	Avoid false positives (agreed Andrew?).

Only in 2.4.18rc4aa1: 10_rawio-vary-io-2
Only in 2.4.19pre1aa1: 10_rawio-vary-io-3

	Rediffed.

Only in 2.4.18rc4aa1: 10_vm-27
Only in 2.4.19pre1aa1: 10_vm-28

	Further updates. As soon as I get the confirm this goes well in all the
	benchmarks I think it should go into mainline.

Only in 2.4.18rc4aa1: 70_xfs-1.gz
Only in 2.4.19pre1aa1: 70_xfs-2.gz

	Drop PG_launder, never really existed in -aa, wait_IO does a
	better job (not only for dirty bh submitted by the vm) and wait_IO is
	just supported by xfs.

Andrea
