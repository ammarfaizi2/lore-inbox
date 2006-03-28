Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964793AbWC1XBT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964793AbWC1XBT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 18:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbWC1W7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 17:59:10 -0500
Received: from [198.99.130.12] ([198.99.130.12]:23491 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S964788AbWC1W7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 17:59:03 -0500
Message-Id: <200603282300.k2SN0Ipq023002@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       viro@zeniv.linux.org.uk
Subject: [PATCH 9/10] UML - Remove unused make variables
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 28 Mar 2006 18:00:18 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
uml: removed assignments to unused variables in arch/um/os-Linux/Makefile

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

 arch/um/os-Linux/Makefile |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

Index: linux-2.6.16-mm/arch/um/os-Linux/Makefile
===================================================================
--- linux-2.6.16-mm.orig/arch/um/os-Linux/Makefile	2006-03-28 09:30:36.000000000 -0500
+++ linux-2.6.16-mm/arch/um/os-Linux/Makefile	2006-03-28 09:40:31.000000000 -0500
@@ -15,9 +15,6 @@ USER_OBJS := $(user-objs-y) aio.o elf_au
 	process.o sigio.o signal.o start_up.o time.o trap.o tt.o tty.o \
 	uaccess.o umid.o util.o
 
-elf_aux.o: $(ARCH_DIR)/kernel-offsets.h
-CFLAGS_elf_aux.o += -I$(objtree)/arch/um
-
 CFLAGS_user_syms.o += -DSUBARCH_$(SUBARCH)
 
 HAVE_AIO_ABI := $(shell [ -r /usr/include/linux/aio_abi.h ] && \

