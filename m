Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263919AbUDPXOA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 19:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263941AbUDPXOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 19:14:00 -0400
Received: from linux-bt.org ([217.160.111.169]:29866 "EHLO mail.holtmann.net")
	by vger.kernel.org with ESMTP id S263919AbUDPXNy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 19:13:54 -0400
Subject: [PATCH] Fix typo in the openpromfs remount patch
From: Marcel Holtmann <marcel@holtmann.org>
To: Linus Torvalds <torvalds@osdl.org>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-+A8lESQd9Wv5OK7VX11I"
Message-Id: <1082157219.2985.41.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 17 Apr 2004 01:13:39 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+A8lESQd9Wv5OK7VX11I
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Linus,

the openpromfs remount patch which was merged some minutes ago contains
a silly typo in the field of the super_operations structure.

Regards

Marcel


--=-+A8lESQd9Wv5OK7VX11I
Content-Disposition: attachment; filename=patch
Content-Type: text/plain; name=patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

===== fs/openpromfs/inode.c 1.27 vs edited =====
--- 1.27/fs/openpromfs/inode.c	Fri Apr 16 17:39:36 2004
+++ edited/fs/openpromfs/inode.c	Sat Apr 17 00:59:25 2004
@@ -1027,7 +1027,7 @@
 static struct super_operations openprom_sops = { 
 	.read_inode	= openprom_read_inode,
 	.statfs		= simple_statfs,
-	.remount	= openprom_remount,
+	.remount_fs	= openprom_remount,
 };
 
 static int openprom_fill_super(struct super_block *s, void *data, int silent)

--=-+A8lESQd9Wv5OK7VX11I--

