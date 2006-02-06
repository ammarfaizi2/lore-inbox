Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964791AbWBFU3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964791AbWBFU3f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 15:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964788AbWBFU3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 15:29:35 -0500
Received: from mail.kroah.org ([69.55.234.183]:24253 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964786AbWBFU3e convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 15:29:34 -0500
Cc: vincent@snarc.org
Subject: [PATCH] debugfs: trivial comment fix
In-Reply-To: <1139257758363@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 6 Feb 2006 12:29:18 -0800
Message-Id: <11392577581679@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] debugfs: trivial comment fix

Fix trivial type mixup in the debugfs function comments.

Signed-off-by: Vincent Hanquez <vincent@snarc.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 276e0c75f1e9a8b34b7b19e8fe188be958d420dd
tree f44e4dbc0da80ab6d732a8715f0be3ffbcdff79b
parent d87499ed1a3ba0f6dbcff8d91c96ef132c115d08
author Vincent Hanquez <vincent@snarc.org> Wed, 25 Jan 2006 14:49:13 +0100
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 06 Feb 2006 12:17:18 -0800

 fs/debugfs/file.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index efc97d9..d575452 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -56,7 +56,7 @@ static u64 debugfs_u8_get(void *data)
 DEFINE_SIMPLE_ATTRIBUTE(fops_u8, debugfs_u8_get, debugfs_u8_set, "%llu\n");
 
 /**
- * debugfs_create_u8 - create a file in the debugfs filesystem that is used to read and write a unsigned 8 bit value.
+ * debugfs_create_u8 - create a file in the debugfs filesystem that is used to read and write an unsigned 8 bit value.
  *
  * @name: a pointer to a string containing the name of the file to create.
  * @mode: the permission that the file should have
@@ -98,7 +98,7 @@ static u64 debugfs_u16_get(void *data)
 DEFINE_SIMPLE_ATTRIBUTE(fops_u16, debugfs_u16_get, debugfs_u16_set, "%llu\n");
 
 /**
- * debugfs_create_u16 - create a file in the debugfs filesystem that is used to read and write a unsigned 8 bit value.
+ * debugfs_create_u16 - create a file in the debugfs filesystem that is used to read and write an unsigned 16 bit value.
  *
  * @name: a pointer to a string containing the name of the file to create.
  * @mode: the permission that the file should have
@@ -140,7 +140,7 @@ static u64 debugfs_u32_get(void *data)
 DEFINE_SIMPLE_ATTRIBUTE(fops_u32, debugfs_u32_get, debugfs_u32_set, "%llu\n");
 
 /**
- * debugfs_create_u32 - create a file in the debugfs filesystem that is used to read and write a unsigned 8 bit value.
+ * debugfs_create_u32 - create a file in the debugfs filesystem that is used to read and write an unsigned 32 bit value.
  *
  * @name: a pointer to a string containing the name of the file to create.
  * @mode: the permission that the file should have

