Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262818AbVCDA4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262818AbVCDA4n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 19:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262853AbVCDAyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 19:54:54 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:23564 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262824AbVCDAtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 19:49:09 -0500
Date: Fri, 4 Mar 2005 01:49:03 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] panic_timeout
Message-ID: <20050304004903.GY4608@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't find any possible modular usage in the kernel.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-rc5-mm1-full/kernel/panic.c.old	2005-03-04 00:54:46.000000000 +0100
+++ linux-2.6.11-rc5-mm1-full/kernel/panic.c	2005-03-04 00:54:54.000000000 +0100
@@ -24,8 +24,6 @@
 int panic_on_oops;
 int tainted;
 
-EXPORT_SYMBOL(panic_timeout);
-
 struct notifier_block *panic_notifier_list;
 
 EXPORT_SYMBOL(panic_notifier_list);

