Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbVFZOQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbVFZOQR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 10:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbVFZOQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 10:16:14 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:31187 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S261239AbVFZOOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 10:14:50 -0400
Date: Sun, 26 Jun 2005 09:14:45 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org,
       linuxppc-embedded <linuxppc-embedded@ozlabs.org>, msm@freescale.com
Subject: [PATCH] ppc32: Fix compiling of sandpoint platform
Message-ID: <Pine.LNX.4.61.0506260914060.9741@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lost a curly brace in translation.  Everything is better now.

Signed-off-by: Matt McClintock <msm@freescale.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit fa74c2ff204f054a538f709b0b7ead0051554967
tree 7a5ce7b9f36499969eeb246331e0e0ad85178a20
parent 9316e99785fbb5da61e7a14c8bdaf5e08d3b9d72
author Kumar K. Gala <kumar.gala@freescale.com> Sun, 26 Jun 2005 10:46:40 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Sun, 26 Jun 2005 10:46:40 -0500

 arch/ppc/platforms/sandpoint.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/ppc/platforms/sandpoint.c b/arch/ppc/platforms/sandpoint.c
--- a/arch/ppc/platforms/sandpoint.c
+++ b/arch/ppc/platforms/sandpoint.c
@@ -324,6 +324,7 @@ sandpoint_setup_arch(void)
 			pdata[1].irq = 0;
 			pdata[1].mapbase = 0;
 		}
+	}
 
 	printk(KERN_INFO "Motorola SPS Sandpoint Test Platform\n");
 	printk(KERN_INFO "Port by MontaVista Software, Inc. (source@mvista.com)\n");
