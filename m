Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262470AbULCUAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262470AbULCUAA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 15:00:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262496AbULCTxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 14:53:09 -0500
Received: from pool-151-203-6-248.bos.east.verizon.net ([151.203.6.248]:15108
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262469AbULCT2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 14:28:02 -0500
Message-Id: <200412032144.iB3Li3ZW004688@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, Blaisorblade <blaisorblade_spam@yahoo.it>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Subject: [PATCH] UML - export end_iomem
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 03 Dec 2004 16:44:03 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

some modules need end_iomem to be exported.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

diff -puN arch/um/kernel/ksyms.c~export-end_iomem arch/um/kernel/ksyms.c
--- linux-2.6.10-rc2/arch/um/kernel/ksyms.c~export-end_iomem	2004-11-25 16:45:34.172945074 +0100
+++ linux-2.6.10-rc2-root/arch/um/kernel/ksyms.c	2004-11-25 16:45:34.177943421 +0100
@@ -48,6 +48,7 @@ EXPORT_SYMBOL(to_virt);
 EXPORT_SYMBOL(mode_tt);
 EXPORT_SYMBOL(handle_page_fault);
 EXPORT_SYMBOL(find_iomem);
+EXPORT_SYMBOL(end_iomem);
 
 #ifdef CONFIG_MODE_TT
 EXPORT_SYMBOL(strncpy_from_user_tt);
_

