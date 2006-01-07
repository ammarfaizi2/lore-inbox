Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030603AbWAGVvh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030603AbWAGVvh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 16:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030604AbWAGVvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 16:51:36 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:54022 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030603AbWAGVvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 16:51:35 -0500
Date: Sat, 7 Jan 2006 22:51:34 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/libfs.c: unexport simple_rename
Message-ID: <20060107215134.GX3774@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the unused EXPORT_SYMBOL(simple_rename).


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.15-mm2-full/fs/libfs.c.old	2006-01-07 22:02:31.000000000 +0100
+++ linux-2.6.15-mm2-full/fs/libfs.c	2006-01-07 22:02:38.000000000 +0100
@@ -635,7 +635,6 @@
 EXPORT_SYMBOL(simple_prepare_write);
 EXPORT_SYMBOL(simple_readpage);
 EXPORT_SYMBOL(simple_release_fs);
-EXPORT_SYMBOL(simple_rename);
 EXPORT_SYMBOL(simple_rmdir);
 EXPORT_SYMBOL(simple_statfs);
 EXPORT_SYMBOL(simple_sync_file);

