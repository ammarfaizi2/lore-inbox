Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbWDRPG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbWDRPG1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 11:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbWDRPG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 11:06:27 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:51717 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932263AbWDRPGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 11:06:16 -0400
Date: Tue, 18 Apr 2006 17:06:15 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: markus.lidel@shadowconnect.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/message/i2o/iop.c: static inline functions mustn't be exported
Message-ID: <20060418150615.GH11582@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

static inline functions mustn't be exported.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 13 Apr 2006

--- linux-2.6.17-rc1-mm2-full/drivers/message/i2o/iop.c.old	2006-04-13 17:30:41.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/drivers/message/i2o/iop.c	2006-04-13 17:30:57.000000000 +0200
@@ -1243,7 +1243,6 @@
 EXPORT_SYMBOL(i2o_cntxt_list_get_ptr);
 #endif
 EXPORT_SYMBOL(i2o_msg_get_wait);
-EXPORT_SYMBOL(i2o_msg_nop);
 EXPORT_SYMBOL(i2o_find_iop);
 EXPORT_SYMBOL(i2o_iop_find_device);
 EXPORT_SYMBOL(i2o_event_register);

