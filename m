Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbWDMQWW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbWDMQWW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 12:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932079AbWDMQWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 12:22:22 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:63248 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932081AbWDMQWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 12:22:21 -0400
Date: Thu, 13 Apr 2006 18:22:19 +0200
From: Adrian Bunk <bunk@stusta.de>
To: markus.lidel@shadowconnect.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/message/i2o/iop.c: static inline functions mustn't be exported
Message-ID: <20060413162219.GC4162@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

static inline functions mustn't be exported.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

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

