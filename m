Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbWDRWHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbWDRWHn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 18:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbWDRWHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 18:07:24 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:3338 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750744AbWDRWHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 18:07:21 -0400
Date: Wed, 19 Apr 2006 00:07:20 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: philb@gnu.org, tim@cyberelk.net, andrea@suse.de,
       linux-parport@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/parport/share.: unexport parport_get_port
Message-ID: <20060418220720.GQ11582@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the unused EXPORT_SYMBOL(parport_get_port).

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 5 Apr 2006

--- linux-2.6.17-rc1-mm1-full/drivers/parport/share.c.old	2006-04-05 17:12:05.000000000 +0200
+++ linux-2.6.17-rc1-mm1-full/drivers/parport/share.c	2006-04-05 17:12:42.000000000 +0200
@@ -1003,7 +1003,6 @@
 EXPORT_SYMBOL(parport_unregister_driver);
 EXPORT_SYMBOL(parport_register_device);
 EXPORT_SYMBOL(parport_unregister_device);
-EXPORT_SYMBOL(parport_get_port);
 EXPORT_SYMBOL(parport_put_port);
 EXPORT_SYMBOL(parport_find_number);
 EXPORT_SYMBOL(parport_find_base);

