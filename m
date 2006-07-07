Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbWGGAev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbWGGAev (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 20:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbWGGAeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 20:34:24 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:52163 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751108AbWGGAdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 20:33:47 -0400
Message-Id: <200607070033.k670XsOL008747@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 18/19] UML - Remove unused variable
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 06 Jul 2006 20:33:54 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The dedevfsification of UML left an unused variable behind.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.17/arch/um/drivers/ubd_kern.c
===================================================================
--- linux-2.6.17.orig/arch/um/drivers/ubd_kern.c	2006-07-06 13:22:13.000000000 -0400
+++ linux-2.6.17/arch/um/drivers/ubd_kern.c	2006-07-06 15:36:44.000000000 -0400
@@ -627,7 +627,6 @@ static int ubd_new_disk(int major, u64 s
 			
 {
 	struct gendisk *disk;
-	int err;
 
 	disk = alloc_disk(1 << UBD_SHIFT);
 	if(disk == NULL)

