Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161060AbWBNO6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161060AbWBNO6R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 09:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161061AbWBNO6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 09:58:17 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:5139 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161060AbWBNO6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 09:58:16 -0500
Date: Tue, 14 Feb 2006 15:58:15 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: [-mm patch] Makefile: remove a tab from an empty line
Message-ID: <20060214145815.GF10701@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Emacs warns if an otherwise empty line starts with a tab.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 8 Feb 2006
- 3 Feb 2006

--- linux-2.6.16-rc1-mm5-full/Makefile.old	2006-02-03 12:46:09.000000000 +0100
+++ linux-2.6.16-rc1-mm5-full/Makefile	2006-02-03 12:46:31.000000000 +0100
@@ -1122,7 +1122,7 @@
 
 .PHONY: modules_install
 modules_install: _emodinst_ _emodinst_post
-	
+
 install-dir := $(if $(INSTALL_MOD_DIR),$(INSTALL_MOD_DIR),extra)	
 .PHONY: _emodinst_
 _emodinst_:

