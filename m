Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261962AbVGJP6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261962AbVGJP6g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 11:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261963AbVGJP6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 11:58:36 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:39941 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261962AbVGJP6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 11:58:36 -0400
Date: Sun, 10 Jul 2005 17:58:31 +0200
From: Adrian Bunk <bunk@stusta.de>
To: jkmaline@cc.hut.fi, jgarzik@pobox.com
Cc: linux-net@vger.kernel.or, linux-kernel@vger.kernel.org, hostap@shmoo.com
Subject: [-mm patch] drivers/net/wireless/hostap/hostap.c: EXPORT_SYMTAB does nothing
Message-ID: <20050710155831.GN28243@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need to define something if it doesn't has any effect.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-rc2-mm1-full/drivers/net/wireless/hostap/hostap.c.old	2005-07-10 17:31:01.000000000 +0200
+++ linux-2.6.13-rc2-mm1-full/drivers/net/wireless/hostap/hostap.c	2005-07-10 17:33:01.000000000 +0200
@@ -12,10 +12,6 @@
  * more details.
  */
 
-#ifndef EXPORT_SYMTAB
-#define EXPORT_SYMTAB
-#endif
-
 #include <linux/config.h>
 #include <linux/version.h>
 #include <linux/module.h>
