Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263574AbTEMVd4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 17:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263572AbTEMVdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 17:33:55 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:23308 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263574AbTEMVdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 17:33:49 -0400
Date: Tue, 13 May 2003 22:46:32 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Riva Framebuffer update.
Message-ID: <Pine.LNX.4.44.0305132245140.12672-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This kills off warnings about unused variables. Please apply.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1079  -> 1.1080 
#	drivers/video/riva/fbdev.c	1.45    -> 1.46   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/05/12	jsimmons@maxwell.earthlink.net	1.1080
# [RIVA FBDEV] Removal of exccess variable. Kills off a few warnings.
# --------------------------------------------
#
diff -Nru a/drivers/video/riva/fbdev.c b/drivers/video/riva/fbdev.c
--- a/drivers/video/riva/fbdev.c	Mon May 12 14:53:32 2003
+++ b/drivers/video/riva/fbdev.c	Mon May 12 14:53:32 2003
@@ -1469,10 +1469,10 @@
 static int rivafb_cursor(struct fb_info *info, struct fb_cursor *cursor)
 {
 	struct riva_par *par = (struct riva_par *) info->par;
-	int i, j, d_idx = 0, s_idx = 0;
 	u8 data[MAX_CURS * MAX_CURS/8];
 	u8 mask[MAX_CURS * MAX_CURS/8];
 	u16 fg, bg;
+	int i;
 
 	par->riva.ShowHideCursor(&par->riva, 0);
 

