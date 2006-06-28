Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751479AbWF1RDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbWF1RDO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 13:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbWF1Q7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 12:59:23 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:42244 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751447AbWF1QzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 12:55:03 -0400
Date: Wed, 28 Jun 2006 18:55:02 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] kernel/sysctl.c: unexport proc_dointvec_userhz_jiffies
Message-ID: <20060628165502.GW13915@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes an unused EXPORT_SYMBOL.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

@Andrew:
If anyone is considered maintainer of this code, please tell me who it 
is so that I can send this patch to him instead of you.

This patch was already sent on:
- 22 Jun 2006
- 16 May 2006
- 1 May 2006
- 18 Apr 2006
- 11 Apr 2006

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


