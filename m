Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131812AbQLRAaP>; Sun, 17 Dec 2000 19:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132782AbQLRAaF>; Sun, 17 Dec 2000 19:30:05 -0500
Received: from rsn-rby-gw.hk-r.se ([194.47.128.222]:45233 "EHLO
	tux.rsn.hk-r.se") by vger.kernel.org with ESMTP id <S131812AbQLRA36>;
	Sun, 17 Dec 2000 19:29:58 -0500
Date: Mon, 18 Dec 2000 00:59:05 +0100 (CET)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-test13-pre3 and ext2 as module
Message-ID: <Pine.LNX.4.21.0012180055220.26302-100000@tux.rsn.hk-r.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I compiled test13-pre3 a few minutes ago and when running
make modules_install I got this:

depmod: *** Unresolved symbols in /lib/modules/2.4.0-test13-pre3/kernel/fs/ext2/ext2.o
depmod:         buffer_insert_inode_queue
depmod:         fsync_inode_buffers

As you may have noticed I have ext2 as a module, I have reiserfs as main
filesystem here on this system. This is not a critical error to me.

I havn't tried to compile ext2 into kernel.

.config is availiable if anyone wants it.

/Martin

Linux hackers are funny people: They count the time in patchlevels.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
