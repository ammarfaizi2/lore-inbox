Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131309AbQLPNH0>; Sat, 16 Dec 2000 08:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131380AbQLPNHR>; Sat, 16 Dec 2000 08:07:17 -0500
Received: from virtualro.ic.ro ([194.102.78.138]:51976 "EHLO virtualro.ic.ro")
	by vger.kernel.org with ESMTP id <S131309AbQLPNG6>;
	Sat, 16 Dec 2000 08:06:58 -0500
Date: Sat, 16 Dec 2000 14:35:28 +0200 (EET)
From: Jani Monoses <jani@virtualro.ic.ro>
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: inode.c inline doc fix
Message-ID: <Pine.LNX.4.10.10012161432001.10586-100000@virtualro.ic.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hi Linus,

	this adds (hopefully correct) documentation to the newly
intorduced flags parameter in mark_inode_dirty.


--- /usr/src/linux/fs/inode.c	Tue Dec 12 11:25:55 2000
+++ inode.c	Sat Dec 16 14:38:25 2000
@@ -125,8 +125,9 @@
 /**
  *	__mark_inode_dirty -	internal function
  *	@inode: inode to mark
- *
- *	Mark an inode as dirty. Callers should use mark_inode_dirty.
+ *	@flags: what kind of dirty (i.e. I_DIRTY_SYNC)
+ *	Mark an inode as dirty. Callers should use mark_inode_dirty or
+ *  	mark_inode_dirty_sync.
  */
  
 void __mark_inode_dirty(struct inode *inode, int flags)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
