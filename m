Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261243AbVCTSbh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbVCTSbh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 13:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbVCTSbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 13:31:34 -0500
Received: from ns3.dataphone.se ([212.37.0.170]:53479 "EHLO
	mail-slave.dataphone.se") by vger.kernel.org with ESMTP
	id S261243AbVCTSbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 13:31:33 -0500
From: Magnus Damm <damm@opensource.se>
To: linux-kernel@vger.kernel.org
Cc: Magnus Damm <damm@opensource.se>
Message-Id: <20050320180341.4056.34459.17402@clementine.local>
Subject: [PATCH] i8042: MODULE_PARM_DESC
Date: Sun, 20 Mar 2005 19:31:31 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For 2.6.11.x, already fixed in 2.6.12-rc1.

Replace duplicate "dumbkbd" with "noloop".

Signed-off-by: Magnus Damm <damm@opensource.se>

--- linux-2.6.11.4/drivers/input/serio/i8042.c	2005-03-16 10:56:16.000000000 +0100
+++ linux-2.6.11.4-i8042_parm_desc/drivers/input/serio/i8042.c	2005-03-20 17:49:02.329667144 +0100
@@ -52,7 +52,7 @@
 
 static unsigned int i8042_noloop;
 module_param_named(noloop, i8042_noloop, bool, 0);
-MODULE_PARM_DESC(dumbkbd, "Disable the AUX Loopback command while probing for the AUX port");
+MODULE_PARM_DESC(noloop, "Disable the AUX Loopback command while probing for the AUX port");
 
 #ifdef CONFIG_ACPI
 static int i8042_noacpi;
