Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263767AbUC3Rk4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 12:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbUC3Rk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 12:40:56 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:45201 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S263767AbUC3Rkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 12:40:42 -0500
Date: Tue, 30 Mar 2004 18:38:22 +0100
From: Dave Jones <davej@redhat.com>
To: greg@kroah.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] kill off CONFIG_USB_BRLVGER detritus.
Message-ID: <20040330173822.GC25834@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, greg@kroah.com,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This died a while ago, but lingers on in defconfigs.

		Dave

--- linux-2.6.4/arch/arm/configs/neponset_defconfig~	2004-03-30 18:35:21.000000000 +0100
+++ linux-2.6.4/arch/arm/configs/neponset_defconfig	2004-03-30 18:35:28.000000000 +0100
@@ -848,7 +848,6 @@
 # CONFIG_USB_TIGL is not set
 # CONFIG_USB_AUERSWALD is not set
 # CONFIG_USB_RIO500 is not set
-# CONFIG_USB_BRLVGER is not set
 # CONFIG_USB_LCD is not set
 # CONFIG_USB_TEST is not set
 
--- linux-2.6.4/arch/ppc/configs/lopec_defconfig~	2004-03-30 18:35:32.000000000 +0100
+++ linux-2.6.4/arch/ppc/configs/lopec_defconfig	2004-03-30 18:35:36.000000000 +0100
@@ -788,7 +788,6 @@
 # CONFIG_USB_TIGL is not set
 # CONFIG_USB_AUERSWALD is not set
 # CONFIG_USB_RIO500 is not set
-# CONFIG_USB_BRLVGER is not set
 # CONFIG_USB_LCD is not set
 # CONFIG_USB_TEST is not set
 # CONFIG_USB_GADGET is not set
--- linux-2.6.4/arch/ppc/configs/adir_defconfig~	2004-03-30 18:35:40.000000000 +0100
+++ linux-2.6.4/arch/ppc/configs/adir_defconfig	2004-03-30 18:35:42.000000000 +0100
@@ -776,7 +776,6 @@
 # CONFIG_USB_TIGL is not set
 # CONFIG_USB_AUERSWALD is not set
 # CONFIG_USB_RIO500 is not set
-# CONFIG_USB_BRLVGER is not set
 # CONFIG_USB_LCD is not set
 # CONFIG_USB_TEST is not set
 # CONFIG_USB_GADGET is not set
--- linux-2.6.4/arch/ppc/configs/sandpoint_defconfig~	2004-03-30 18:35:48.000000000 +0100
+++ linux-2.6.4/arch/ppc/configs/sandpoint_defconfig	2004-03-30 18:35:50.000000000 +0100
@@ -775,7 +775,6 @@
 # CONFIG_USB_TIGL is not set
 # CONFIG_USB_AUERSWALD is not set
 # CONFIG_USB_RIO500 is not set
-# CONFIG_USB_BRLVGER is not set
 # CONFIG_USB_LCD is not set
 # CONFIG_USB_TEST is not set
 # CONFIG_USB_GADGET is not set
--- linux-2.6.4/arch/ppc/configs/common_defconfig~	2004-03-30 18:35:55.000000000 +0100
+++ linux-2.6.4/arch/ppc/configs/common_defconfig	2004-03-30 18:35:57.000000000 +0100
@@ -1209,7 +1209,6 @@
 # CONFIG_USB_TIGL is not set
 # CONFIG_USB_AUERSWALD is not set
 # CONFIG_USB_RIO500 is not set
-# CONFIG_USB_BRLVGER is not set
 # CONFIG_USB_LCD is not set
 # CONFIG_USB_TEST is not set
 # CONFIG_USB_GADGET is not set
--- linux-2.6.4/arch/ppc/configs/pmac_defconfig~	2004-03-30 18:36:41.000000000 +0100
+++ linux-2.6.4/arch/ppc/configs/pmac_defconfig	2004-03-30 18:36:43.000000000 +0100
@@ -1249,7 +1249,6 @@
 # CONFIG_USB_TIGL is not set
 # CONFIG_USB_AUERSWALD is not set
 # CONFIG_USB_RIO500 is not set
-# CONFIG_USB_BRLVGER is not set
 # CONFIG_USB_LCD is not set
 # CONFIG_USB_TEST is not set
 # CONFIG_USB_GADGET is not set
--- linux-2.6.4/arch/ppc/defconfig~	2004-03-30 18:36:43.000000000 +0100
+++ linux-2.6.4/arch/ppc/defconfig	2004-03-30 18:36:45.000000000 +0100
@@ -1208,7 +1208,6 @@
 # CONFIG_USB_TIGL is not set
 # CONFIG_USB_AUERSWALD is not set
 # CONFIG_USB_RIO500 is not set
-# CONFIG_USB_BRLVGER is not set
 # CONFIG_USB_LCD is not set
 # CONFIG_USB_TEST is not set
 # CONFIG_USB_GADGET is not set
--- linux-2.6.4/arch/ia64/configs/zx1_defconfig~	2004-03-30 18:36:45.000000000 +0100
+++ linux-2.6.4/arch/ia64/configs/zx1_defconfig	2004-03-30 18:36:46.000000000 +0100
@@ -1028,7 +1028,6 @@
 # CONFIG_USB_AUERSWALD is not set
 # CONFIG_USB_RIO500 is not set
 # CONFIG_USB_LEGOTOWER is not set
-# CONFIG_USB_BRLVGER is not set
 # CONFIG_USB_LCD is not set
 # CONFIG_USB_LED is not set
 
--- linux-2.6.4/arch/ia64/configs/generic_defconfig~	2004-03-30 18:36:46.000000000 +0100
+++ linux-2.6.4/arch/ia64/configs/generic_defconfig	2004-03-30 18:36:48.000000000 +0100
@@ -976,7 +976,6 @@
 # CONFIG_USB_AUERSWALD is not set
 # CONFIG_USB_RIO500 is not set
 # CONFIG_USB_LEGOTOWER is not set
-# CONFIG_USB_BRLVGER is not set
 # CONFIG_USB_LCD is not set
 # CONFIG_USB_TEST is not set
 # CONFIG_USB_GADGET is not set
--- linux-2.6.4/arch/ia64/defconfig~	2004-03-30 18:36:48.000000000 +0100
+++ linux-2.6.4/arch/ia64/defconfig	2004-03-30 18:36:50.000000000 +0100
@@ -906,7 +906,6 @@
 # CONFIG_USB_AUERSWALD is not set
 # CONFIG_USB_RIO500 is not set
 # CONFIG_USB_LEGOTOWER is not set
-# CONFIG_USB_BRLVGER is not set
 # CONFIG_USB_LCD is not set
 # CONFIG_USB_LED is not set
 # CONFIG_USB_TEST is not set
--- linux-2.6.4/arch/mips/configs/rm200_defconfig~	2004-03-30 18:36:50.000000000 +0100
+++ linux-2.6.4/arch/mips/configs/rm200_defconfig	2004-03-30 18:36:52.000000000 +0100
@@ -986,7 +986,6 @@
 CONFIG_USB_AUERSWALD=m
 CONFIG_USB_RIO500=m
 CONFIG_USB_LEGOTOWER=m
-CONFIG_USB_BRLVGER=m
 CONFIG_USB_LCD=m
 # CONFIG_USB_LED is not set
 CONFIG_USB_TEST=m
--- linux-2.6.4/arch/ppc64/configs/pSeries_defconfig~	2004-03-30 18:36:52.000000000 +0100
+++ linux-2.6.4/arch/ppc64/configs/pSeries_defconfig	2004-03-30 18:36:53.000000000 +0100
@@ -880,7 +880,6 @@
 # CONFIG_USB_AUERSWALD is not set
 # CONFIG_USB_RIO500 is not set
 # CONFIG_USB_LEGOTOWER is not set
-# CONFIG_USB_BRLVGER is not set
 # CONFIG_USB_LCD is not set
 # CONFIG_USB_LED is not set
 # CONFIG_USB_TEST is not set
--- linux-2.6.4/arch/ppc64/defconfig~	2004-03-30 18:36:53.000000000 +0100
+++ linux-2.6.4/arch/ppc64/defconfig	2004-03-30 18:36:55.000000000 +0100
@@ -880,7 +880,6 @@
 # CONFIG_USB_AUERSWALD is not set
 # CONFIG_USB_RIO500 is not set
 # CONFIG_USB_LEGOTOWER is not set
-# CONFIG_USB_BRLVGER is not set
 # CONFIG_USB_LCD is not set
 # CONFIG_USB_LED is not set
 # CONFIG_USB_TEST is not set
--- linux-2.6.4/arch/parisc/configs/c3000_defconfig~	2004-03-30 18:36:55.000000000 +0100
+++ linux-2.6.4/arch/parisc/configs/c3000_defconfig	2004-03-30 18:36:57.000000000 +0100
@@ -876,7 +876,6 @@
 # CONFIG_USB_AUERSWALD is not set
 # CONFIG_USB_RIO500 is not set
 CONFIG_USB_LEGOTOWER=m
-# CONFIG_USB_BRLVGER is not set
 # CONFIG_USB_LCD is not set
 # CONFIG_USB_LED is not set
 # CONFIG_USB_TEST is not set
--- linux-2.6.4/arch/parisc/defconfig~	2004-03-30 18:36:57.000000000 +0100
+++ linux-2.6.4/arch/parisc/defconfig	2004-03-30 18:36:59.000000000 +0100
@@ -737,7 +737,6 @@
 # CONFIG_USB_AUERSWALD is not set
 # CONFIG_USB_RIO500 is not set
 # CONFIG_USB_LEGOTOWER is not set
-# CONFIG_USB_BRLVGER is not set
 # CONFIG_USB_LCD is not set
 # CONFIG_USB_LED is not set
 
