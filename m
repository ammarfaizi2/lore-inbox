Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272355AbTG1ACX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 20:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272334AbTG1ABz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:01:55 -0400
Received: from zeus.kernel.org ([204.152.189.113]:31477 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272925AbTG0XBb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 19:01:31 -0400
Date: Sun, 27 Jul 2003 20:56:14 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307271956.h6RJuEdQ029533@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: remove a dead EXPORT_NO_SYMBOLS
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(R Krishnakumar)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/arch/cris/arch-v10/drivers/pcf8563.c linux-2.6.0-test2-ac1/arch/cris/arch-v10/drivers/pcf8563.c
--- linux-2.6.0-test2/arch/cris/arch-v10/drivers/pcf8563.c	2003-07-10 21:07:34.000000000 +0100
+++ linux-2.6.0-test2-ac1/arch/cris/arch-v10/drivers/pcf8563.c	2003-07-23 15:38:45.000000000 +0100
@@ -282,6 +282,5 @@
 	return 0;
 }
 
-EXPORT_NO_SYMBOLS;
 module_init(pcf8563_init);
 module_exit(pcf8563_exit);
