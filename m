Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262560AbUCOMxj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 07:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262562AbUCOMxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 07:53:39 -0500
Received: from relay-2v.club-internet.fr ([194.158.96.113]:38118 "EHLO
	relay-2v.club-internet.fr") by vger.kernel.org with ESMTP
	id S262560AbUCOMxa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 07:53:30 -0500
From: pinotj@club-internet.fr
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Typo, a few in documentation of 2.6.4
Date: Mon, 15 Mar 2004 13:53:29 CET
Mime-Version: 1.0
X-Mailer: Medianet/v2.0
Message-Id: <mnet1.1079355209.20900.pinotj@club-internet.fr>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not dangerous but cleaner. The first patch fix a compilation problem (make sgmldocs), init.c was removed from source. The others are obvious.

Regards,

Jerome Pinot

diff -Nru -U 2 linux-2.6.4.orig/Documentation/DocBook/parportbook.tmpl linux-2.6.4/Documentation/DocBook/parportbook.tmpl
--- linux-2.6.4.orig/Documentation/DocBook/parportbook.tmpl	2004-02-18 12:57:14.000000000 +0900
+++ linux-2.6.4/Documentation/DocBook/parportbook.tmpl	2004-03-15 16:23:28.000000000 +0900
@@ -2730,7 +2730,7 @@
 
 </book>
 <!-- Additional function to be documented:
-!Ddrivers/parport/init.c
+!Ddrivers/parport/probe.c
 -->
 <!-- Local Variables: -->
 <!-- sgml-indent-step: 1 -->
diff -Nru -U 2 linux-2.6.4.orig/REPORTING-BUGS linux-2.6.4/REPORTING-BUGS
--- linux-2.6.4.orig/REPORTING-BUGS	2004-02-18 12:58:01.000000000 +0900
+++ linux-2.6.4/REPORTING-BUGS	2004-03-15 07:52:46.000000000 +0900
@@ -9,7 +9,7 @@
 bug report. This explains what you should do with the "Oops" information
 to make it useful to the recipient.
 
-      Send the output the maintainer of the kernel area that seems to
+      Send the output to the maintainer of the kernel area that seems to
 be involved with the problem. Don't worry too much about getting the
 wrong person. If you are unsure send it to the person responsible for the
 code relevant to what you were doing. If it occurs repeatably try and
@@ -21,7 +21,7 @@
 mailing list see http://www.tux.org/lkml/).
 
 This is a suggested format for a bug report sent to the Linux kernel mailing 
-list. Having a standardized bug report form makes it easier  for you not to 
+list. Having a standardized bug report form makes it easier for you not to 
 overlook things, and easier for the developers to find the pieces of 
 information they're really interested in. Don't feel you have to follow it.
 
diff -Nru -U 2 linux-2.6.4.orig/arch/arm/Kconfig linux-2.6.4/arch/arm/Kconfig
--- linux-2.6.4.orig/arch/arm/Kconfig	2004-03-15 07:48:52.000000000 +0900
+++ linux-2.6.4/arch/arm/Kconfig	2004-03-15 12:55:00.000000000 +0900
@@ -78,7 +78,7 @@
 config ARCH_ANAKIN
 	bool "Anakin"
 	---help---
-	  The Anakin is a StrongArm based SA110 - 2 DIN Vehicle Telematics Platform.
+	  The Anakin is a StrongARM based SA110 - 2 DIN Vehicle Telematics Platform.
 	  64MB SDRAM - 4 Mb Flash - Compact Flash Interface - 1 MB VRAM
 
 	  On board peripherals:
diff -Nru -U 2 linux-2.6.4.orig/arch/h8300/Kconfig linux-2.6.4/arch/h8300/Kconfig
--- linux-2.6.4.orig/arch/h8300/Kconfig	2004-03-15 07:48:52.000000000 +0900
+++ linux-2.6.4/arch/h8300/Kconfig	2004-03-15 13:08:46.000000000 +0900
@@ -56,14 +56,14 @@
 	  AKI-H8/3068F / AKI-H8/3069F Flashmicom LAN Board Suppot
 	  More Information. (Japanese Only)
 	  <http://akizukidensi.com/catalog/h8.html>
-	  AE-3068/69 Evalution Board Support
+	  AE-3068/69 Evaluation Board Support
 	  More Information.
 	  <http://www.microtronique.com/ae3069lan.htm>
 
 config H8300H_H8MAX
 	bool "H8MAX"
 	help
-	  H8MAX Evalution Board Suooprt
+	  H8MAX Evaluation Board Support
 	  More Information. (Japanese Only)
 	  <http://strawberry-linux.com/h8/index.html>
 
@@ -77,7 +77,7 @@
 config H8S_EDOSK2674
 	bool "EDOSK-2674"
 	help
-	  Renesas EDOSK-2674R Evalution Board Support
+	  Renesas EDOSK-2674R Evaluation Board Support
 	  More Information.
 	  <http://www.azpower.com/H8-uClinux/index.html>
  	  <http://www.eu.renesas.com/tools/edk/support/edosk2674.html>
diff -Nru -U 2 linux-2.6.4.orig/arch/mips/Kconfig linux-2.6.4/arch/mips/Kconfig
--- linux-2.6.4.orig/arch/mips/Kconfig	2004-03-15 07:48:52.000000000 +0900
+++ linux-2.6.4/arch/mips/Kconfig	2004-03-15 10:38:49.000000000 +0900
@@ -247,7 +247,7 @@
 	  Momentum Computer <http://www.momenco.com/>.
 
 config PMC_YOSEMITE
-	bool "Support for PMC-Siera Yosemite eval board"
+	bool "PMC-Sierra Yosemite Evaluation Board Support"
 	help
 	  Yosemite is an evaluation board for the RM9000x2 processor
 	  manufactured by PMC-Sierra

