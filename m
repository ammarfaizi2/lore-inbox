Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271768AbTGRObt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 10:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271778AbTGROA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 10:00:57 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:19333
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S271761AbTGROA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 10:00:26 -0400
Date: Fri, 18 Jul 2003 15:14:46 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307181414.h6IEEksx017726@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: re-enable seq8005
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test1/drivers/net/Kconfig linux-2.6.0-test1-ac2/drivers/net/Kconfig
--- linux-2.6.0-test1/drivers/net/Kconfig	2003-07-10 21:13:37.000000000 +0100
+++ linux-2.6.0-test1-ac2/drivers/net/Kconfig	2003-07-15 17:32:03.000000000 +0100
@@ -1153,7 +1153,7 @@
 
 config SEEQ8005
 	tristate "SEEQ8005 support (EXPERIMENTAL)"
-	depends on NET_ISA && OBSOLETE && EXPERIMENTAL
+	depends on NET_ISA && EXPERIMENTAL
 	help
 	  This is a driver for the SEEQ 8005 network (Ethernet) card.  If this
 	  is for you, read the Ethernet-HOWTO, available from
