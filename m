Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263019AbTDRLDY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 07:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263020AbTDRLDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 07:03:23 -0400
Received: from yuzuki.cinet.co.jp ([61.197.228.219]:12162 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP id S263019AbTDRLDX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 07:03:23 -0400
Date: Fri, 18 Apr 2003 20:15:05 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5.67-ac2] ALSA config fix for PC98
Message-ID: <20030418111505.GA15464@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a trivial patch against 2.5.67-ac2.
Please apply.

Fix config menu for alsa sound driver for PC98.

Regards,
Osamu Tomita

diff -Nru linux-2.5.67-ac2/sound/isa/Kconfig linux-2.5.67-ac2/sound/isa/Kconfig
--- linux-2.5.67-ac2/sound/isa/Kconfig	2003-04-18 09:14:26.000000000 +0900
+++ linux-2.5.67-ac2/sound/isa/Kconfig	2003-04-18 10:14:44.000000000 +0900
@@ -41,7 +41,7 @@
 
 config SND_PC98_CS4232
 	tristate "NEC PC9800 CS4232 driver"
-	depends on SND && PC9800
+	depends on SND && X86_PC9800
 	help
 	  Say 'Y' or 'M' to include support for NEC PC-9801/PC-9821 on-board
 	  soundchip based on CS4232.
