Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266372AbTGEP4V (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 11:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266378AbTGEP4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 11:56:21 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:7811
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S266372AbTGEP4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 11:56:21 -0400
Date: Sat, 5 Jul 2003 17:09:34 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307051609.h65G9Y88032402@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: PATCH: Fix DMI missing string in -bk2 snapshot
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(Now Jeff has snapshots I can fix these things - thanks Jeff)


--- ../linux.22-pre2-ac1/include/asm-i386/system.h	2003-07-01 21:18:35.000000000 +0100
+++ include/asm-i386/system.h	2003-07-05 17:03:32.000000000 +0100
@@ -375,5 +373,6 @@
 
 #define BROKEN_ACPI_Sx		0x0001
 #define BROKEN_INIT_AFTER_S1	0x0002
+#define BROKEN_PNP_BIOS		0x0004
 
 #endif
