Return-Path: <linux-kernel-owner+w=401wt.eu-S1751519AbWLLQYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519AbWLLQYl (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 11:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751530AbWLLQYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 11:24:37 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3411 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751523AbWLLQYf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 11:24:35 -0500
Date: Tue, 12 Dec 2006 17:24:45 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] arch/i386/kernel/e820.c should #include <asm/setup.h
Message-ID: <20061212162445.GY28443@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Every file should #include the headers containing the prototypes for 
its global functions.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.19-mm1/arch/i386/kernel/e820.c.old	2006-12-12 16:07:06.000000000 +0100
+++ linux-2.6.19-mm1/arch/i386/kernel/e820.c	2006-12-12 16:07:19.000000000 +0100
@@ -14,6 +14,7 @@
 #include <asm/pgtable.h>
 #include <asm/page.h>
 #include <asm/e820.h>
+#include <asm/setup.h>
 
 #ifdef CONFIG_EFI
 int efi_enabled = 0;

