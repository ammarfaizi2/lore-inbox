Return-Path: <linux-kernel-owner+w=401wt.eu-S1030446AbXAKNsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030446AbXAKNsu (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 08:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030447AbXAKNsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 08:48:50 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:4594 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1030446AbXAKNsu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 08:48:50 -0500
Date: Thu, 11 Jan 2007 14:48:54 +0100
From: Adrian Bunk <bunk@stusta.de>
To: airlied@linux.ie
Cc: dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] drivers/char/drm/drm_mm.c: remove unused exports
Message-ID: <20070111134854.GC20027@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes two unused exports.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 21 Nov 2006

--- linux-2.6.19-rc5-mm2/drivers/char/drm/drm_mm.c.old	2006-11-21 20:08:02.000000000 +0100
+++ linux-2.6.19-rc5-mm2/drivers/char/drm/drm_mm.c	2006-11-21 20:09:19.000000000 +0100
@@ -177,8 +177,6 @@
 	return 0;
 }
 
-EXPORT_SYMBOL(drm_mm_init);
-
 void drm_mm_takedown(drm_mm_t * mm)
 {
 	struct list_head *bnode = mm->root_node.fl_entry.next;
@@ -197,5 +195,3 @@
 
 	drm_free(entry, sizeof(*entry), DRM_MEM_MM);
 }
-
-EXPORT_SYMBOL(drm_mm_takedown);


