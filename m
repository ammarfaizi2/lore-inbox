Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265193AbRGGQoh>; Sat, 7 Jul 2001 12:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264582AbRGGQo1>; Sat, 7 Jul 2001 12:44:27 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:51224 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S265193AbRGGQoS>; Sat, 7 Jul 2001 12:44:18 -0400
Date: Sat, 7 Jul 2001 18:44:20 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.7pre3aa1
Message-ID: <20010707184419.I2425@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diff between 2.4.7pre2aa1 and 2.4.7pre3aa1:

---------------------------------------------------------
Only in 2.4.7pre2aa1: 00_3c59x-zerocopy-1
Only in 2.4.7pre3aa1: 00_3c59x-zerocopy-2

	Right fix for enabling zerocopy on highmem kernels.

	(nice to have)

Only in 2.4.7pre3aa1: 00_async-io-unlock-race-1

	Fix possible memory corruption due a race where
	the page can be unlocked under us and so the bh could
	be unlocked as well under us. Found it in -ac.

	(recommended)

Only in 2.4.7pre2aa1: 00_ksoftirqd-7
Only in 2.4.7pre3aa1: 00_ksoftirqd-8

	Add the BUG() check, to be as strict as mainline (no functional
	differences for correct code).

	(nice to have)

Only in 2.4.7pre3aa1: 00_meminfo-wraparound-1

	Use long long in /proc/meminfo to avoid wrap arounds on >4G boxes.

	(nice to have)

Only in 2.4.7pre3aa1: 00_rawio-down_read-1

	Use read lock for rawio.

	(nice to have)

Only in 2.4.7pre2aa1: 00_vm-deadlock-fix-1
Only in 2.4.7pre2aa1: 00_xircom-serial-1

	Merged in mainline.

Only in 2.4.7pre2aa1: 10_blkdev-pagecache-4
Only in 2.4.7pre3aa1: 40_experimental

	Moved the 10_blkdev-pagecache-4 patch back into the
	40_experimental directory, don't apply it for
	production it's not ready yet, initrd is still broken
	(it will be fixed soon).
---------------------------------------------------------

Andrea
