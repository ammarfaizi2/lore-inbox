Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285317AbRLSPQY>; Wed, 19 Dec 2001 10:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285320AbRLSPQF>; Wed, 19 Dec 2001 10:16:05 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:19049 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S285323AbRLSPQB>; Wed, 19 Dec 2001 10:16:01 -0500
Date: Wed, 19 Dec 2001 16:16:10 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.17rc2aa1
Message-ID: <20011219161610.I1395@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This should fix the last loop deadlocks under VM pressure, if not please
let me know.

I didn't fixed the ia64 compilation troubles, but it should be very easy
to fix if anybody needs.

URL:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.17rc2aa1.bz2
	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.17rc2aa1/

Only in 2.4.17rc1aa1: 00_loop-deadlock-1

	Merged in mainline.

Only in 2.4.17rc2aa1: 00_pgt-cache-leak-1

	Avoid potentially leaking pagetables into the per-cpu queues.

Only in 2.4.17rc2aa1: 00_x86-fast-pte-1

	Reenable the pagetable per-cpu queues on x86 that I found to be
	disabled during 2.4.17pre.

Only in 2.4.17rc1aa1: 10_vm-20
Only in 2.4.17rc2aa1: 10_vm-21

	Drop some leftover and rediffed.

Only in 2.4.17rc1aa1: 60_tux-2.4.16-final-D5.bz2
Only in 2.4.17rc2aa1: 60_tux-2.4.16-final-D6.bz2

	Latest update from Ingo at www.redhat.com/~mingo/ .

Only in 2.4.17rc2aa1: 70_loop-deadlock-2

	Previous fix cured balance_dirty(), this one will cure
	the memory balancing, to avoid reentrant I/O in the loop
	thread.

Andrea
