Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261342AbUJ3VoR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbUJ3VoR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 17:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbUJ3Vme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 17:42:34 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:20996 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261342AbUJ3VkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 17:40:12 -0400
Date: Sat, 30 Oct 2004 23:39:35 +0200
From: Adrian Bunk <bunk@stusta.de>
To: rathamahata@php4.ru
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] befs: #if 0 two unused global functions
Message-ID: <20041030213935.GC4374@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below #if 0's two unussed global functions.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm2-full/fs/befs/debug.c.old	2004-10-30 20:44:22.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full/fs/befs/debug.c	2004-10-30 20:45:10.000000000 +0200
@@ -222,6 +222,7 @@
 #endif				//CONFIG_BEFS_DEBUG
 }
 
+#if 0
 /* unused */
 void
 befs_dump_small_data(const struct super_block *sb, befs_small_data * sd)
@@ -241,6 +242,7 @@
 
 #endif				//CONFIG_BEFS_DEBUG
 }
+#endif  /*  0  */
 
 void
 befs_dump_index_entry(const struct super_block *sb, befs_btree_super * super)
