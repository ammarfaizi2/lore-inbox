Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262587AbTI1QUc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 12:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262589AbTI1QUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 12:20:32 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:61158 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262587AbTI1QU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 12:20:28 -0400
Date: Sun, 28 Sep 2003 18:20:22 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: rth@twiddle.ne
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] small alpha Kconfig cleanup
Message-ID: <20030928162022.GL15338@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

the patch below does a small arch/alpha/Kconfig cleanup without changing 
the semantics.

cu
Adrian

--- linux-2.6.0-test6-full/arch/alpha/Kconfig.old	2003-09-28 18:15:48.000000000 +0200
+++ linux-2.6.0-test6-full/arch/alpha/Kconfig	2003-09-28 18:17:16.000000000 +0200
@@ -311,8 +311,8 @@
 
 config ALPHA_EV4
 	bool
-	depends on ALPHA_JENSEN || (ALPHA_SABLE && !ALPHA_GAMMA) || ALPHA_LYNX || ALPHA_NORITAKE && !ALPHA_PRIMO || ALPHA_MIKASA && !ALPHA_PRIMO || ALPHA_CABRIOLET || ALPHA_AVANTI_CH || ALPHA_EB64P_CH || ALPHA_XL || ALPHA_NONAME || ALPHA_EB66 || ALPHA_EB66P || ALPHA_P2K
-	default y if !ALPHA_LYNX
+	depends on ALPHA_JENSEN || (ALPHA_SABLE && !ALPHA_GAMMA) || ALPHA_NORITAKE && !ALPHA_PRIMO || ALPHA_MIKASA && !ALPHA_PRIMO || ALPHA_CABRIOLET || ALPHA_AVANTI_CH || ALPHA_EB64P_CH || ALPHA_XL || ALPHA_NONAME || ALPHA_EB66 || ALPHA_EB66P || ALPHA_P2K
+	default y
 
 config ALPHA_LCA
 	bool
