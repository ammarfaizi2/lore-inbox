Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267378AbUHJAyC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267378AbUHJAyC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 20:54:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267373AbUHJAyC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 20:54:02 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:24516 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S267391AbUHJAxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 20:53:45 -0400
Date: Mon, 9 Aug 2004 17:53:44 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6] Remove spaces from PCI gameport pci_driver.name fields
Message-ID: <20040810005344.GA9039@plexity.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Plexity Networks
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Same reasoning as the rest...

Please apply,
~Deepak

Signed-off-by: Deepak Saxena <dsaxena@plexity.net>

===== drivers/input/gameport/cs461x.c 1.11 vs edited =====
--- 1.11/drivers/input/gameport/cs461x.c	Sun May  9 18:34:42 2004
+++ edited/drivers/input/gameport/cs461x.c	Mon Aug  9 17:50:26 2004
@@ -312,7 +312,7 @@
 }
 
 static struct pci_driver cs461x_pci_driver = {
-        .name =         "CS461x Gameport",
+        .name =         "CS461x_gameport",
         .id_table =     cs461x_pci_tbl,
         .probe =        cs461x_pci_probe,
         .remove =       __devexit_p(cs461x_pci_remove),
===== drivers/input/gameport/emu10k1-gp.c 1.13 vs edited =====
--- 1.13/drivers/input/gameport/emu10k1-gp.c	Sun May  9 18:34:42 2004
+++ edited/drivers/input/gameport/emu10k1-gp.c	Mon Aug  9 17:50:29 2004
@@ -109,7 +109,7 @@
 }
 
 static struct pci_driver emu_driver = {
-        .name =         "Emu10k1 Gameport",
+        .name =         "Emu10k1_gameport",
         .id_table =     emu_tbl,
         .probe =        emu_probe,
         .remove =       __devexit_p(emu_remove),
===== drivers/input/gameport/fm801-gp.c 1.9 vs edited =====
--- 1.9/drivers/input/gameport/fm801-gp.c	Sun May  9 18:34:42 2004
+++ edited/drivers/input/gameport/fm801-gp.c	Mon Aug  9 17:50:32 2004
@@ -137,7 +137,7 @@
 };
 
 static struct pci_driver fm801_gp_driver = {
-	.name =		"FM801 GP",
+	.name =		"FM801_gameport",
 	.id_table =	fm801_gp_id_table,
 	.probe =	fm801_gp_probe,
 	.remove =	__devexit_p(fm801_gp_remove),
===== drivers/input/gameport/vortex.c 1.10 vs edited =====
--- 1.10/drivers/input/gameport/vortex.c	Mon Jun  7 02:58:13 2004
+++ edited/drivers/input/gameport/vortex.c	Mon Aug  9 17:50:34 2004
@@ -166,7 +166,7 @@
  { 0 }};
 
 static struct pci_driver vortex_driver = {
-	.name =		"vortex",
+	.name =		"vortex_gameport",
 	.id_table =	vortex_id_table,
 	.probe =	vortex_probe,
 	.remove =	__devexit_p(vortex_remove),


-- 
Deepak Saxena - dsaxena at plexity dot net - http://www.plexity.net/

"Unlike me, many of you have accepted the situation of your imprisonment and
 will die here like rotten cabbages." - Number 6
