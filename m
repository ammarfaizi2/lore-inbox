Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129664AbQLROi6>; Mon, 18 Dec 2000 09:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130098AbQLROit>; Mon, 18 Dec 2000 09:38:49 -0500
Received: from virtualro.ic.ro ([194.102.78.138]:53003 "EHLO virtualro.ic.ro")
	by vger.kernel.org with ESMTP id <S129664AbQLROii>;
	Mon, 18 Dec 2000 09:38:38 -0500
Date: Mon, 18 Dec 2000 16:07:26 +0200 (EET)
From: Jani Monoses <jani@virtualro.ic.ro>
To: twaugh@redhat.com
cc: linux-kernel@vger.kernel.org
Subject: [patch] inode.c doc fix
Message-ID: <Pine.LNX.4.10.10012181605000.14823-100000@virtualro.ic.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi
	here's a patch for documenting the newly introduced flags field
in mark_inode_dirty().

Jani.

--- /usr/src/linux/fs/inode.c	Mon Dec 18 15:57:34 2000
+++ inode.c	Mon Dec 18 16:08:14 2000
@@ -125,8 +125,10 @@
 /**
  *	__mark_inode_dirty -	internal function
  *	@inode: inode to mark
+ *	@flags: dirty flag mask (i.e. I_DIRTY)
  *
- *	Mark an inode as dirty. Callers should use mark_inode_dirty.
+ *	Mark an inode as dirty by setting the specified flags in the inode's i_state field. 
+ *	Callers should use mark_inode_dirty() or mark_inode_dirty_sync().
  */
  
 void __mark_inode_dirty(struct inode *inode, int flags)


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
