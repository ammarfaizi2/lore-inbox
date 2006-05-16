Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932449AbWEPRtc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449AbWEPRtc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 13:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbWEPRoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 13:44:34 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:5128 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932343AbWEPRoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 13:44:19 -0400
Date: Tue, 16 May 2006 19:44:17 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] fs/namei.c: unexport __user_walk
Message-ID: <20060516174417.GK10077@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the unused EXPORT_SYMBOL(__user_walk).

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 1 May 2006
- 23 Apr 2006

--- linux-2.6.17-rc1-mm3-full/fs/namei.c.old	2006-04-23 13:57:07.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/fs/namei.c	2006-04-23 13:57:16.000000000 +0200
@@ -2689,7 +2689,6 @@
 	.put_link	= page_put_link,
 };
 
-EXPORT_SYMBOL(__user_walk);
 EXPORT_SYMBOL(__user_walk_fd);
 EXPORT_SYMBOL(follow_down);
 EXPORT_SYMBOL(follow_up);

