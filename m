Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266790AbUG1HNs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266790AbUG1HNs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 03:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266814AbUG1HNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 03:13:21 -0400
Received: from ozlabs.org ([203.10.76.45]:6538 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266797AbUG1HLs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 03:11:48 -0400
Date: Wed, 28 Jul 2004 16:55:50 +1000
From: David Gibson <hermes@gibson.dropbear.id.au>
To: Jeff Garzik <jgarzik@pobox.com>, Francois Romieu <romieu@fr.zoreil.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>, jt@hpl.hp.com,
       Dan Williams <dcbw@redhat.com>, Pavel Roskin <proski@gnu.org>,
       Orinoco Development List <orinoco-devel@lists.sourceforge.net>
Subject: [6/15] orinoco merge preliminaries - spam stoppers
Message-ID: <20040728065550.GI16908@zax>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Francois Romieu <romieu@fr.zoreil.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	jt@hpl.hp.com, Dan Williams <dcbw@redhat.com>,
	Pavel Roskin <proski@gnu.org>,
	Orinoco Development List <orinoco-devel@lists.sourceforge.net>
References: <20040712213349.A2540@electric-eye.fr.zoreil.com> <40F57D78.9080609@pobox.com> <20040715010137.GB3697@zax> <41068E4B.2040507@pobox.com> <20040728065128.GC16908@zax> <20040728065308.GD16908@zax> <20040728065345.GE16908@zax> <20040728065418.GF16908@zax> <20040728065450.GG16908@zax> <20040728065526.GH16908@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040728065526.GH16908@zax>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anti-spam obfuscate most email addresses in the orinoco driver files.
Yes, this is closing gate long after the sheep have run, but I guess
it can't hurt.

Signed-off-by: David Gibson <hermes@gibson.dropbear.id.au>

Index: working-2.6/drivers/net/wireless/orinoco.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco.c
+++ working-2.6/drivers/net/wireless/orinoco.c
@@ -3,15 +3,16 @@
  * A driver for Hermes or Prism 2 chipset based PCMCIA wireless
  * adaptors, with Lucent/Agere, Intersil or Symbol firmware.
  *
- * Copyright (C) 2000 David Gibson, Linuxcare Australia <hermes@gibson.dropbear.id.au>
+ * Copyright (C) 2000 David Gibson, Linuxcare Australia <hermes AT gibson.dropbear.id.au>
  *	With some help from :
- * Copyright (C) 2001 Jean Tourrilhes, HP Labs <jt@hpl.hp.com>
- * Copyright (C) 2001 Benjamin Herrenschmidt <benh@kernel.crashing.org>
+ * Copyright (C) 2001 Jean Tourrilhes, HP Labs <jt AT hpl.hp.com>
+ * Copyright (C) 2001 Benjamin Herrenschmidt <benh AT kernel.crashing.org>
  *
  * Based on dummy_cs.c 1.27 2000/06/12 21:27:25
  *
- * Portions based on wvlan_cs.c 1.0.6, Copyright Andreas Neuhaus <andy@fasta.fh-dortmund.de>
- *      http://www.fasta.fh-dortmund.de/users/andy/wvlan/
+ * Portions based on wvlan_cs.c 1.0.6, Copyright Andreas Neuhaus <andy
+ * AT fasta.fh-dortmund.de>
+ * http://www.fasta.fh-dortmund.de/users/andy/wvlan/
  *
  * The contents of this file are subject to the Mozilla Public License
  * Version 1.1 (the "License"); you may not use this file except in
@@ -24,7 +25,7 @@
  * limitations under the License.
  *
  * The initial developer of the original code is David A. Hinds
- * <dahinds@users.sourceforge.net>.  Portions created by David
+ * <dahinds AT users.sourceforge.net>.  Portions created by David
  * A. Hinds are Copyright (C) 1999 David A. Hinds.  All Rights
  * Reserved.
  *
@@ -82,7 +83,7 @@
  *	o Clean up RID definitions in hermes.h, other cleanups
  *
  * v0.04b -> v0.04c - 24/4/2001 - Jean II
- *	o Tim Hurley <timster@seiki.bliztech.com> reported a D-Link card
+ *	o Tim Hurley <timster AT seiki.bliztech.com> reported a D-Link card
  *	  with vendor 02 and firmware 0.08. Added in the capabilities...
  *	o Tested Lucent firmware 7.28, everything works...
  *
@@ -106,14 +107,14 @@
  *
  * v0.05c -> v0.05d - 5/5/2001 - Jean II
  *	o Workaround to SNAP decapsulate frame from LinkSys AP
- *	  original patch from : Dong Liu <dliu@research.bell-labs.com>
+ *	  original patch from : Dong Liu <dliu AT research.bell-labs.com>
  *	  (note : the memcmp bug was mine - fixed)
  *	o Remove set_retry stuff, no firmware support it (bloat--).
  *
  * v0.05d -> v0.06 - 25/5/2001 - Jean II
- *		Original patch from "Hong Lin" <alin@redhat.com>,
- *		"Ian Kinner" <ikinner@redhat.com>
- *		and "David Smith" <dsmith@redhat.com>
+ *		Original patch from "Hong Lin" <alin AT redhat.com>,
+ *		"Ian Kinner" <ikinner AT redhat.com>
+ *		and "David Smith" <dsmith AT redhat.com>
  *	o Init of priv->tx_rate_ctrl in firmware specific section.
  *	o Prism2/Symbol rate, upto should be 0xF and not 0x15. Doh !
  *	o Spectrum card always need cor_reset (for every reset)
@@ -137,7 +138,7 @@
  *        wishes to reduce the number of unecessary messages.
  *	o Removed bogus message on CRC error.
  *	o Merged fixeds for v0.08 Prism 2 firmware from William Waghorn
- *	  <willwaghorn@yahoo.co.uk>
+ *	  <willwaghorn AT yahoo.co.uk>
  *	o Slight cleanup/re-arrangement of firmware detection code.
  *
  * v0.06d -> v0.06e - 1/8/2001 - David Gibson
@@ -159,7 +160,7 @@
  * v0.07 -> v0.07a - 1/10/3001 - Jean II
  *	o Add code to read Symbol firmware revision, inspired by latest code
  *	  in Spectrum24 by Lee John Keyser-Allen - Thanks Lee !
- *	o Thanks to Jared Valentine <hidden@xmission.com> for "providing" me
+ *	o Thanks to Jared Valentine <hidden AT xmission.com> for "providing" me
  *	  a 3Com card with a recent firmware, fill out Symbol firmware
  *	  capabilities of latest rev (2.20), as well as older Symbol cards.
  *	o Disable Power Management in newer Symbol firmware, the API 
Index: working-2.6/drivers/net/wireless/orinoco_pci.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco_pci.c
+++ working-2.6/drivers/net/wireless/orinoco_pci.c
@@ -6,14 +6,14 @@
  * Specifically here we're talking about the Linksys WMP11
  *
  * Some of this code is borrowed from orinoco_plx.c
- *	Copyright (C) 2001 Daniel Barlow <dan@telent.net>
+ *	Copyright (C) 2001 Daniel Barlow <dan AT telent.net>
  * Some of this code is "inspired" by linux-wlan-ng-0.1.10, but nothing
  * has been copied from it. linux-wlan-ng-0.1.10 is originally :
  *	Copyright (C) 1999 AbsoluteValue Systems, Inc.  All Rights Reserved.
  * This file originally written by:
- *	Copyright (C) 2001 Jean Tourrilhes <jt@hpl.hp.com>
+ *	Copyright (C) 2001 Jean Tourrilhes <jt AT hpl.hp.com>
  * And is now maintained by:
- *	Copyright (C) 2002 David Gibson, IBM Corporation <herme@gibson.dropbear.id.au>
+ *	Copyright (C) 2002 David Gibson, IBM Corporation <herme AT gibson.dropbear.id.au>
  *
  * The contents of this file are subject to the Mozilla Public License
  * Version 1.1 (the "License"); you may not use this file except in
Index: working-2.6/drivers/net/wireless/orinoco_plx.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco_plx.c
+++ working-2.6/drivers/net/wireless/orinoco_plx.c
@@ -3,7 +3,7 @@
  * Driver for Prism II devices which would usually be driven by orinoco_cs,
  * but are connected to the PCI bus by a PLX9052. 
  *
- * Copyright (C) 2001 Daniel Barlow <dan@telent.net>
+ * Copyright (C) 2001 Daniel Barlow <dan AT telent.net>
  *
  * The contents of this file are subject to the Mozilla Public License
  * Version 1.1 (the "License"); you may not use this file except in
@@ -311,9 +311,9 @@
 	{0x16ab, 0x1102, PCI_ANY_ID, PCI_ANY_ID,},	/* Linksys WDT11 */
 	{0x16ec, 0x3685, PCI_ANY_ID, PCI_ANY_ID,},	/* USR 2415 */
 	{0xec80, 0xec00, PCI_ANY_ID, PCI_ANY_ID,},	/* Belkin F5D6000 tested by
-							   Brendan W. McAdams <rit@jacked-in.org> */
+							   Brendan W. McAdams <rit AT jacked-in.org> */
 	{0x10b7, 0x7770, PCI_ANY_ID, PCI_ANY_ID,},	/* 3Com AirConnect PCI tested by
-							   Damien Persohn <damien@persohn.net> */
+							   Damien Persohn <damien AT persohn.net> */
 	{0,},
 };
 
Index: working-2.6/drivers/net/wireless/orinoco_tmd.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco_tmd.c
+++ working-2.6/drivers/net/wireless/orinoco_tmd.c
@@ -3,8 +3,8 @@
  * Driver for Prism II devices which would usually be driven by orinoco_cs,
  * but are connected to the PCI bus by a TMD7160. 
  *
- * Copyright (C) 2003 Joerg Dorchain <joerg@dorchain.net>
- * based heavily upon orinoco_plx.c Copyright (C) 2001 Daniel Barlow <dan@telent.net>
+ * Copyright (C) 2003 Joerg Dorchain <joerg AT dorchain.net>
+ * based heavily upon orinoco_plx.c Copyright (C) 2001 Daniel Barlow <dan AT telent.net>
  *
  * The contents of this file are subject to the Mozilla Public License
  * Version 1.1 (the "License"); you may not use this file except in

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
