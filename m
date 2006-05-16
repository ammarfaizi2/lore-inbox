Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932323AbWEPRqG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbWEPRqG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 13:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbWEPRof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 13:44:35 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:4616 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932331AbWEPRoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 13:44:17 -0400
Date: Tue, 16 May 2006 19:44:15 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] fs/mpage.c: unexport mpage_writepage
Message-ID: <20060516174415.GJ10077@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the unused EXPORT_SYMBOL(mpage_writepage).

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 1 May 2006
- 23 Apr 2006

--- linux-2.6.17-rc1-mm3-full/fs/mpage.c.old	2006-04-23 13:44:13.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/fs/mpage.c	2006-04-23 13:44:25.000000000 +0200
@@ -830,4 +830,3 @@
 
 	return ret;
 }
-EXPORT_SYMBOL(mpage_writepage);

