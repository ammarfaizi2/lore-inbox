Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267653AbUIJSg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267653AbUIJSg6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 14:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267748AbUIJSg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 14:36:58 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:9882 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S267653AbUIJSg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 14:36:56 -0400
Subject: [patch 1/1] UML: remove commented old code in Kconfig
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Fri, 10 Sep 2004 19:14:00 +0200
Message-Id: <20040910171400.8CF87C744@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Drop a config option which has disappeared from all archs. Btw, this shouldn't
be in the UML-specific part, but since we cannot include generic Kconfigs to
avoid problem with hardware-related configs, it's duplicated for now.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.9-current-paolo/arch/um/Kconfig_char |    5 -----
 1 files changed, 5 deletions(-)

diff -puN arch/um/Kconfig_char~remove-commented-old-code arch/um/Kconfig_char
--- linux-2.6.9-current/arch/um/Kconfig_char~remove-commented-old-code	2004-09-10 19:11:24.388299224 +0200
+++ linux-2.6.9-current-paolo/arch/um/Kconfig_char	2004-09-10 19:11:24.390298920 +0200
@@ -158,11 +158,6 @@ config LEGACY_PTY_COUNT
 	  When not in use, each legacy PTY occupies 12 bytes on 32-bit
 	  architectures and 24 bytes on 64-bit architectures.
 
-#config UNIX98_PTY_COUNT
-#	int "Maximum number of Unix98 PTYs in use (0-2048)"
-#	depends on UNIX98_PTYS
-#	default "256"
-
 config WATCHDOG
 	bool "Watchdog Timer Support"
 
_
