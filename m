Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030385AbWCUQVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030385AbWCUQVy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 11:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030444AbWCUQVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 11:21:45 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:31244 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1030392AbWCUQVO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 11:21:14 -0500
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 28/46] kbuild: small update of allnoconfig description
In-Reply-To: <11429580561595-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email
Date: Tue, 21 Mar 2006 17:20:56 +0100
Message-Id: <11429580563217-git-send-email-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

'allnoconfig' is described by 'make help' as a "minimal config", that's not
strictly correct. To be pedantic, a minimal config would be one where
EMBEDDED was set to Y and most things therein disabled etc. Simply
answering 'no' to all options does not give a minimal config.
A better description of allnoconfig is that it answers all options with 'no'.

This patch updates the description.

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 scripts/kconfig/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

e11f04962cee8f7fb0dc14983a7a461ade8f71c3
diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index 5760e05..5280945 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -78,7 +78,7 @@ help:
 	@echo  '  defconfig	  - New config with default answer to all options'
 	@echo  '  allmodconfig	  - New config selecting modules when possible'
 	@echo  '  allyesconfig	  - New config where all options are accepted with yes'
-	@echo  '  allnoconfig	  - New minimal config'
+	@echo  '  allnoconfig	  - New config where all options are answered with no'
 
 # ===========================================================================
 # Shared Makefile for the various kconfig executables:
-- 
1.0.GIT


