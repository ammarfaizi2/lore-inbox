Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263917AbRFNSnH>; Thu, 14 Jun 2001 14:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263924AbRFNSm5>; Thu, 14 Jun 2001 14:42:57 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:25408 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S263917AbRFNSmv>; Thu, 14 Jun 2001 14:42:51 -0400
Date: Thu, 14 Jun 2001 20:43:03 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.6pre3aa1 [was Re: 2.4.6pre2aa2 [was Re: 2.4.5aa1]]
Message-ID: <20010614204303.H2115@athlon.random>
In-Reply-To: <20010526193310.A1834@athlon.random> <20010613013419.A709@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010613013419.A709@athlon.random>; from andrea@suse.de on Wed, Jun 13, 2001 at 01:34:19AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diff between 2.4.6pre2aa2 and 2.4.6pre3aa1:

-----------------------------------------------------------------------------
Moved on top of 2.4.6pre3.

Only in 2.4.6pre2aa2: 00_alpha-compile-swapon-1
Only in 2.4.6pre2aa2: 00_x86-entry.S-fix-1

	Merged in 2.4.6pre3.

Only in 2.4.6pre3aa1: 00_backout-gcc-3_0-patch-1

	Backout 2.4.6pre3 gcc 3.0 change.

	(nice to have)

Only in 2.4.6pre3aa1: 00_alpha-warnings-1

	Fix alpha warning from Jeff.

	(nice to have)

Only in 2.4.6pre2aa2: 00_ksoftirqd-5
Only in 2.4.6pre3aa1: 00_ksoftirqd-6

	Replace _NOVERS with %c0.

	(nice to have)

Only in 2.4.6pre2aa2: 00_o_direct-8
Only in 2.4.6pre3aa1: 00_o_direct-9

	Improve truncate_inode_pages and invalidate_inode_pages2.

	This patch triggered a bug in the alpha port where O_DIRECT
	was defined as O_SYNC. O_DIRECTIO of tru64 is defined as ours
	O_NOFOLLOW, so some breakage is going on. To at least allow
	O_SYNC to work on alpha I defined for now O_DIRECT as 02000000
	and we'll possibly change it later.

	(recommended)

Only in 2.4.6pre3aa1: 00_backout-udelay-1
Only in 2.4.6pre3aa1: 10_alpha-udelay-1

	Replace 2.4.6pre3 change with a better fix proposed by me and
	implemented by Jeff.

	(nice to have)
-----------------------------------------------------------------------------

Andrea
