Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264320AbTICXP3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 19:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264318AbTICXP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 19:15:29 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:48893 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264224AbTICXPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 19:15:23 -0400
Date: Thu, 4 Sep 2003 01:15:21 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: [2.6 patch] add help texts to two OSS drivers
Message-ID: <20030903231521.GK18025@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below adds the missing help texts for two OSS drivers (text 
taken from the 2.4 Configure.help).

cu
Adrian

--- linux-2.6.0-test4-mm5-modular-no-smp/sound/oss/Kconfig.old	2003-09-04 01:10:04.000000000 +0200
+++ linux-2.6.0-test4-mm5-modular-no-smp/sound/oss/Kconfig	2003-09-04 01:12:30.000000000 +0200
@@ -1145,10 +1145,18 @@
 config SOUND_FORTE
 	tristate "ForteMedia FM801 driver"
 	depends on SOUND_PRIME!=n && PCI
+	help
+	  Say Y or M if you want driver support for the ForteMedia FM801 PCI
+	  audio controller (Abit AU10, Genius Sound Maker, HP Workstation
+	  zx2000, and others).
 
 config SOUND_RME96XX
 	tristate "RME Hammerfall (RME96XX) support"
 	depends on SOUND_PRIME!=n && PCI
+	help
+	  Say Y or M if you have a Hammerfall or Hammerfall light
+	  multichannel card from RME. If you want to acess advanced
+	  features of the card, read Documentation/sound/rme96xx.
 
 config SOUND_AD1980
 	tristate "AD1980 front/back switch plugin"
