Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262854AbVCDBSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262854AbVCDBSb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 20:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbVCDAxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 19:53:48 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:24332 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262815AbVCDAuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 19:50:05 -0500
Date: Fri, 4 Mar 2005 01:50:01 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] unexport uts_sem
Message-ID: <20050304005001.GA4608@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't find any possible modular usage in the kernel.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-rc5-mm1-full/kernel/sys.c.old	2005-03-04 01:19:18.000000000 +0100
+++ linux-2.6.11-rc5-mm1-full/kernel/sys.c	2005-03-04 01:19:29.000000000 +0100
@@ -1382,8 +1382,6 @@
 
 DECLARE_RWSEM(uts_sem);
 
-EXPORT_SYMBOL(uts_sem);
-
 asmlinkage long sys_newuname(struct new_utsname __user * name)
 {
 	int errno = 0;

