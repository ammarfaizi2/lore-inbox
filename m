Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbWAYNtS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbWAYNtS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 08:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbWAYNtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 08:49:18 -0500
Received: from darwin.snarc.org ([81.56.210.228]:59032 "EHLO darwin.snarc.org")
	by vger.kernel.org with ESMTP id S1751157AbWAYNtS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 08:49:18 -0500
Date: Wed, 25 Jan 2006 14:49:13 +0100
From: Vincent Hanquez <vincent@snarc.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <greg@kroah.com>
Subject: [PATCH] debugfs: trivial comment fix
Message-ID: <20060125134913.GA8594@snarc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Email may contain unsmilyfied humor and/or satire.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Greg & list,

please apply the following patch:

Fix trivial type mixup in the debugfs function comments.

Signed-off-by: Vincent Hanquez <vincent@snarc.org>

--- a/fs/debugfs/file.c	2006-01-25 13:45:04.000000000 +0000
+++ b/fs/debugfs/file.c	2006-01-25 13:46:47.000000000 +0000
@@ -56,7 +56,7 @@
 DEFINE_SIMPLE_ATTRIBUTE(fops_u8, debugfs_u8_get, debugfs_u8_set, "%llu\n");
 
 /**
- * debugfs_create_u8 - create a file in the debugfs filesystem that is used to read and write a unsigned 8 bit value.
+ * debugfs_create_u8 - create a file in the debugfs filesystem that is used to read and write an unsigned 8 bit value.
  *
  * @name: a pointer to a string containing the name of the file to create.
  * @mode: the permission that the file should have
@@ -98,7 +98,7 @@
 DEFINE_SIMPLE_ATTRIBUTE(fops_u16, debugfs_u16_get, debugfs_u16_set, "%llu\n");
 
 /**
- * debugfs_create_u16 - create a file in the debugfs filesystem that is used to read and write a unsigned 8 bit value.
+ * debugfs_create_u16 - create a file in the debugfs filesystem that is used to read and write an unsigned 16 bit value.
  *
  * @name: a pointer to a string containing the name of the file to create.
  * @mode: the permission that the file should have
@@ -140,7 +140,7 @@
 DEFINE_SIMPLE_ATTRIBUTE(fops_u32, debugfs_u32_get, debugfs_u32_set, "%llu\n");
 
 /**
- * debugfs_create_u32 - create a file in the debugfs filesystem that is used to read and write a unsigned 8 bit value.
+ * debugfs_create_u32 - create a file in the debugfs filesystem that is used to read and write an unsigned 32 bit value.
  *
  * @name: a pointer to a string containing the name of the file to create.
  * @mode: the permission that the file should have
