Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261967AbULKQzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbULKQzU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 11:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261969AbULKQzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 11:55:19 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:44807 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261967AbULKQzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 11:55:03 -0500
Date: Sat, 11 Dec 2004 17:54:55 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: rathamahata@php4.ru, linux-kernel@vger.kernel.org
Subject: [2.6 patch] befs: #if 0 two unused global functions (fwd)
Message-ID: <20041211165455.GU22324@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch forwarded below still applies and compiles against 
2.6.10-rc2-mm4.

Please apply.


----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Sat, 30 Oct 2004 23:39:35 +0200
From: Adrian Bunk <bunk@stusta.de>
To: rathamahata@php4.ru
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] befs: #if 0 two unused global functions

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
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

