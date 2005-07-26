Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262407AbVGZXuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262407AbVGZXuI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 19:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262297AbVGZXtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 19:49:14 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:19855 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S262354AbVGZXol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 19:44:41 -0400
Date: Tue, 26 Jul 2005 18:44:29 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org,
       linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] ppc32: Fix building of TQM8260 board
Message-ID: <Pine.LNX.4.61.0507261843440.9846@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Added missing include of cpm2.h in correct order to allow TQM8260 to build

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 2fd8dd75c93a89c465a08d1d0085772cad225927
tree b322bf8a4e146fe7c88e39eac88bc923ac1a567e
parent ca451627946729719d17b7e6c1376ec273a501b5
author Kumar K. Gala <kumar.gala@freescale.com> Tue, 26 Jul 2005 18:43:16 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Tue, 26 Jul 2005 18:43:16 -0500

 arch/ppc/platforms/tqm8260_setup.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/ppc/platforms/tqm8260_setup.c b/arch/ppc/platforms/tqm8260_setup.c
--- a/arch/ppc/platforms/tqm8260_setup.c
+++ b/arch/ppc/platforms/tqm8260_setup.c
@@ -16,8 +16,8 @@
 
 #include <linux/init.h>
 
-#include <asm/immap_cpm2.h>
 #include <asm/mpc8260.h>
+#include <asm/cpm2.h>
 #include <asm/machdep.h>
 
 static int
