Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273470AbRIUMXi>; Fri, 21 Sep 2001 08:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273479AbRIUMXS>; Fri, 21 Sep 2001 08:23:18 -0400
Received: from CPE-61-9-150-236.vic.bigpond.net.au ([61.9.150.236]:4850 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S273470AbRIUMXK>; Fri, 21 Sep 2001 08:23:10 -0400
Message-ID: <3BAB307D.F1110ED7@eyal.emu.id.au>
Date: Fri, 21 Sep 2001 22:20:13 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.10-pre10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "list, linux-kernel" <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4.10-pre13: aironet4500_card.c compile problem
Content-Type: multipart/mixed;
 boundary="------------B0A4A57C62E46F9FA377B9D3"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------B0A4A57C62E46F9FA377B9D3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

It is missing <linux/init.h>

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.anu.edu.au/eyal/>
--------------B0A4A57C62E46F9FA377B9D3
Content-Type: text/plain; charset=us-ascii;
 name="2.4.0-pre13-aironet.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.0-pre13-aironet.patch"

--- linux/drivers/net/aironet4500_card.c.orig	Fri Sep 21 22:14:16 2001
+++ linux/drivers/net/aironet4500_card.c	Fri Sep 21 22:14:37 2001
@@ -17,6 +17,7 @@
 #endif
 
 #include <linux/version.h>
+#include <linux/init.h>
 #include <linux/config.h>
 #include <linux/module.h>
 

--------------B0A4A57C62E46F9FA377B9D3--

