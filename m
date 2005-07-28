Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262436AbVG1WIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262436AbVG1WIK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 18:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261565AbVG1WF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 18:05:28 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:62473 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261536AbVG1WEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 18:04:04 -0400
Date: Fri, 29 Jul 2005 00:04:02 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: jkmaline@cc.hut.fi, jgarzik@pobox.com, linux-net@vger.kernel.or,
       linux-kernel@vger.kernel.org, hostap@shmoo.com
Subject: [-mm patch] drivers/net/wireless/hostap/hostap.c: EXPORT_SYMTAB does nothing
Message-ID: <20050728220402.GF4790@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need to define something if it doesn't has any effect.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 10 Jul 2005

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
