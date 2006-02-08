Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030479AbWBHDXX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030479AbWBHDXX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 22:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030499AbWBHDXB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 22:23:01 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:4737 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030484AbWBHDT5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 22:19:57 -0500
To: torvalds@osdl.org
Subject: [PATCH 25/29] __user annotations of video_spu_palette
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1F6fs5-0006EF-68@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 03:19:57 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: 1138797224 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 include/linux/dvb/video.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

bee14e1f8ae2d5fd3f324e0c8562f791537160b2
diff --git a/include/linux/dvb/video.h b/include/linux/dvb/video.h
index b1999bf..b81e58b 100644
--- a/include/linux/dvb/video.h
+++ b/include/linux/dvb/video.h
@@ -135,7 +135,7 @@ typedef struct video_spu {
 
 typedef struct video_spu_palette {      /* SPU Palette information */
 	int length;
-	uint8_t *palette;
+	uint8_t __user *palette;
 } video_spu_palette_t;
 
 
-- 
0.99.9.GIT

