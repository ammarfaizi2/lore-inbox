Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266864AbUHXAgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266864AbUHXAgi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 20:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268187AbUHXAep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 20:34:45 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:51705 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S268138AbUHXAcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 20:32:36 -0400
Date: Tue, 24 Aug 2004 02:32:29 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Alex deVries <alex@onefishtwo.ca>
Subject: [2.6 patch] update your email address in the kernel
Message-ID: <20040824003229.GA7019@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below replaces all occurences of two bouncing email addresses   
of Alex deVries in the kernel with his current address.

It's already ACK'ed by Alex deVries.


diffstat output:
 CREDITS                       |    2 +-
 arch/parisc/kernel/hardware.c |    2 +-
 drivers/input/serio/gscps2.c  |    2 +-
 drivers/parisc/lasi.c         |    2 +-
 drivers/parisc/superio.c      |    2 +-
 sound/oss/harmony.c           |    4 ++--
 6 files changed, 7 insertions(+), 7 deletions(-)


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.8.1-mm4-full/CREDITS.old	2004-08-23 04:01:53.000000000 +0200
+++ linux-2.6.8.1-mm4-full/CREDITS	2004-08-23 04:02:32.000000000 +0200
@@ -754,7 +754,7 @@
 D: HTB qdisc and random networking hacks
 
 N: Alex deVries
-E: adevries@thepuffingroup.com
+E: alex@onefishtwo.ca
 D: Various SGI parts, bits of HAL2 and Newport, PA-RISC Linux.
 S: 41.5 William Street
 S: Ottawa, Ontario
--- linux-2.6.8.1-mm4-full/drivers/parisc/superio.c.old	2004-08-23 04:01:54.000000000 +0200
+++ linux-2.6.8.1-mm4-full/drivers/parisc/superio.c	2004-08-23 04:02:45.000000000 +0200
@@ -8,7 +8,7 @@
  *	(C) Copyright 2000 Linuxcare, Inc.
  * 	(C) Copyright 2000 Linuxcare Canada, Inc.
  *	(C) Copyright 2000 Martin K. Petersen <mkp@linuxcare.com>
- * 	(C) Copyright 2000 Alex deVries <alex@linuxcare.com>
+ * 	(C) Copyright 2000 Alex deVries <alex@onefishtwo.ca>
  *      (C) Copyright 2001 John Marvin <jsm fc hp com>
  *      (C) Copyright 2003 Grant Grundler <grundler parisc-linux org>
  *
--- linux-2.6.8.1-mm4-full/sound/oss/harmony.c.old	2004-08-23 04:01:54.000000000 +0200
+++ linux-2.6.8.1-mm4-full/sound/oss/harmony.c	2004-08-23 04:03:00.000000000 +0200
@@ -8,7 +8,7 @@
 	On older 715 machines you'll find the technically identical chip 
 	called 'Vivace'. Both Harmony and Vicace are supported by this driver.
 
-	Copyright 2000 (c) Linuxcare Canada, Alex deVries <alex@linuxcare.com>
+	Copyright 2000 (c) Linuxcare Canada, Alex deVries <alex@onefishtwo.ca>
 	Copyright 2000-2003 (c) Helge Deller <deller@gmx.de>
 	Copyright 2001 (c) Matthieu Delahaye <delahaym@esiee.fr>
 	Copyright 2001 (c) Jean-Christophe Vaugeois <vaugeoij@esiee.fr>
@@ -1293,7 +1293,7 @@
 }
 
 
-MODULE_AUTHOR("Alex DeVries <alex@linuxcare.com>");
+MODULE_AUTHOR("Alex DeVries <alex@onefishtwo.ca>");
 MODULE_DESCRIPTION("Harmony sound driver");
 MODULE_LICENSE("GPL");
 
--- linux-2.6.8.1-mm4-full/arch/parisc/kernel/hardware.c.old	2004-08-23 04:01:54.000000000 +0200
+++ linux-2.6.8.1-mm4-full/arch/parisc/kernel/hardware.c	2004-08-23 04:03:10.000000000 +0200
@@ -7,7 +7,7 @@
  *    Reference Specification", March 7, 1999, version 0.96.  This
  *    is available at http://parisc-linux.org/documentation/
  *
- *    Copyright 1999 by Alex deVries <adevries@thepuffingroup.com>
+ *    Copyright 1999 by Alex deVries <alex@onefishtwo.ca>
  *    and copyright 1999 The Puffin Group Inc.
  *
  *    This program is free software; you can redistribute it and/or modify
--- linux-2.6.8.1-mm4-full/drivers/input/serio/gscps2.c.old	2004-08-23 04:01:54.000000000 +0200
+++ linux-2.6.8.1-mm4-full/drivers/input/serio/gscps2.c	2004-08-23 04:03:19.000000000 +0200
@@ -6,7 +6,7 @@
  * Copyright (c) 2002 Thibaut Varene <varenet@esiee.fr>
  *
  * Pieces of code based on linux-2.4's hp_mouse.c & hp_keyb.c
- * 	Copyright (c) 1999 Alex deVries <adevries@thepuffingroup.com>
+ * 	Copyright (c) 1999 Alex deVries <alex@onefishtwo.ca>
  *	Copyright (c) 1999-2000 Philipp Rumpf <prumpf@tux.org>
  *	Copyright (c) 2000 Xavier Debacker <debackex@esiee.fr>
  *	Copyright (c) 2000-2001 Thomas Marteau <marteaut@esiee.fr>
--- linux-2.6.8.1-mm4-full/drivers/parisc/lasi.c.old	2004-08-23 04:01:54.000000000 +0200
+++ linux-2.6.8.1-mm4-full/drivers/parisc/lasi.c	2004-08-23 04:03:28.000000000 +0200
@@ -11,7 +11,7 @@
  *      (at your option) any later version.
  *
  *	by Alan Cox <alan@redhat.com> and 
- * 	   Alex deVries <adevries@thepuffingroup.com> 
+ * 	   Alex deVries <alex@onefishtwo.ca> 
  */
 
 #include <linux/errno.h>

