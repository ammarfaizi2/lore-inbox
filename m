Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262724AbVCDBNl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262724AbVCDBNl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 20:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262815AbVCDAyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 19:54:00 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:23820 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262724AbVCDAti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 19:49:38 -0500
Date: Fri, 4 Mar 2005 01:49:32 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] unexport __print_symbol
Message-ID: <20050304004932.GZ4608@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't find any possible modular usage in the kernel.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-rc5-mm1-full/kernel/kallsyms.c.old	2005-03-04 00:49:34.000000000 +0100
+++ linux-2.6.11-rc5-mm1-full/kernel/kallsyms.c	2005-03-04 00:49:49.000000000 +0100
@@ -408,4 +408,3 @@
 }
 __initcall(kallsyms_init);
 
-EXPORT_SYMBOL(__print_symbol);

