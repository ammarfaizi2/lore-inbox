Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316900AbSFQRrN>; Mon, 17 Jun 2002 13:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316903AbSFQRrM>; Mon, 17 Jun 2002 13:47:12 -0400
Received: from hera.cwi.nl ([192.16.191.8]:41973 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S316900AbSFQRrL>;
	Mon, 17 Jun 2002 13:47:11 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 17 Jun 2002 19:47:10 +0200 (MEST)
Message-Id: <UTC200206171747.g5HHlA415420.aeb@smtp.cwi.nl>
To: torvalds@transmeta.com
Subject: [PATCH] small makefile correction
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- linux-2.5.22/linux/arch/i386/kernel/Makefile	Sun Jun  9 07:27:44 2002
+++ linux-2.5.22a/linux/arch/i386/kernel/Makefile	Mon Jun 17 19:43:58 2002
@@ -15,7 +15,6 @@
 
 obj-y				+= cpu/
 obj-$(CONFIG_MCA)		+= mca.o
-obj-$(CONFIG_EISA)		+= eisa.o
 obj-$(CONFIG_MTRR)		+= mtrr.o
 obj-$(CONFIG_X86_MSR)		+= msr.o
 obj-$(CONFIG_X86_CPUID)		+= cpuid.o
