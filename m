Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271791AbTGROIo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 10:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271763AbTGROIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 10:08:04 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:26245
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S271772AbTGROHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 10:07:25 -0400
Date: Fri, 18 Jul 2003 15:21:46 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307181421.h6IELkX8017780@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: xjack pcmcia needs .. pcmcia
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Taral)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test1/drivers/telephony/Kconfig linux-2.6.0-test1-ac2/drivers/telephony/Kconfig
--- linux-2.6.0-test1/drivers/telephony/Kconfig	2003-07-10 21:06:01.000000000 +0100
+++ linux-2.6.0-test1-ac2/drivers/telephony/Kconfig	2003-07-14 14:56:57.000000000 +0100
@@ -39,7 +39,7 @@
 
 config PHONE_IXJ_PCMCIA
 	tristate "QuickNet Internet LineJack/PhoneJack PCMCIA support"
-	depends on PHONE_IXJ
+	depends on PHONE_IXJ && PCMCIA
 	help
 	  Say Y here to configure in PCMCIA service support for the Quicknet
 	  cards manufactured by Quicknet Technologies, Inc.  This changes the
