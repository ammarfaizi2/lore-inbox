Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266810AbUG1Hjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266810AbUG1Hjn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 03:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266820AbUG1Hjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 03:39:42 -0400
Received: from ozlabs.org ([203.10.76.45]:11402 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266810AbUG1HLu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 03:11:50 -0400
Date: Wed, 28 Jul 2004 17:01:09 +1000
From: David Gibson <hermes@gibson.dropbear.id.au>
To: Jeff Garzik <jgarzik@pobox.com>, Francois Romieu <romieu@fr.zoreil.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>, jt@hpl.hp.com,
       Dan Williams <dcbw@redhat.com>, Pavel Roskin <proski@gnu.org>,
       Orinoco Development List <orinoco-devel@lists.sourceforge.net>
Subject: [15/15] orinoco merge preliminaries - update authorship information
Message-ID: <20040728070109.GR16908@zax>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Francois Romieu <romieu@fr.zoreil.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	jt@hpl.hp.com, Dan Williams <dcbw@redhat.com>,
	Pavel Roskin <proski@gnu.org>,
	Orinoco Development List <orinoco-devel@lists.sourceforge.net>
References: <20040728065526.GH16908@zax> <20040728065550.GI16908@zax> <20040728065659.GJ16908@zax> <20040728065725.GK16908@zax> <20040728065800.GL16908@zax> <20040728065827.GM16908@zax> <20040728065913.GN16908@zax> <20040728065953.GO16908@zax> <20040728070018.GP16908@zax> <20040728070041.GQ16908@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040728070041.GQ16908@zax>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update copyright messages, module meta-information, banner comments
and the MAINTAINERS file to better reflect the current
authorship/maintainership status.  In particular puts Pavel Roskin as
the most prominently displayed maintainer, since he has done nearly
all non-trivial work on the driver for a year or more.

Signed-off-by: David Gibson <hermes@gibson.dropbear.id.au>

Index: working-2.6/drivers/net/wireless/hermes.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/hermes.c	2004-07-28 15:05:54.285393200 +1000
+++ working-2.6/drivers/net/wireless/hermes.c	2004-07-28 15:05:55.308237704 +1000
@@ -13,8 +13,8 @@
  * (wvlan_hcf.c) library, and the NetBSD wireless driver (in no
  * particular order).
  *
- * Copyright (C) 2000, David Gibson, Linuxcare Australia <hermes@gibson.dropbear.id.au>
- * Copyright (C) 2001, David Gibson, IBM <hermes@gibson.dropbear.id.au>
+ * Copyright (C) 2000, David Gibson, Linuxcare Australia.
+ * (C) Copyright David Gibson, IBM Corp. 2001-2003.
  * 
  * The contents of this file are subject to the Mozilla Public License
  * Version 1.1 (the "License"); you may not use this file except in
@@ -53,7 +53,8 @@
 #include "hermes.h"
 
 MODULE_DESCRIPTION("Low-level driver helper for Lucent Hermes chipset and Prism II HFA384x wireless MAC controller");
-MODULE_AUTHOR("David Gibson <hermes@gibson.dropbear.id.au>");
+MODULE_AUTHOR("Pavel Roskin <proski@gnu.org>"
+	" & David Gibson <hermes@gibson.dropbear.id.au>");
 MODULE_LICENSE("Dual MPL/GPL");
 
 /* These are maximum timeouts. Most often, card wil react much faster */
Index: working-2.6/drivers/net/wireless/orinoco.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco.c	2004-07-28 15:05:54.296391528 +1000
+++ working-2.6/drivers/net/wireless/orinoco.c	2004-07-28 15:05:55.347231776 +1000
@@ -1,18 +1,23 @@
-/* orinoco.c 0.13e	- (formerly known as dldwd_cs.c and orinoco_cs.c)
+/* orinoco.c - (formerly known as dldwd_cs.c and orinoco_cs.c)
  *
  * A driver for Hermes or Prism 2 chipset based PCMCIA wireless
  * adaptors, with Lucent/Agere, Intersil or Symbol firmware.
  *
- * Copyright (C) 2000 David Gibson, Linuxcare Australia <hermes AT gibson.dropbear.id.au>
+ * Current maintainers (as of 29 September 2003) are:
+ * 	Pavel Roskin <proski AT gnu.org>
+ * and	David Gibson <hermes AT gibson.dropbear.id.au>
+ *
+ * (C) Copyright David Gibson, IBM Corporation 2001-2003.
+ * Copyright (C) 2000 David Gibson, Linuxcare Australia.
  *	With some help from :
- * Copyright (C) 2001 Jean Tourrilhes, HP Labs <jt AT hpl.hp.com>
- * Copyright (C) 2001 Benjamin Herrenschmidt <benh AT kernel.crashing.org>
+ * Copyright (C) 2001 Jean Tourrilhes, HP Labs
+ * Copyright (C) 2001 Benjamin Herrenschmidt
  *
  * Based on dummy_cs.c 1.27 2000/06/12 21:27:25
  *
  * Portions based on wvlan_cs.c 1.0.6, Copyright Andreas Neuhaus <andy
  * AT fasta.fh-dortmund.de>
- * http://www.fasta.fh-dortmund.de/users/andy/wvlan/
+ *      http://www.stud.fh-dortmund.de/~andy/wvlan/
  *
  * The contents of this file are subject to the Mozilla Public License
  * Version 1.1 (the "License"); you may not use this file except in
@@ -449,7 +454,7 @@
 /* Module information                                               */
 /********************************************************************/
 
-MODULE_AUTHOR("David Gibson <hermes@gibson.dropbear.id.au>");
+MODULE_AUTHOR("Pavel Roskin <proski@gnu.org> & David Gibson <hermes@gibson.dropbear.id.au>");
 MODULE_DESCRIPTION("Driver for Lucent Orinoco, Prism II based and similar wireless cards");
 MODULE_LICENSE("Dual MPL/GPL");
 
@@ -4182,7 +4187,8 @@
 /* Can't be declared "const" or the whole __initdata section will
  * become const */
 static char version[] __initdata = DRIVER_NAME " " DRIVER_VERSION
-	" (David Gibson <hermes@gibson.dropbear.id.au> and others)";
+	" (David Gibson <hermes@gibson.dropbear.id.au>, "
+	"Pavel Roskin <proski@gnu.org>, et al)";
 
 static int __init init_orinoco(void)
 {
Index: working-2.6/drivers/net/wireless/orinoco_pci.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco_pci.c	2004-07-28 15:05:52.559655552 +1000
+++ working-2.6/drivers/net/wireless/orinoco_pci.c	2004-07-28 15:05:55.349231472 +1000
@@ -1,10 +1,14 @@
-/* orinoco_pci.c 0.13e
+/* orinoco_pci.c
  * 
  * Driver for Prism II devices that have a direct PCI interface
  * (i.e., not in a Pcmcia or PLX bridge)
  *
  * Specifically here we're talking about the Linksys WMP11
  *
+ * Current maintainers (as of 29 September 2003) are:
+ * 	Pavel Roskin <proski AT gnu.org>
+ * and	David Gibson <hermes AT gibson.dropbear.id.au>
+ *
  * Some of this code is borrowed from orinoco_plx.c
  *	Copyright (C) 2001 Daniel Barlow <dan AT telent.net>
  * Some of this code is "inspired" by linux-wlan-ng-0.1.10, but nothing
@@ -13,7 +17,7 @@
  * This file originally written by:
  *	Copyright (C) 2001 Jean Tourrilhes <jt AT hpl.hp.com>
  * And is now maintained by:
- *	Copyright (C) 2002 David Gibson, IBM Corporation <herme AT gibson.dropbear.id.au>
+ *	(C) Copyright David Gibson, IBM Corp. 2002-2003.
  *
  * The contents of this file are subject to the Mozilla Public License
  * Version 1.1 (the "License"); you may not use this file except in
@@ -379,8 +383,10 @@
 };
 
 static char version[] __initdata = DRIVER_NAME " " DRIVER_VERSION
-	" (David Gibson <hermes@gibson.dropbear.id.au> & Jean Tourrilhes <jt@hpl.hp.com>)";
-MODULE_AUTHOR("David Gibson <hermes@gibson.dropbear.id.au>");
+	" (Pavel Roskin <proski@gnu.org>,"
+	" David Gibson <hermes@gibson.dropbear.id.au> &"
+	" Jean Tourrilhes <jt@hpl.hp.com>)";
+MODULE_AUTHOR("Pavel Roskin <proski@gnu.org> & David Gibson <hermes@gibson.dropbear.id.au>");
 MODULE_DESCRIPTION("Driver for wireless LAN cards using direct PCI interface");
 MODULE_LICENSE("Dual MPL/GPL");
 
Index: working-2.6/drivers/net/wireless/hermes.h
===================================================================
--- working-2.6.orig/drivers/net/wireless/hermes.h	2004-07-28 15:05:54.288392744 +1000
+++ working-2.6/drivers/net/wireless/hermes.h	2004-07-28 15:05:55.351231168 +1000
@@ -12,7 +12,8 @@
  * project, the Linux wvlan_cs driver, Lucent's HCF-Light
  * (wvlan_hcf.c) library, and the NetBSD wireless driver.
  *
- * Copyright (C) 2000, David Gibson, Linuxcare Australia <hermes@gibson.dropbear.id.au>
+ * Copyright (C) 2000, David Gibson, Linuxcare Australia.
+ * (C) Copyright David Gibson, IBM Corp. 2001-2003.
  *
  * Portions taken from hfa384x.h, Copyright (C) 1999 AbsoluteValue Systems, Inc. All Rights Reserved.
  *
Index: working-2.6/drivers/net/wireless/orinoco_tmd.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco_tmd.c	2004-07-28 15:05:52.560655400 +1000
+++ working-2.6/drivers/net/wireless/orinoco_tmd.c	2004-07-28 15:05:55.352231016 +1000
@@ -1,10 +1,10 @@
-/* orinoco_tmd.c 0.01
+/* orinoco_tmd.c
  * 
  * Driver for Prism II devices which would usually be driven by orinoco_cs,
  * but are connected to the PCI bus by a TMD7160. 
  *
  * Copyright (C) 2003 Joerg Dorchain <joerg AT dorchain.net>
- * based heavily upon orinoco_plx.c Copyright (C) 2001 Daniel Barlow <dan AT telent.net>
+ * based heavily upon orinoco_plx.c Copyright (C) 2001 Daniel Barlow
  *
  * The contents of this file are subject to the Mozilla Public License
  * Version 1.1 (the "License"); you may not use this file except in
Index: working-2.6/drivers/net/wireless/orinoco_cs.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco_cs.c	2004-07-28 15:05:49.950052272 +1000
+++ working-2.6/drivers/net/wireless/orinoco_cs.c	2004-07-28 15:05:55.353230864 +1000
@@ -1,4 +1,4 @@
-/* orinoco_cs.c 0.13e	- (formerly known as dldwd_cs.c)
+/* orinoco_cs.c (formerly known as dldwd_cs.c)
  *
  * A driver for "Hermes" chipset based PCMCIA wireless adaptors, such
  * as the Lucent WavelanIEEE/Orinoco cards and their OEM (Cabletron/
@@ -629,7 +629,8 @@
 /* Can't be declared "const" or the whole __initdata section will
  * become const */
 static char version[] __initdata = DRIVER_NAME " " DRIVER_VERSION
-	"(David Gibson <hermes@gibson.dropbear.id.au> and others)";
+	" (David Gibson <hermes@gibson.dropbear.id.au>, "
+	"Pavel Roskin <proski@gnu.org>, et al)";
 
 static struct pcmcia_driver orinoco_driver = {
 	.owner		= THIS_MODULE,
Index: working-2.6/drivers/net/wireless/airport.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/airport.c	2004-07-28 15:05:49.958051056 +1000
+++ working-2.6/drivers/net/wireless/airport.c	2004-07-28 15:05:55.355230560 +1000
@@ -1,4 +1,4 @@
-/* airport.c 0.13e
+/* airport.c
  *
  * A driver for "Hermes" chipset based Apple Airport wireless
  * card.
Index: working-2.6/drivers/net/wireless/orinoco_plx.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco_plx.c	2004-07-28 15:05:52.561655248 +1000
+++ working-2.6/drivers/net/wireless/orinoco_plx.c	2004-07-28 15:05:55.357230256 +1000
@@ -1,9 +1,14 @@
-/* orinoco_plx.c 0.13e
- * 
+/* orinoco_plx.c
+ *
  * Driver for Prism II devices which would usually be driven by orinoco_cs,
  * but are connected to the PCI bus by a PLX9052.
  *
- * Copyright (C) 2001 Daniel Barlow <dan AT telent.net>
+ * Current maintainers (as of 29 September 2003) are:
+ * 	Pavel Roskin <proski AT gnu.org>
+ * and	David Gibson <hermes AT gibson.dropbear.id.au>
+ *
+ * (C) Copyright David Gibson, IBM Corp. 2001-2003.
+ * Copyright (C) 2001 Daniel Barlow
  *
  * The contents of this file are subject to the Mozilla Public License
  * Version 1.1 (the "License"); you may not use this file except in
@@ -331,7 +336,9 @@
 };
 
 static char version[] __initdata = DRIVER_NAME " " DRIVER_VERSION
-	" (Daniel Barlow <dan@telent.net>, David Gibson <hermes@gibson.dropbear.id.au>)";
+	" (Pavel Roskin <proski@gnu.org>,"
+	" David Gibson <hermes@gibson.dropbear.id.au>,"
+	" Daniel Barlow <dan@telent.net>)";
 MODULE_AUTHOR("Daniel Barlow <dan@telent.net>");
 MODULE_DESCRIPTION("Driver for wireless LAN cards using the PLX9052 PCI bridge");
 MODULE_LICENSE("Dual MPL/GPL");
Index: working-2.6/MAINTAINERS
===================================================================
--- working-2.6.orig/MAINTAINERS	2004-07-27 17:02:55.000000000 +1000
+++ working-2.6/MAINTAINERS	2004-07-28 15:05:55.361229648 +1000
@@ -1576,6 +1576,8 @@
 S:	Maintained
 
 ORINOCO DRIVER
+P:	Pavel Roskin
+M:	proski@gnu.org
 P:	David Gibson
 M:	hermes@gibson.dropbear.id.au
 W:	http://www.ozlabs.org/people/dgibson/dldwd

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
