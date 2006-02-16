Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932554AbWBPTYd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932554AbWBPTYd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 14:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932556AbWBPTYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 14:24:33 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:40322 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932554AbWBPTYb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 14:24:31 -0500
Date: Thu, 16 Feb 2006 11:27:25 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] i386: remove duplicate declaration of mp_bus_id_to_pci_bus
Message-ID: <20060216192725.GQ3490@sorel.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial cleanup.  mp_bus_id_to_pci_bus is declared identically twice.

Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 include/asm-i386/mpspec.h |    1 -
 1 files changed, 1 deletion(-)

diff --git a/include/asm-i386/mpspec.h b/include/asm-i386/mpspec.h
index 64a0b8e..62113d3 100644
--- a/include/asm-i386/mpspec.h
+++ b/include/asm-i386/mpspec.h
@@ -22,7 +22,6 @@ extern int mp_bus_id_to_type [MAX_MP_BUS
 extern int mp_irq_entries;
 extern struct mpc_config_intsrc mp_irqs [MAX_IRQ_SOURCES];
 extern int mpc_default_type;
-extern int mp_bus_id_to_pci_bus [MAX_MP_BUSSES];
 extern unsigned long mp_lapic_addr;
 extern int pic_mode;
 extern int using_apic_timer;
