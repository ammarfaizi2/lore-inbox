Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263758AbTCUTUc>; Fri, 21 Mar 2003 14:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263757AbTCUTTX>; Fri, 21 Mar 2003 14:19:23 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:47236
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263751AbTCUTTA>; Fri, 21 Mar 2003 14:19:00 -0500
Date: Fri, 21 Mar 2003 20:34:16 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303212034.h2LKYG5f026395@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: remove odd blank line and add noacpi
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/Documentation/kernel-parameters.txt linux-2.5.65-ac2/Documentation/kernel-parameters.txt
--- linux-2.5.65/Documentation/kernel-parameters.txt	2003-03-18 16:46:44.000000000 +0000
+++ linux-2.5.65-ac2/Documentation/kernel-parameters.txt	2003-03-18 16:49:00.000000000 +0000
@@ -713,7 +713,6 @@
 					numbers ourselves, overriding
 					whatever the firmware may have
 					done.
-
 		usepirqmask		[IA-32] Honor the possible IRQ mask
 					stored in the BIOS $PIR table. This is
 					needed on some systems with broken
@@ -721,6 +720,7 @@
 					and Omnibook XE3 notebooks. This will
 					have no effect if ACPI IRQ routing is
 					enabled.
+		noacpi			[IA-32] Do not use ACPI for IRQ routing.
 
 	pcmv=		[HW,PCMCIA] BadgePAD 4
 
