Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282396AbRKXHul>; Sat, 24 Nov 2001 02:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282397AbRKXHua>; Sat, 24 Nov 2001 02:50:30 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:40758 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S282396AbRKXHuQ>; Sat, 24 Nov 2001 02:50:16 -0500
Date: Sat, 24 Nov 2001 08:50:28 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.15aa1
Message-ID: <20011124085028.C1419@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Note: the "00_read_super-stale-inode-1" fix is under discussion with Al,
but overall it should be just ok for public consumation (even if that
are may change if we find any better alternative, at the moment I think
it is better (cleaner, simpler and faster) alternative than the iput
changes in function of the MS_ACTIVE info).

URL:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.15aa1.bz2
	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.15aa1/

Only in 2.4.15aa1: 00_iput-unmount-corruption-fix-1

	Fix iput umount corruption.

Only in 2.4.15aa1: 00_read_super-stale-inode-1

	If read_super fails avoid lefting stale inodes queued into
	the superblock.

Only in 2.4.15pre9aa1: 10_vm-16
Only in 2.4.15aa1: 10_vm-17

	Dropped a leftover touch_buffer in bread (there's just one in getblk in
	-aa, and we need it in getblk [not only for reiserfs]).

Andrea
