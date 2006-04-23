Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751388AbWDWMPd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbWDWMPd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 08:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbWDWMPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 08:15:33 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:17164 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751388AbWDWMPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 08:15:32 -0400
Date: Sun, 23 Apr 2006 14:15:31 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] fs/namei.c: unexport __user_walk
Message-ID: <20060423121531.GO5010@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the unused EXPORT_SYMBOL(__user_walk).

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.17-rc1-mm3-full/fs/namei.c.old	2006-04-23 13:57:07.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/fs/namei.c	2006-04-23 13:57:16.000000000 +0200
@@ -2689,7 +2689,6 @@
 	.put_link	= page_put_link,
 };
 
-EXPORT_SYMBOL(__user_walk);
 EXPORT_SYMBOL(__user_walk_fd);
 EXPORT_SYMBOL(follow_down);
 EXPORT_SYMBOL(follow_up);

