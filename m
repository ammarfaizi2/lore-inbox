Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263763AbTCUSn1>; Fri, 21 Mar 2003 13:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263767AbTCUSmN>; Fri, 21 Mar 2003 13:42:13 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:14212
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263765AbTCUSlG>; Fri, 21 Mar 2003 13:41:06 -0500
Date: Fri, 21 Mar 2003 19:56:22 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303211956.h2LJuMME026127@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: add a new dmi flag for broken pnpbios
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/include/asm-i386/system.h linux-2.5.65-ac2/include/asm-i386/system.h
--- linux-2.5.65/include/asm-i386/system.h	2003-03-03 19:20:16.000000000 +0000
+++ linux-2.5.65-ac2/include/asm-i386/system.h	2003-03-20 18:12:10.000000000 +0000
@@ -407,5 +407,6 @@
 
 #define BROKEN_ACPI_Sx		0x0001
 #define BROKEN_INIT_AFTER_S1	0x0002
+#define BROKEN_PNP_BIOS		0x0004
 
 #endif
