Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161018AbWBYQBw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161018AbWBYQBw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 11:01:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161020AbWBYQBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 11:01:52 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:57862 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161018AbWBYQBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 11:01:52 -0500
Date: Sat, 25 Feb 2006 17:01:50 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] make UNIX a bool
Message-ID: <20060225160150.GX3674@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_UNIX=m doesn't make much sense.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 20 Feb 2006

--- linux-2.6.16-rc4-mm1-full/net/unix/Kconfig.old	2006-02-20 14:40:19.000000000 +0100
+++ linux-2.6.16-rc4-mm1-full/net/unix/Kconfig	2006-02-20 14:40:27.000000000 +0100
@@ -3,7 +3,7 @@
 #
 
 config UNIX
-	tristate "Unix domain sockets"
+	bool "Unix domain sockets"
 	---help---
 	  If you say Y here, you will include support for Unix domain sockets;
 	  sockets are the standard Unix mechanism for establishing and

