Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261293AbULSOBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbULSOBQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 09:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbULSOBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 09:01:16 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:59913 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261293AbULSOBE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 09:01:04 -0500
Date: Sun, 19 Dec 2004 15:00:59 +0100
From: Adrian Bunk <bunk@stusta.de>
To: michael@mihu.de
Cc: kraxel@bytesex.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] saa7146_vv_ksyms.c: remove two unused EXPORT_SYMBOL_GPL's
Message-ID: <20041219140059.GS21288@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below removes two unused EXPORT_SYMBOL_GPL's.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc3-mm1-full/drivers/media/common/saa7146_vv_ksyms.c.old	2004-12-18 01:58:03.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/drivers/media/common/saa7146_vv_ksyms.c	2004-12-18 01:58:08.000000000 +0100
@@ -1,9 +1,6 @@
 #include <linux/module.h>
 #include <media/saa7146_vv.h>
 
-EXPORT_SYMBOL_GPL(saa7146_vbi_uops);
-EXPORT_SYMBOL_GPL(saa7146_video_uops);
-
 EXPORT_SYMBOL_GPL(saa7146_start_preview);
 EXPORT_SYMBOL_GPL(saa7146_stop_preview);
 

