Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271766AbTGROBp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 10:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271758AbTGROBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 10:01:12 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:17797
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S271754AbTGRN7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 09:59:38 -0400
Date: Fri, 18 Jul 2003 15:13:58 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307181413.h6IEDwjp017714@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: clarify AXNET kconfig as per 2.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test1/drivers/net/pcmcia/Kconfig linux-2.6.0-test1-ac2/drivers/net/pcmcia/Kconfig
--- linux-2.6.0-test1/drivers/net/pcmcia/Kconfig	2003-07-10 21:12:50.000000000 +0100
+++ linux-2.6.0-test1-ac2/drivers/net/pcmcia/Kconfig	2003-07-15 18:16:13.000000000 +0100
@@ -113,7 +113,7 @@
 	  If unsure, say N.
 
 config PCMCIA_AXNET
-	tristate "broken NS8390-cards support"
+	tristate "Asix AX88190 PCMCIA support"
 	depends on NET_PCMCIA && PCMCIA
 	---help---
 	  Say Y here if you intend to attach an Asix AX88190-based PCMCIA
