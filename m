Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965167AbVKBSOm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965167AbVKBSOm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 13:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965171AbVKBSOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 13:14:42 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:12050 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965172AbVKBSOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 13:14:41 -0500
Date: Wed, 2 Nov 2005 19:14:39 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/base/power/runtime.c: #if 0 an unused function
Message-ID: <20051102181439.GC4272@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch #if 0's an unused global function.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.14-rc5-mm1-full/drivers/base/power/runtime.c.old	2005-11-02 18:35:52.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/base/power/runtime.c	2005-11-02 18:40:09.000000000 +0100
@@ -64,6 +64,7 @@
 }
 
 
+#if 0
 /**
  *	dpm_set_power_state - Update power_state field.
  *	@dev:	Device.
@@ -80,3 +81,4 @@
 	dev->power.power_state = state;
 	up(&dpm_sem);
 }
+#endif  /*  0  */

