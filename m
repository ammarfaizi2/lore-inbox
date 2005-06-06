Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261738AbVFFX4G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261738AbVFFX4G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 19:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261771AbVFFXzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 19:55:35 -0400
Received: from rav-az.mvista.com ([65.200.49.157]:49184 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S261738AbVFFXwg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 19:52:36 -0400
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: [PATCH][RIO] -mm: ppc32 EXPORT_SYMBOL_GPL conversions
In-Reply-To: <11181019442715@foobar.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 6 Jun 2005 16:52:24 -0700
Message-Id: <11181019442621@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Matt Porter <mporter@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert PPC32/MPC85xx EXPORT_SYMBOL->EXPORT_SYMBOL_GPL.

Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

commit 113049d95f681dcb7317d7c641cc180634b35a1d
tree fe55ba09ede44aac1dfb0c416143ea3b4a8ca9a2
parent 7127e712a4aac828daecd47be8a0d15b3977a5e0
author Matt Porter <mporter@kernel.crashing.org> Mon, 06 Jun 2005 10:26:57 -0700
committer Matt Porter <mporter@kernel.crashing.org> Mon, 06 Jun 2005 10:26:57 -0700

 arch/ppc/syslib/ppc85xx_rio.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/ppc/syslib/ppc85xx_rio.c b/arch/ppc/syslib/ppc85xx_rio.c
--- a/arch/ppc/syslib/ppc85xx_rio.c
+++ b/arch/ppc/syslib/ppc85xx_rio.c
@@ -341,7 +341,7 @@ rio_hw_add_outb_message(struct rio_mport
 	return ret;
 }
 
-EXPORT_SYMBOL(rio_hw_add_outb_message);
+EXPORT_SYMBOL_GPL(rio_hw_add_outb_message);
 
 /**
  * mpc85xx_rio_tx_handler - MPC85xx outbound message interrupt handler
@@ -637,7 +637,7 @@ int rio_hw_add_inb_buffer(struct rio_mpo
 	return rc;
 }
 
-EXPORT_SYMBOL(rio_hw_add_inb_buffer);
+EXPORT_SYMBOL_GPL(rio_hw_add_inb_buffer);
 
 /**
  * rio_hw_get_inb_message - Fetch inbound message from the MPC85xx message unit
@@ -684,7 +684,7 @@ void *rio_hw_get_inb_message(struct rio_
 	return buf;
 }
 
-EXPORT_SYMBOL(rio_hw_get_inb_message);
+EXPORT_SYMBOL_GPL(rio_hw_get_inb_message);
 
 /**
  * mpc85xx_rio_dbell_handler - MPC85xx doorbell interrupt handler

