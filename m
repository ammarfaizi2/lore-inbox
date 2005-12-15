Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422647AbVLOJ07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422647AbVLOJ07 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 04:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422639AbVLOJSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 04:18:03 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:10410 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1422637AbVLOJRk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 04:17:40 -0500
To: torvalds@osdl.org
Subject: [PATCH] em28xx: %zd for size_t
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1EmpF5-0007yd-VZ@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Thu, 15 Dec 2005 09:17:39 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>


---

 drivers/media/video/em28xx/em28xx-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

7ec823b9427fc0fe9d06ef716f62e5f1a3b9db96
diff --git a/drivers/media/video/em28xx/em28xx-core.c b/drivers/media/video/em28xx/em28xx-core.c
index e8a1c22..ec11619 100644
--- a/drivers/media/video/em28xx/em28xx-core.c
+++ b/drivers/media/video/em28xx/em28xx-core.c
@@ -126,7 +126,7 @@ u32 em28xx_request_buffers(struct em28xx
 	const size_t imagesize = PAGE_ALIGN(dev->frame_size);	/*needs to be page aligned cause the buffers can be mapped individually! */
 	void *buff = NULL;
 	u32 i;
-	em28xx_coredbg("requested %i buffers with size %i", count, imagesize);
+	em28xx_coredbg("requested %i buffers with size %zd", count, imagesize);
 	if (count > EM28XX_NUM_FRAMES)
 		count = EM28XX_NUM_FRAMES;
 
-- 
0.99.9.GIT

