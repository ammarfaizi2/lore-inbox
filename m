Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261203AbVC2Qdu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbVC2Qdu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 11:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbVC2Qdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 11:33:50 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:50874 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S261203AbVC2Qds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 11:33:48 -0500
Date: Tue, 29 Mar 2005 10:33:25 -0600 (CST)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@blarg.somerset.sps.mot.com
To: Andrew Morton <akpm@osdl.org>
cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>,
       linux-kernel@vger.kernel.org,
       Jason McMullan <jason.mcmullan@timesys.com>
Subject: [PATCH] ppc32: Fix MPC8555 & MPC8555E device lists
Message-ID: <Pine.LNX.4.61.0503291027540.15390@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Removed the FCC3 device from the lists of devices on MPC8555 & MPC8555E 
since it does not exist on these processors.

Signed-off-by: Jason McMullan <jason.mcmullan@timesys.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---

diff -Nru a/arch/ppc/syslib/mpc85xx_sys.c b/arch/ppc/syslib/mpc85xx_sys.c
--- a/arch/ppc/syslib/mpc85xx_sys.c	2005-03-29 10:26:41 -06:00
+++ b/arch/ppc/syslib/mpc85xx_sys.c	2005-03-29 10:26:41 -06:00
@@ -88,7 +88,7 @@
 			MPC85xx_PERFMON, MPC85xx_DUART,
 			MPC85xx_CPM_SPI, MPC85xx_CPM_I2C, MPC85xx_CPM_SCC1,
 			MPC85xx_CPM_SCC2, MPC85xx_CPM_SCC3,
-			MPC85xx_CPM_FCC1, MPC85xx_CPM_FCC2, MPC85xx_CPM_FCC3,
+			MPC85xx_CPM_FCC1, MPC85xx_CPM_FCC2,
 			MPC85xx_CPM_SMC1, MPC85xx_CPM_SMC2,
 			MPC85xx_CPM_USB,
 		},
@@ -105,7 +105,7 @@
 			MPC85xx_PERFMON, MPC85xx_DUART, MPC85xx_SEC2,
 			MPC85xx_CPM_SPI, MPC85xx_CPM_I2C, MPC85xx_CPM_SCC1,
 			MPC85xx_CPM_SCC2, MPC85xx_CPM_SCC3,
-			MPC85xx_CPM_FCC1, MPC85xx_CPM_FCC2, MPC85xx_CPM_FCC3,
+			MPC85xx_CPM_FCC1, MPC85xx_CPM_FCC2,
 			MPC85xx_CPM_SMC1, MPC85xx_CPM_SMC2,
 			MPC85xx_CPM_USB,
 		},


