Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262322AbVCVCMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262322AbVCVCMG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 21:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262326AbVCVCJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 21:09:54 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:9355 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262324AbVCVBfO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 20:35:14 -0500
Message-Id: <20050322013458.817704000@abc>
References: <20050322013427.919515000@abc>
Date: Tue, 22 Mar 2005 02:24:06 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-tda10021-cc-err-fix.patch
X-SA-Exim-Connect-IP: 217.231.55.169
Subject: [DVB patch 33/48] tda10021: fix continuity errors
X-SA-Exim-Version: 4.2 (built Tue, 25 Jan 2005 19:36:50 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix Continuity Errors with tda10021 (slickhenry, Robert Schlabbach)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 tda10021.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/tda10021.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/frontends/tda10021.c	2005-03-22 00:16:28.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/tda10021.c	2005-03-22 00:23:32.000000000 +0100
@@ -66,7 +66,7 @@ static u8 tda10021_inittab[0x40]=
 {
 	0x73, 0x6a, 0x23, 0x0a, 0x02, 0x37, 0x77, 0x1a,
 	0x37, 0x6a, 0x17, 0x8a, 0x1e, 0x86, 0x43, 0x40,
-	0xb8, 0x3f, 0xa1, 0x00, 0xcd, 0x01, 0x00, 0xff,
+	0xb8, 0x3f, 0xa0, 0x00, 0xcd, 0x01, 0x00, 0xff,
 	0x11, 0x00, 0x7c, 0x31, 0x30, 0x20, 0x00, 0x00,
 	0x02, 0x00, 0x00, 0x7d, 0x00, 0x00, 0x00, 0x00,
 	0x07, 0x00, 0x33, 0x11, 0x0d, 0x95, 0x08, 0x58,

--

