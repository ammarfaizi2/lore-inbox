Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261766AbTHTH71 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 03:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbTHTH71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 03:59:27 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:21197 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S261766AbTHTH7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 03:59:20 -0400
Date: Wed, 20 Aug 2003 18:00:26 +1000
Message-Id: <200308200800.h7K80Qfh011660@theirongiant.lochness.weebeastie.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 4/16] C99: 2.6.0-t3-bk7/arch/arm26
Cc: Linus Torvalds <torvalds@osdl.org>
From: CaT <cat@zip.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -aur linux.backup/arch/arm26/kernel/setup.c linux/arch/arm26/kernel/setup.c
--- linux.backup/arch/arm26/kernel/setup.c	Sat Aug 16 15:02:16 2003
+++ linux/arch/arm26/kernel/setup.c	Wed Aug 20 16:40:22 2003
@@ -304,12 +304,12 @@
 
 #if defined(CONFIG_DUMMY_CONSOLE)
 struct screen_info screen_info = {
- orig_video_lines:	30,
- orig_video_cols:	80,
- orig_video_mode:	0,
- orig_video_ega_bx:	0,
- orig_video_isVGA:	1,
- orig_video_points:	8
+ .orig_video_lines	= 30,
+ .orig_video_cols	= 80,
+ .orig_video_mode	= 0,
+ .orig_video_ega_bx	= 0,
+ .orig_video_isVGA	= 1,
+ .orig_video_points	= 8
 };
 
 static int __init parse_tag_videotext(const struct tag *tag)
