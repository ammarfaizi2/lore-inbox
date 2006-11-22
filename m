Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031294AbWKVA1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031294AbWKVA1y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 19:27:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031367AbWKVA1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 19:27:54 -0500
Received: from mga09.intel.com ([134.134.136.24]:55432 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S1031294AbWKVA1y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 19:27:54 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,445,1157353200"; 
   d="scan'208"; a="165184519:sNHT262504697"
Subject: [PATCH 2.6.19-rc6] hda_intel: ALSA HD Audio patch for Intel ICH9
From: Jason Gaston <jason.d.gaston@intel.com>
To: perex@suse.cz, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
       tiwai@suse.de, jason.d.gaston@intel.com
Content-Type: text/plain
Date: Tue, 21 Nov 2006 16:27:43 -0800
Message-Id: <1164155264.28490.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the Intel ICH9 HD Audio controller DID's for ALSA.

Signed-off-by:  Jason Gaston <jason.d.gaston@intel.com>

--- linux-2.6.19-rc6/sound/pci/hda/hda_intel.c.orig	2006-11-21
07:06:26.000000000 -0800
+++ linux-2.6.19-rc6/sound/pci/hda/hda_intel.c	2006-11-21
07:10:03.000000000 -0800
@@ -83,6 +83,7 @@
 			 "{Intel, ICH7},"
 			 "{Intel, ESB2},"
 			 "{Intel, ICH8},"
+			 "{Intel, ICH9},"
 			 "{ATI, SB450},"
 			 "{ATI, SB600},"
 			 "{ATI, RS600},"
@@ -1710,6 +1711,8 @@
 	{ 0x8086, 0x27d8, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_ICH }, /*
ICH7 */
 	{ 0x8086, 0x269a, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_ICH }, /*
ESB2 */
 	{ 0x8086, 0x284b, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_ICH }, /*
ICH8 */
+	{ 0x8086, 0x293e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_ICH }, /*
ICH9 */
+	{ 0x8086, 0x293f, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_ICH }, /*
ICH9 */
 	{ 0x1002, 0x437b, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_ATI }, /*
ATI SB450 */
 	{ 0x1002, 0x4383, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_ATI }, /*
ATI SB600 */
 	{ 0x1002, 0x793b, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
AZX_DRIVER_ATIHDMI }, /* ATI RS600 HDMI */

