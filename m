Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265362AbTFSD45 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 23:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265352AbTFSDzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 23:55:22 -0400
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:52100 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S265362AbTFSDyR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 23:54:17 -0400
Date: Wed, 18 Jun 2003 23:45:09 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Changes for 2.5.72
Message-ID: <20030618234509.GE333@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org
References: <20030618234418.GC333@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030618234418.GC333@neo.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1416  -> 1.1417 
#	drivers/pnp/resource.c	1.15    -> 1.16   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/06/18	ambx1@neo.rr.com	1.1417
# [PNP] Module Compilation Fix
# 
# Fixes a trivial typo in an export symbol macro.
# --------------------------------------------
#
diff -Nru a/drivers/pnp/resource.c b/drivers/pnp/resource.c
--- a/drivers/pnp/resource.c	Wed Jun 18 23:02:03 2003
+++ b/drivers/pnp/resource.c	Wed Jun 18 23:02:03 2003
@@ -469,8 +469,8 @@
 }
 
 
-EXPORT_SYMBOL(pnp_register_dependent_resource);
-EXPORT_SYMBOL(pnp_register_independent_resource);
+EXPORT_SYMBOL(pnp_register_dependent_option);
+EXPORT_SYMBOL(pnp_register_independent_option);
 EXPORT_SYMBOL(pnp_register_irq_resource);
 EXPORT_SYMBOL(pnp_register_dma_resource);
 EXPORT_SYMBOL(pnp_register_port_resource);
