Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751384AbWDWL4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbWDWL4e (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 07:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbWDWL4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 07:56:34 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:5900 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751384AbWDWL4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 07:56:34 -0400
Date: Sun, 23 Apr 2006 13:56:32 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] fs/mpage.c: unexport mpage_writepage
Message-ID: <20060423115632.GN5010@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the unused EXPORT_SYMBOL(mpage_writepage).

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.17-rc1-mm3-full/fs/mpage.c.old	2006-04-23 13:44:13.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/fs/mpage.c	2006-04-23 13:44:25.000000000 +0200
@@ -830,4 +830,3 @@
 
 	return ret;
 }
-EXPORT_SYMBOL(mpage_writepage);

