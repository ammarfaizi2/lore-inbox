Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261402AbVDWEKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261402AbVDWEKp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 00:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261470AbVDWEKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 00:10:45 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:17924 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261402AbVDWEKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 00:10:41 -0400
Date: Sat, 23 Apr 2005 06:10:38 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] fs/super.c: unexport user_get_super
Message-ID: <20050423041038.GU4355@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't find any modular usage in the kernel.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc2-mm3-full/fs/super.c.old	2005-04-23 02:45:59.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/super.c	2005-04-23 02:46:07.000000000 +0200
@@ -467,8 +467,6 @@
 	return NULL;
 }
 
-EXPORT_SYMBOL(user_get_super);
-
 asmlinkage long sys_ustat(unsigned dev, struct ustat __user * ubuf)
 {
         struct super_block *s;

