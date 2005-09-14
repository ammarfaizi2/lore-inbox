Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965018AbVINWDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965018AbVINWDk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 18:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965028AbVINWDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 18:03:25 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:57093 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S965018AbVINWDM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 18:03:12 -0400
Message-Id: <200509142156.j8ELuFl7012174@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 10/10] UML - remove include of asm/elf.h
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 14 Sep 2005 17:56:15 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

asm/elf.h is bad on x86_64, and i386 doesn't need it any more after Al's 
cleanup.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: test/arch/um/os-Linux/elf_aux.c
===================================================================
--- test.orig/arch/um/os-Linux/elf_aux.c	2005-09-14 15:47:21.000000000 -0400
+++ test/arch/um/os-Linux/elf_aux.c	2005-09-14 15:48:17.000000000 -0400
@@ -9,7 +9,6 @@
  */
 #include <elf.h>
 #include <stddef.h>
-#include <asm/elf.h>
 #include "init.h"
 #include "elf_user.h"
 #include "mem_user.h"

