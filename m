Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318757AbSH1Hss>; Wed, 28 Aug 2002 03:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318758AbSH1Hss>; Wed, 28 Aug 2002 03:48:48 -0400
Received: from dp.samba.org ([66.70.73.150]:54965 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S318757AbSH1Hsq>;
	Wed, 28 Aug 2002 03:48:46 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: James Simmons <jsimmons@transvirtual.com>, geert@linux-m68k.org
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [PATCH] Makefile typo
Date: Wed, 28 Aug 2002 17:31:10 +1000
Message-Id: <20020828025328.CDF062C134@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

s/cfbimgblit/cfbimgblt/

Rusty.

--- working-2.5.32-hotcpu-cpudown-ppc/drivers/video/Makefile.~1~	2002-08-28 09:29:47.000000000 +1000
+++ working-2.5.32-hotcpu-cpudown-ppc/drivers/video/Makefile	2002-08-28 17:28:23.000000000 +1000
@@ -60,7 +60,7 @@
 obj-$(CONFIG_FB_3DFX)             += tdfxfb.o
 obj-$(CONFIG_FB_MAC)              += macfb.o macmodes.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o 
 obj-$(CONFIG_FB_HP300)            += hpfb.o cfbfillrect.o cfbimgblt.o
-obj-$(CONFIG_FB_OF)               += offb.o cfbfillrect.o cfbimgblit.o cfbcopyarea.o
+obj-$(CONFIG_FB_OF)               += offb.o cfbfillrect.o cfbimgblt.o cfbcopyarea.o
 obj-$(CONFIG_FB_IMSTT)            += imsttfb.o
 obj-$(CONFIG_FB_RETINAZ3)         += retz3fb.o
 obj-$(CONFIG_FB_CLGEN)            += clgenfb.o

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
