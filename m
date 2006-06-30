Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751233AbWF3Ldt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbWF3Ldt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 07:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751673AbWF3Lds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 07:33:48 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:17416 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750915AbWF3LdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 07:33:11 -0400
Date: Fri, 30 Jun 2006 13:33:09 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/namei.c: EXPORT_UNUSED_SYMBOL
Message-ID: <20060630113309.GU19712@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch marks an unused export as EXPORT_UNUSED_SYMBOL.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.17-mm4-full/fs/namei.c.old	2006-06-30 04:01:55.000000000 +0200
+++ linux-2.6.17-mm4-full/fs/namei.c	2006-06-30 04:02:47.000000000 +0200
@@ -2785,7 +2785,7 @@
 	.put_link	= page_put_link,
 };
 
-EXPORT_SYMBOL(__user_walk);
+EXPORT_UNUSED_SYMBOL(__user_walk);  /*  June 2006  */
 EXPORT_SYMBOL(__user_walk_fd);
 EXPORT_SYMBOL(follow_down);
 EXPORT_SYMBOL(follow_up);

