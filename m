Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262808AbVA1XXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262808AbVA1XXq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 18:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262819AbVA1XXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 18:23:46 -0500
Received: from hera.cwi.nl ([192.16.191.8]:38032 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262808AbVA1XXc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 18:23:32 -0500
Date: Sat, 29 Jan 2005 00:23:15 +0100 (MET)
From: <Andries.Brouwer@cwi.nl>
Message-Id: <200501282323.j0SNNFF23250@apps.cwi.nl>
To: akpm@osdl.org, torvalds@osdl.org, vojtech@suse.cz
Subject: [PATCH] document atkbd.softraw
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Document atkbd.softraw (and shorten a few long lines nearby).

diff -uprN -X /linux/dontdiff a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
--- a/Documentation/kernel-parameters.txt	2004-12-29 03:39:42.000000000 +0100
+++ b/Documentation/kernel-parameters.txt	2005-01-29 00:21:07.000000000 +0100
@@ -222,15 +222,19 @@ running once the system is up.
 
 	atascsi=	[HW,SCSI] Atari SCSI
 
-	atkbd.extra=	[HW] Enable extra LEDs and keys on IBM RapidAccess, EzKey
-			and similar keyboards
+	atkbd.extra=	[HW] Enable extra LEDs and keys on IBM RapidAccess,
+			EzKey and similar keyboards
 
 	atkbd.reset=	[HW] Reset keyboard during initialization
 
 	atkbd.set=	[HW] Select keyboard code set 
 			Format: <int> (2 = AT (default) 3 = PS/2)
 
-	atkbd.scroll=	[HW] Enable scroll wheel on MS Office and similar keyboards
+	atkbd.scroll=	[HW] Enable scroll wheel on MS Office and similar
+			keyboards
+
+	atkbd.softraw=	[HW] Choose between synthetic and real raw mode
+			Format: <bool> (0 = real, 1 = synthetic (default))
 	
 	atkbd.softrepeat=
 			[HW] Use software keyboard repeat
