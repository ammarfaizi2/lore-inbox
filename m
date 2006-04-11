Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751220AbWDKDvZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbWDKDvZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 23:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbWDKDvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 23:51:19 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:29444 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751222AbWDKDvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 23:51:04 -0400
Date: Tue, 11 Apr 2006 05:51:03 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] kernel/sysctl.c: unexport
Message-ID: <20060411035103.GE3190@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

proc_dointvec_userhz_jiffies
Reply-To: 

This patch removes an unused EXPORT_SYMBOL.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.17-rc1-mm2-full/kernel/sysctl.c.old	2006-04-11 01:25:38.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/kernel/sysctl.c	2006-04-11 01:26:01.000000000 +0200
@@ -2532,7 +2532,6 @@
 EXPORT_SYMBOL(proc_dointvec);
 EXPORT_SYMBOL(proc_dointvec_jiffies);
 EXPORT_SYMBOL(proc_dointvec_minmax);
-EXPORT_SYMBOL(proc_dointvec_userhz_jiffies);
 EXPORT_SYMBOL(proc_dointvec_ms_jiffies);
 EXPORT_SYMBOL(proc_dostring);
 EXPORT_SYMBOL(proc_doulongvec_minmax);

