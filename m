Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261831AbSI2W0c>; Sun, 29 Sep 2002 18:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261834AbSI2W0c>; Sun, 29 Sep 2002 18:26:32 -0400
Received: from dc-mx11.cluster1.charter.net ([209.225.8.21]:36817 "EHLO
	dc-mx11.cluster1.charter.net") by vger.kernel.org with ESMTP
	id <S261831AbSI2W0a> convert rfc822-to-8bit; Sun, 29 Sep 2002 18:26:30 -0400
Content-Type: text/plain; charset=US-ASCII
From: "Cory 'G' Watson" <gphat@cafes.net>
To: torvalds@transmeta.com
Subject: [PATCH] Broken Makefile for ppc in 2.5.39
Date: Sun, 29 Sep 2002 17:28:18 +0000
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209291704.49988.gphat@cafes.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This trivial patch fixes the line break in arch/ppc/Makefile:57, please apply.

-- 
Cory 'G' Watson

--- linus-2.5/arch/ppc/Makefile 2002-09-29 16:53:10.000000000 +0000
+++ g-2.5/arch/ppc/Makefile     2002-09-29 16:50:55.000000000 +0000
@@ -53,8 +53,7 @@
   endif
 endif

-core-y                         += arch/ppc/kernel/ arch/ppc/platforms/
-                                  arch/ppc/mm/     arch/ppc/lib/
+core-y                         += arch/ppc/kernel/ arch/ppc/platforms/ 
arch/ppc/mm/ arch/ppc/lib/
 core-$(CONFIG_MATH_EMULATION)  += arch/ppc/math-emu/
 core-$(CONFIG_XMON)            += arch/ppc/xmon/
 core-$(CONFIG_APUS)            += arch/ppc/amiga/
