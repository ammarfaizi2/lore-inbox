Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261708AbVGZFRh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261708AbVGZFRh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 01:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261722AbVGZFRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 01:17:35 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:59067 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S261708AbVGZFRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 01:17:18 -0400
Date: Tue, 26 Jul 2005 00:17:08 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org,
       linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] ppc32: Fix building of prpmc750
Message-ID: <Pine.LNX.4.61.0507260016250.7138@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Updated prpmc750 platform code to include serial_reg.h to fix building.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit c6d47b85a4f5743a0328ab6388a085744e00ac48
tree 41a83749e10e4dc70feefcd75396c8c5385b8fb1
parent dc5a25603c1f8984f10f9e93d91b4d95b2ce6d9d
author Kumar K. Gala <kumar.gala@freescale.com> Tue, 26 Jul 2005 00:12:37 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Tue, 26 Jul 2005 00:12:37 -0500

 arch/ppc/platforms/prpmc750.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/ppc/platforms/prpmc750.c b/arch/ppc/platforms/prpmc750.c
--- a/arch/ppc/platforms/prpmc750.c
+++ b/arch/ppc/platforms/prpmc750.c
@@ -29,6 +29,7 @@
 #include <linux/ide.h>
 #include <linux/root_dev.h>
 #include <linux/slab.h>
+#include <linux/serial_reg.h>
 
 #include <asm/byteorder.h>
 #include <asm/system.h>
