Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263060AbUKTB1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263060AbUKTB1p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 20:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263067AbUKTB1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 20:27:43 -0500
Received: from linaeum.absolutedigital.net ([63.87.232.45]:49609 "EHLO
	linaeum.absolutedigital.net") by vger.kernel.org with ESMTP
	id S263060AbUKTB0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 20:26:55 -0500
Date: Fri, 19 Nov 2004 20:27:00 -0500 (EST)
From: Cal Peake <cp@absolutedigital.net>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix typo in init/Kconfig
Message-ID: <Pine.LNX.4.61.0411192021240.16438@linaeum.absolutedigital.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Patch below fixes a typo in init/Kconfig for option CC_ALIGN_FUNCTIONS.

-- Cal

Signed-off-by: Cal Peake <cp@absolutedigital.net>

--- linux-2.6.10-rc2-bk4/init/Kconfig	2004-11-19 19:47:46.000000000 -0500
+++ linux-2.6.10-rc2-bk4-cp1/init/Kconfig	2004-11-19 20:18:33.000000000 -0500
@@ -326,7 +326,7 @@
 	  which may be appropriate on small systems without swap.
 
 config CC_ALIGN_FUNCTIONS
-	int "Function alignment" if EMBDEDDED
+	int "Function alignment" if EMBEDDED
 	default 0
 	help
 	  Align the start of functions to the next power-of-two greater than n,
