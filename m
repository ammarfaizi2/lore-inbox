Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267330AbUHWSz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267330AbUHWSz5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 14:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267326AbUHWSzB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 14:55:01 -0400
Received: from mail.kroah.org ([69.55.234.183]:14788 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267324AbUHWShJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:37:09 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <10932860893321@kroah.com>
Date: Mon, 23 Aug 2004 11:34:49 -0700
Message-Id: <10932860893645@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1807.56.46, 2004/08/10 16:30:39-07:00, dsaxena@plexity.net

[PATCH] Remove spaces from PCI gameport pci_driver.name fields

Signed-off-by: Deepak Saxena <dsaxena@plexity.net>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/input/gameport/cs461x.c     |    2 +-
 drivers/input/gameport/emu10k1-gp.c |    2 +-
 drivers/input/gameport/fm801-gp.c   |    2 +-
 drivers/input/gameport/vortex.c     |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)


diff -Nru a/drivers/input/gameport/cs461x.c b/drivers/input/gameport/cs461x.c
--- a/drivers/input/gameport/cs461x.c	2004-08-23 11:02:16 -07:00
+++ b/drivers/input/gameport/cs461x.c	2004-08-23 11:02:16 -07:00
@@ -312,7 +312,7 @@
 }
 
 static struct pci_driver cs461x_pci_driver = {
-        .name =         "CS461x Gameport",
+        .name =         "CS461x_gameport",
         .id_table =     cs461x_pci_tbl,
         .probe =        cs461x_pci_probe,
         .remove =       __devexit_p(cs461x_pci_remove),
diff -Nru a/drivers/input/gameport/emu10k1-gp.c b/drivers/input/gameport/emu10k1-gp.c
--- a/drivers/input/gameport/emu10k1-gp.c	2004-08-23 11:02:16 -07:00
+++ b/drivers/input/gameport/emu10k1-gp.c	2004-08-23 11:02:16 -07:00
@@ -109,7 +109,7 @@
 }
 
 static struct pci_driver emu_driver = {
-        .name =         "Emu10k1 Gameport",
+        .name =         "Emu10k1_gameport",
         .id_table =     emu_tbl,
         .probe =        emu_probe,
         .remove =       __devexit_p(emu_remove),
diff -Nru a/drivers/input/gameport/fm801-gp.c b/drivers/input/gameport/fm801-gp.c
--- a/drivers/input/gameport/fm801-gp.c	2004-08-23 11:02:16 -07:00
+++ b/drivers/input/gameport/fm801-gp.c	2004-08-23 11:02:16 -07:00
@@ -137,7 +137,7 @@
 };
 
 static struct pci_driver fm801_gp_driver = {
-	.name =		"FM801 GP",
+	.name =		"FM801_gameport",
 	.id_table =	fm801_gp_id_table,
 	.probe =	fm801_gp_probe,
 	.remove =	__devexit_p(fm801_gp_remove),
diff -Nru a/drivers/input/gameport/vortex.c b/drivers/input/gameport/vortex.c
--- a/drivers/input/gameport/vortex.c	2004-08-23 11:02:16 -07:00
+++ b/drivers/input/gameport/vortex.c	2004-08-23 11:02:16 -07:00
@@ -166,7 +166,7 @@
  { 0 }};
 
 static struct pci_driver vortex_driver = {
-	.name =		"vortex",
+	.name =		"vortex_gameport",
 	.id_table =	vortex_id_table,
 	.probe =	vortex_probe,
 	.remove =	__devexit_p(vortex_remove),

