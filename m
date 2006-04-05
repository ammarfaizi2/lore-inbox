Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751266AbWDEQh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbWDEQh3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 12:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbWDEQh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 12:37:29 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:35082 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751266AbWDEQh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 12:37:28 -0400
Date: Wed, 5 Apr 2006 18:37:27 +0200
From: Adrian Bunk <bunk@stusta.de>
To: philb@gnu.org, tim@cyberelk.net, andrea@suse.de
Cc: linux-parport@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/parport/share.: unexport parport_get_port
Message-ID: <20060405163727.GH8673@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the unused EXPORT_SYMBOL(parport_get_port).

Signed-off-by: Adrian Bunk <bunk@stusta.de>

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

