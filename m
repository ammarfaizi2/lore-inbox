Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132782AbQLRAgG>; Sun, 17 Dec 2000 19:36:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132798AbQLRAf4>; Sun, 17 Dec 2000 19:35:56 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:15633 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132782AbQLRAfq>; Sun, 17 Dec 2000 19:35:46 -0500
Subject: Re: 2.4.0-test13-pre3 and ext2 as module
To: gandalf@wlug.westbo.se (Martin Josefsson)
Date: Mon, 18 Dec 2000 00:07:37 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0012180055220.26302-100000@tux.rsn.hk-r.se> from "Martin Josefsson" at Dec 18, 2000 12:59:05 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E147nq8-0004lF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I compiled test13-pre3 a few minutes ago and when running
> make modules_install I got this:
> 
> depmod: *** Unresolved symbols in /lib/modules/2.4.0-test13-pre3/kernel/fs/ext2/ext2.o
> depmod:         buffer_insert_inode_queue
> depmod:         fsync_inode_buffers

Jeff Raubitschek posted a patch for this on the 12th. 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
