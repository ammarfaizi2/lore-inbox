Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265218AbSJPQtp>; Wed, 16 Oct 2002 12:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265182AbSJPQr6>; Wed, 16 Oct 2002 12:47:58 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:24116 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S265183AbSJPQqW>; Wed, 16 Oct 2002 12:46:22 -0400
Date: Wed, 16 Oct 2002 18:51:55 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Srihari Vijayaraghavan <harisri@bigpond.com>
Subject: 2.4.20pre11aa1
Message-ID: <20021016165155.GE30254@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srihari, I would like if you could try to reproduce with this new one
with CONFIG_SOUND=n.  Thanks!

URL:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.20pre11aa1.gz
	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.20pre11aa1/

Only in 2.4.20pre10aa1: 00_extraversion-10
Only in 2.4.20pre11aa1: 00_extraversion-11
Only in 2.4.20pre10aa1: 00_max_bytes-5
Only in 2.4.20pre11aa1: 00_max_bytes-6
Only in 2.4.20pre10aa1: 60_pagecache-atomic-6
Only in 2.4.20pre11aa1: 60_pagecache-atomic-7
Only in 2.4.20pre10aa1: 70_intermezzo-junk-1
Only in 2.4.20pre11aa1: 70_intermezzo-junk-2

	Rediffed.

Only in 2.4.20pre11aa1: 00_fcntl_getfl-largefile-1

	Clear the implicit O_LARGEPAGE with 64bit archs.

Only in 2.4.20pre11aa1: 00_o_direct-read-overflow-write-locking-xfs-2

	fix xfs compilation (from Christoph).

Only in 2.4.20pre10aa1: 20_sched-o1-fixes-4
Only in 2.4.20pre11aa1: 20_sched-o1-fixes-5

	Take the expired queue into account in sched_yield, still
	sched_yield is a cpu-local operation unlike in 2.4 mainline.

	Fix idle rescheduling so we don't waste an 80% of the cpu power of some
	big irons.

	Fixed a race that could explain some instability (in my my tree only).

Only in 2.4.20pre10aa1: 86_x86_64-tsc-hpet-pit-1

	Dropped temporarily.

Only in 2.4.20pre10aa1: 9900_aio-11.gz
Only in 2.4.20pre11aa1: 9900_aio-12.gz

	Unplug the queue properly in the next_chunk passes too. (from
	Chris Mason)

Andrea
