Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161019AbWAGTct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161019AbWAGTct (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 14:32:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161024AbWAGTcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 14:32:48 -0500
Received: from smtp109.sbc.mail.re2.yahoo.com ([68.142.229.96]:60074 "HELO
	smtp109.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1161019AbWAGTcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 14:32:46 -0500
Message-Id: <20060107172100.671000000.dtor_core@ameritech.net>
References: <20060107171559.593824000.dtor_core@ameritech.net>
Date: Sat, 07 Jan 2006 12:16:09 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 10/24] Add help entry for FM801 gameport driver to Kconfig
Content-Disposition: inline; filename=gameport-fm801-help.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: add help entry for FM801 gameport driver to Kconfig

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/gameport/Kconfig |    7 +++++++
 1 files changed, 7 insertions(+)

Index: work/drivers/input/gameport/Kconfig
===================================================================
--- work.orig/drivers/input/gameport/Kconfig
+++ work/drivers/input/gameport/Kconfig
@@ -52,5 +52,12 @@ config GAMEPORT_EMU10K1
 config GAMEPORT_FM801
 	tristate "ForteMedia FM801 gameport support"
 	depends on PCI
+	help
+	  Say Y here if you have ForteMedia FM801 PCI audio controller
+	  (Abit AU10, Genius Sound Maker, HP Workstation zx2000,
+	  and others), and want to use its gameport.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called fm801-gp.
 
 endif

