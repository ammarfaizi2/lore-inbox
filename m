Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130425AbRCICtT>; Thu, 8 Mar 2001 21:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130422AbRCICtK>; Thu, 8 Mar 2001 21:49:10 -0500
Received: from [194.73.73.138] ([194.73.73.138]:32440 "EHLO ruthenium")
	by vger.kernel.org with ESMTP id <S130420AbRCICtA>;
	Thu, 8 Mar 2001 21:49:00 -0500
Date: Fri, 9 Mar 2001 02:48:07 +0000 (GMT)
From: <davej@suse.de>
X-X-Sender: <davej@athlon>
To: Alan Cox <alan@redhat.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix Cyrix III build in 2.4.2-ac16.
Message-ID: <Pine.LNX.4.31.0103090231460.17952-100000@athlon>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Oops! This diff matches the config name to that which is defined
in Config.in.

regards,

Dave.

diff -urN --exclude-from=/home/davej/.exclude linux/arch/i386/Makefile linux-dj/arch/i386/Makefile
--- linux/arch/i386/Makefile	Fri Mar  9 02:26:56 2001
+++ linux-dj/arch/i386/Makefile	Fri Mar  9 02:29:47 2001
@@ -82,7 +82,7 @@
 CFLAGS += -march=i586
 endif

-ifdef CONFIG_MCELERONIII
+ifdef CONFIG_MCYRIXIII
 CFLAGS += -march=i586
 endif


-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

