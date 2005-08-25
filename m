Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964802AbVHYFVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbVHYFVO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 01:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751540AbVHYFVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 01:21:13 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58315 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S964802AbVHYFVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 01:21:05 -0400
To: geert@linux-m68k.org, torvalds@osdl.org
Subject: [PATCH] (6/22) dumb typo in atyfb
Cc: linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Message-Id: <E1E8ADj-0005bJ-6J@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Thu, 25 Aug 2005 06:24:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

atyfb_par misspelled as aty_par, fortunately in m68k-only part of driver

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc7-amigaints/drivers/video/aty/atyfb_base.c RC13-rc7-atyfb-typo/drivers/video/aty/atyfb_base.c
--- RC13-rc7-amigaints/drivers/video/aty/atyfb_base.c	2005-06-17 15:48:29.000000000 -0400
+++ RC13-rc7-atyfb-typo/drivers/video/aty/atyfb_base.c	2005-08-25 00:54:08.000000000 -0400
@@ -3458,7 +3458,7 @@
 
 static int __devinit atyfb_atari_probe(void)
 {
-	struct aty_par *par;
+	struct atyfb_par *par;
 	struct fb_info *info;
 	int m64_num;
 	u32 clock_r;
