Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751308AbWFTPPx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbWFTPPx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 11:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbWFTPPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 11:15:53 -0400
Received: from [212.33.166.67] ([212.33.166.67]:52231 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1751308AbWFTPPg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 11:15:36 -0400
From: Al Boldi <a1426z@gawab.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] drm: Add VIA chipset IDs for drm detection
Date: Tue, 20 Jun 2006 18:16:08 +0300
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200606201816.08768.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Allow drm detection of new VIA chipsets.

Signed-off-by: Al Boldi <a1426z@gawab.com>
--
--- drivers/char/drm/drm_pciids.h.old	2006-06-19 01:34:48.000000000 +0300
+++ drivers/char/drm/drm_pciids.h	2006-06-19 13:36:49.000000000 +0300
@@ -227,6 +227,9 @@
 	{0x1106, 0x3122, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
 	{0x1106, 0x7205, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
 	{0x1106, 0x3108, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
+	{0x1106, 0x3157, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
+	{0x1106, 0x3344, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
+	{0x1106, 0x7204, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, \
 	{0, 0, 0}
 
 #define i810_PCI_IDS \

