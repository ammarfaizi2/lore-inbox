Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129930AbQLRUGR>; Mon, 18 Dec 2000 15:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130235AbQLRUGI>; Mon, 18 Dec 2000 15:06:08 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:31249 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129930AbQLRUGC>; Mon, 18 Dec 2000 15:06:02 -0500
Date: Mon, 18 Dec 2000 20:35:01 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Heinz Mauelshagen <mauelshagen@sistina.com>, linux-kernel@vger.kernel.org
Subject: lvm 0.9 + fixes
Message-ID: <20001218203501.A22476@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, could you include lvm 0.9 into 2.4.x? It adds snapshot persistence and
it fixes a severe race condition during live extent-reduce.

I ported lvm-0.9 to 2.4.0-test13-pre3 and then I included into it further fixes
that are present in my local tree for a memory leak plus other kiobufs
cleanups and minor things. I also #defined LVM_GET_INODE and undefined the
LVM_HD_NAME so that we don't have to include the check.c lvm_hd_name_ptr
ugliness.

Patch is here:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.0-test13-pre3/lvm-0.9-aa-1

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
