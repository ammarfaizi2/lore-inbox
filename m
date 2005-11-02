Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932160AbVKBBxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbVKBBxU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 20:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbVKBBxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 20:53:20 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:41737 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932148AbVKBBxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 20:53:19 -0500
Date: Wed, 2 Nov 2005 02:53:12 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jgarzik@pobox.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] update S2IO help text
Message-ID: <20051102015311.GE8009@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following updates to the S2IO help text:
- correct the patch to the README
- there is no information regarding compilation and installation of the
  driver in the README


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.14-rc5-mm1-modular-2.95/drivers/net/Kconfig.old	2005-11-02 02:46:21.000000000 +0100
+++ linux-2.6.14-rc5-mm1-modular-2.95/drivers/net/Kconfig	2005-11-02 02:50:13.000000000 +0100
@@ -2253,12 +2253,12 @@
 config S2IO
 	tristate "S2IO 10Gbe XFrame NIC"
 	depends on PCI
 	---help---
 	  This driver supports the 10Gbe XFrame NIC of S2IO. 
-	  For help regarding driver compilation, installation and 
-	  tuning please look into ~/drivers/net/s2io/README.txt.
+	  For help regarding driver tuning please look into
+	  <file:Documentation/networking/s2io.txt>.
 
 config S2IO_NAPI
 	bool "Use Rx Polling (NAPI) (EXPERIMENTAL)"
 	depends on S2IO && EXPERIMENTAL
 	help

