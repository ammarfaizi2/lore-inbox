Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266816AbUG1HPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266816AbUG1HPm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 03:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266802AbUG1HPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 03:15:04 -0400
Received: from ozlabs.org ([203.10.76.45]:8842 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266806AbUG1HLs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 03:11:48 -0400
Date: Wed, 28 Jul 2004 16:59:53 +1000
From: David Gibson <hermes@gibson.dropbear.id.au>
To: Jeff Garzik <jgarzik@pobox.com>, Francois Romieu <romieu@fr.zoreil.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>, jt@hpl.hp.com,
       Dan Williams <dcbw@redhat.com>, Pavel Roskin <proski@gnu.org>,
       Orinoco Development List <orinoco-devel@lists.sourceforge.net>
Subject: [12/15] orinoco merge preliminaries - remove unneeded #includes
Message-ID: <20040728065953.GO16908@zax>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Francois Romieu <romieu@fr.zoreil.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	jt@hpl.hp.com, Dan Williams <dcbw@redhat.com>,
	Pavel Roskin <proski@gnu.org>,
	Orinoco Development List <orinoco-devel@lists.sourceforge.net>
References: <20040728065345.GE16908@zax> <20040728065418.GF16908@zax> <20040728065450.GG16908@zax> <20040728065526.GH16908@zax> <20040728065550.GI16908@zax> <20040728065659.GJ16908@zax> <20040728065725.GK16908@zax> <20040728065800.GL16908@zax> <20040728065827.GM16908@zax> <20040728065913.GN16908@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040728065913.GN16908@zax>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove some unnecessary #includes.

Signed-off-by: David Gibson <hermes@gibson.dropbear.id.au>

Index: working-2.6/drivers/net/wireless/orinoco_pci.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco_pci.c	2004-07-28 13:59:20.878483328 +1000
+++ working-2.6/drivers/net/wireless/orinoco_pci.c	2004-07-28 14:13:17.445305840 +1000
@@ -102,7 +102,6 @@
 #include <linux/netdevice.h>
 #include <linux/if_arp.h>
 #include <linux/etherdevice.h>
-#include <linux/wireless.h>
 #include <linux/list.h>
 #include <linux/pci.h>
 #include <linux/fcntl.h>
Index: working-2.6/drivers/net/wireless/orinoco_tmd.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco_tmd.c	2004-07-28 13:59:20.882482720 +1000
+++ working-2.6/drivers/net/wireless/orinoco_tmd.c	2004-07-28 14:14:40.023752008 +1000
@@ -69,7 +69,6 @@
 #include <linux/netdevice.h>
 #include <linux/if_arp.h>
 #include <linux/etherdevice.h>
-#include <linux/wireless.h>
 #include <linux/list.h>
 #include <linux/pci.h>
 #include <linux/fcntl.h>
Index: working-2.6/drivers/net/wireless/orinoco_plx.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco_plx.c	2004-07-28 13:59:20.880483024 +1000
+++ working-2.6/drivers/net/wireless/orinoco_plx.c	2004-07-28 14:13:56.727334064 +1000
@@ -128,7 +128,6 @@
 #include <linux/netdevice.h>
 #include <linux/if_arp.h>
 #include <linux/etherdevice.h>
-#include <linux/wireless.h>
 #include <linux/list.h>
 #include <linux/pci.h>
 #include <linux/fcntl.h>

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
