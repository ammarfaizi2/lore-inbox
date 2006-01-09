Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751554AbWAIWSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751554AbWAIWSo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 17:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751556AbWAIWSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 17:18:44 -0500
Received: from fmr17.intel.com ([134.134.136.16]:44494 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751550AbWAIWSn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 17:18:43 -0500
From: Jason Gaston <jason.d.gaston@intel.com>
Organization: Intel Corp.
To: akpm@osdl.org, tiwai@suse.de, perex@suse.cz
Subject: [PATCH 2.6.15 4/6] hda_intel: patch for Intel ICH8
Date: Mon, 9 Jan 2006 11:05:52 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, jason.d.gaston@intel.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601091105.52356.jason.d.gaston@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch adds the Intel ICH8 HD Audio DID to the hda_intel.c audio driver.  This patch was built against the 2.6.15 kernel.  
If acceptable, please apply. 

Thanks,

Jason Gaston

Signed-off-by:  Jason Gaston <Jason.d.gaston@intel.com>

--- linux-2.6.15/sound/pci/hda/hda_intel.c.orig	2006-01-02 19:21:10.000000000 -0800
+++ linux-2.6.15/sound/pci/hda/hda_intel.c	2006-01-09 08:18:08.017290864 -0800
@@ -70,6 +70,7 @@
 			 "{Intel, ICH6M},"
 			 "{Intel, ICH7},"
 			 "{Intel, ESB2},"
+			 "{Intel, ICH8 },"
 			 "{ATI, SB450},"
 			 "{VIA, VT8251},"
 			 "{VIA, VT8237A},"
@@ -1603,6 +1604,7 @@
 	{ 0x8086, 0x2668, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_ICH }, /* ICH6 */
 	{ 0x8086, 0x27d8, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_ICH }, /* ICH7 */
 	{ 0x8086, 0x269a, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_ICH }, /* ESB2 */
+	{ 0x8086, 0x284b, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_ICH }, /* ICH8 */
 	{ 0x1002, 0x437b, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_ATI }, /* ATI SB450 */
 	{ 0x1106, 0x3288, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_VIA }, /* VIA VT8251/VT8237A */
 	{ 0x1039, 0x7502, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_SIS }, /* SIS966 */
