Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264870AbTGKR5f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 13:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264810AbTGKRzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 13:55:54 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:6020
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S264593AbTGKRyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 13:54:04 -0400
Date: Fri, 11 Jul 2003 19:07:51 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307111807.h6BI7pc3017266@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: not sure what the author was on ..
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.75/drivers/video/sis/init301.c linux-2.5.75-ac1/drivers/video/sis/init301.c
--- linux-2.5.75/drivers/video/sis/init301.c	2003-07-10 21:04:46.000000000 +0100
+++ linux-2.5.75-ac1/drivers/video/sis/init301.c	2003-07-11 13:43:45.000000000 +0100
@@ -5282,7 +5282,7 @@
 #ifdef SIS315H	/* 310/325 series */
 
 	if(SiS_Pr->SiS_IF_DEF_CH70xx != 0) {
-		temp =  temp = SiS_GetCH701x(SiS_Pr,0x61);
+		temp = SiS_GetCH701x(SiS_Pr,0x61);
 		if(temp < 1) {
 		   SiS_SetCH701x(SiS_Pr,0xac76);
 		   SiS_SetCH701x(SiS_Pr,0x0066);
