Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272774AbTHKQOG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 12:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269451AbTHKQC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 12:02:26 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:15654 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S272780AbTHKP7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 11:59:42 -0400
To: torvalds@osdl.org
From: davej@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] c99 initiliasers for bttv (2)
Message-Id: <E19mF4Y-0005Ej-00@tetrachloride>
Date: Mon, 11 Aug 2003 16:59:02 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/media/video/bttv-driver.c linux-2.5/drivers/media/video/bttv-driver.c
--- bk-linus/drivers/media/video/bttv-driver.c	2003-08-07 19:45:39.000000000 +0100
+++ linux-2.5/drivers/media/video/bttv-driver.c	2003-08-07 22:20:17.000000000 +0100
@@ -2873,8 +2873,8 @@ static struct file_operations bttv_fops 
 static struct video_device bttv_video_template =
 {
 	.name     = "UNSET",
-	type:     VID_TYPE_CAPTURE|VID_TYPE_TUNER|VID_TYPE_OVERLAY|
-	          VID_TYPE_CLIPPING|VID_TYPE_SCALES,
+	.type     = VID_TYPE_CAPTURE|VID_TYPE_TUNER|VID_TYPE_OVERLAY|
+	            VID_TYPE_CLIPPING|VID_TYPE_SCALES,
 	.hardware = VID_HARDWARE_BT848,
 	.fops     = &bttv_fops,
 	.minor    = -1,
