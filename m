Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751275AbWIXWQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbWIXWQu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 18:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbWIXWQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 18:16:50 -0400
Received: (root@vger.kernel.org) by vger.kernel.org id S1751281AbWIXWQa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 18:16:30 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:17372 "EHLO pasmtpA.tele.dk")
	by vger.kernel.org with ESMTP id S932126AbWIXVNK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 17:13:10 -0400
From: sam@ravnborg.org
To: linux-kernel@vger.kernel.org
Cc: "Robert P. J. Day" <rpjday@mindspring.com>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 19/28] kbuild: update help in top level Makefile
Reply-To: sam@ravnborg.org
Date: Sun, 24 Sep 2006 23:18:15 +0200
Message-Id: <11591327061478-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <1159132706174-git-send-email-sam@ravnborg.org>
References: 20060924210827.GA26969@uranus.ravnborg.org <1159132704708-git-send-email-sam@ravnborg.org> <11591327042606-git-send-email-sam@ravnborg.org> <11591327042944-git-send-email-sam@ravnborg.org> <11591327041272-git-send-email-sam@ravnborg.org> <11591327041374-git-send-email-sam@ravnborg.org> <11591327041093-git-send-email-sam@ravnborg.org> <11591327053484-git-send-email-sam@ravnborg.org> <11591327051061-git-send-email-sam@ravnborg.org> <11591327053770-git-send-email-sam@ravnborg.org> <11591327051381-git-send-email-sam@ravnborg.org> <11591327054119-git-send-email-sam@ravnborg.org> <11591327051998-git-send-email-sam@ravnborg.org> <11591327051652-git-send-email-sam@ravnborg.org> <11591327053365-git-send-email-sam@ravnborg.org> <1159132705363-git-send-email-sam@ravnborg.org> <11591327063034-git-send-email-sam@ravnborg.org> <11591327061320-git-send-email-sam@ravnborg.org> <1159132706174-git-send-email-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert P. J. Day <rpjday@mindspring.com>

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 Makefile                 |    1 +
 scripts/kconfig/Makefile |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index fc67adc..0d4a4dc 100644
--- a/Makefile
+++ b/Makefile
@@ -1060,6 +1060,7 @@ help:
 	@echo  'Cleaning targets:'
 	@echo  '  clean		  - remove most generated files but keep the config'
 	@echo  '  mrproper	  - remove all generated files + config + various backup files'
+	@echo  '  distclean	  - mrproper + patch files'
 	@echo  ''
 	@echo  'Configuration targets:'
 	@$(MAKE) -f $(srctree)/scripts/kconfig/Makefile help
diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index e6499db..a90d3cc 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -74,6 +74,7 @@ help:
 	@echo  '  xconfig	  - Update current config utilising a QT based front-end'
 	@echo  '  gconfig	  - Update current config utilising a GTK based front-end'
 	@echo  '  oldconfig	  - Update current config utilising a provided .config as base'
+	@echo  '  silentoldconfig - Same as oldconfig, but quietly'
 	@echo  '  randconfig	  - New config with random answer to all options'
 	@echo  '  defconfig	  - New config with default answer to all options'
 	@echo  '  allmodconfig	  - New config selecting modules when possible'
-- 
1.4.1

