Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268847AbUH3TpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268847AbUH3TpZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 15:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268883AbUH3TpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 15:45:24 -0400
Received: from ppp-62-11-78-150.dialup.tiscali.it ([62.11.78.150]:60545 "EHLO
	zion.localdomain") by vger.kernel.org with ESMTP id S268847AbUH3TpS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 15:45:18 -0400
Subject: [patch 3/3] uml-remove-LDFLAGS_BLOB
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Mon, 30 Aug 2004 16:10:53 +0200
Message-Id: <20040830141053.4DBB7529B@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


LDFLAGS_BLOB is now unused, so remove it from UML.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 uml-linux-2.6.8.1-paolo/arch/um/Makefile-i386 |    1 -
 1 files changed, 1 deletion(-)

diff -puN arch/um/Makefile-i386~uml-remove-LDFLAGS_BLOB arch/um/Makefile-i386
--- uml-linux-2.6.8.1/arch/um/Makefile-i386~uml-remove-LDFLAGS_BLOB	2004-08-29 14:40:58.781275664 +0200
+++ uml-linux-2.6.8.1-paolo/arch/um/Makefile-i386	2004-08-29 14:40:58.783275360 +0200
@@ -20,7 +20,6 @@ ELF_ARCH = $(SUBARCH)
 ELF_FORMAT = elf32-$(SUBARCH)
 
 OBJCOPYFLAGS  := -O binary -R .note -R .comment -S
-LDFLAGS_BLOB	:= --format binary --oformat elf32-i386
 
 SYS_DIR		:= $(ARCH_DIR)/include/sysdep-i386
 SYS_UTIL_DIR	:= $(ARCH_DIR)/sys-i386/util
_
