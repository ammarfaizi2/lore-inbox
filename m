Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263629AbTDIRNR (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 13:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263631AbTDIRNR (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 13:13:17 -0400
Received: from air-2.osdl.org ([65.172.181.6]:43926 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263629AbTDIRNQ (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 13:13:16 -0400
Date: Wed, 9 Apr 2003 10:24:23 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: torvalds@transmeta.com, vojtech@suse.cz
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] input subsys. typos
Message-Id: <20030409102423.0eff2a46.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Patch to 2.5.67.  Please apply.
Typos only.  No code changes.

--
~Randy


patch_name:	input-typos.patch
patch_version:	2003-04-09.09:39:06
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	correct typos only
product:	Linux
product_versions: 2.5.67
maintainer:	vojtech@suse.cz
diffstat:	=
 drivers/input/mouse/psmouse.c |    2 +-
 drivers/input/serio/i8042.c   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)


diff -Naur ./drivers/input/serio/i8042.c%FIXIT ./drivers/input/serio/i8042.c
--- ./drivers/input/serio/i8042.c%FIXIT	Mon Apr  7 11:10:55 2003
+++ ./drivers/input/serio/i8042.c	Wed Apr  9 09:38:50 2003
@@ -222,7 +222,7 @@
 
 /*
  * i8042_open() is called when a port is open by the higher layer.
- * It allocates the interrupt and enables in in the chip.
+ * It allocates the interrupt and enables it in the chip.
  */
 
 static int i8042_open(struct serio *port)
diff -Naur ./drivers/input/mouse/psmouse.c%FIXIT ./drivers/input/mouse/psmouse.c
--- ./drivers/input/mouse/psmouse.c%FIXIT	Mon Apr  7 11:11:02 2003
+++ ./drivers/input/mouse/psmouse.c	Tue Apr  8 09:23:44 2003
@@ -599,7 +599,7 @@
 }
 
 /*
- * psmouse_connect() is a callback form the serio module when
+ * psmouse_connect() is a callback from the serio module when
  * an unhandled serio port is found.
  */
 
