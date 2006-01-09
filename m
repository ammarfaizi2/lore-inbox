Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbWAIVje@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWAIVje (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 16:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbWAIVjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 16:39:14 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:9488 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750725AbWAIViz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 16:38:55 -0500
Subject: [PATCH 08/11] frv: Use KERNELRELEASE
In-Reply-To: <20060109211157.GA14477@mars.ravnborg.org>
X-Mailer: gregkh_patchbomb-sam
Date: Mon, 9 Jan 2006 22:38:39 +0100
Message-Id: <11368427192440@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 arch/frv/boot/Makefile |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

63b794bfd898899cc8b6d4679d4fdc486606194b
diff --git a/arch/frv/boot/Makefile b/arch/frv/boot/Makefile
index d75e0d7..5dfc93f 100644
--- a/arch/frv/boot/Makefile
+++ b/arch/frv/boot/Makefile
@@ -57,10 +57,10 @@ initrd:
 # installation
 #
 install: $(CONFIGURE) Image
-	sh ./install.sh $(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION) Image $(TOPDIR)/System.map "$(INSTALL_PATH)"
+	sh ./install.sh $(KERNELRELEASE) Image $(TOPDIR)/System.map "$(INSTALL_PATH)"
 
 zinstall: $(CONFIGURE) zImage
-	sh ./install.sh $(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION) zImage $(TOPDIR)/System.map "$(INSTALL_PATH)"
+	sh ./install.sh $(KERNELRELEASE) zImage $(TOPDIR)/System.map "$(INSTALL_PATH)"
 
 #
 # miscellany
-- 
1.0.GIT

