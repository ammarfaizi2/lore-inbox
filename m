Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316853AbSFVJhH>; Sat, 22 Jun 2002 05:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316854AbSFVJhG>; Sat, 22 Jun 2002 05:37:06 -0400
Received: from pcp01179415pcs.strl1201.mi.comcast.net ([68.60.208.36]:9973
	"EHLO mythical") by vger.kernel.org with ESMTP id <S316853AbSFVJhF>;
	Sat, 22 Jun 2002 05:37:05 -0400
Date: Sat, 22 Jun 2002 05:37:03 -0400 (EDT)
From: Ryan Anderson <ryan@michonline.com>
To: perex@suse.cz
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] ad1848_lib.c compile fix
Message-ID: <Pine.LNX.4.10.10206220534460.15937-100000@mythical.michonline.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's a trivial compile fix for sounds/isa/ad1848/ad1848_lib.c against
2.5.24

--- ./sound/isa/ad1848/ad1848_lib.c.orig	Tue Jun 18 22:11:53 2002
+++ ./sound/isa/ad1848/ad1848_lib.c	Sat Jun 22 03:48:37 2002
@@ -20,6 +20,7 @@
  */
 
 #define SNDRV_MAIN_OBJECT_FILE
+#include <linux/init.h>
 #include <sound/driver.h>
 #include <asm/io.h>
 #include <asm/dma.h>

--
Ryan Anderson
  sometimes Pug Majere

