Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbUGRT7c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbUGRT7c (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 15:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262380AbUGRT7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 15:59:32 -0400
Received: from web53805.mail.yahoo.com ([206.190.36.200]:15442 "HELO
	web53805.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261875AbUGRT7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 15:59:31 -0400
Message-ID: <20040718195931.8189.qmail@web53805.mail.yahoo.com>
Date: Sun, 18 Jul 2004 12:59:31 -0700 (PDT)
From: Carl Spalletta <cspalletta@yahoo.com>
Subject: [PATCH] Remove prototypes of nonexistent functions from arch/i386 files
To: lkml <linux-kernel@vger.kernel.org>
Cc: rgooch@atnf.csiro.au
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ru linux-2.6.7-orig/arch/i386/kernel/cpu/mtrr/mtrr.h
linux-2.6.7-new/arch/i386/kernel/cpu/mtrr/mtrr.h
--- linux-2.6.7-orig/arch/i386/kernel/cpu/mtrr/mtrr.h   2004-06-15 22:19:01.000000000 -0700
+++ linux-2.6.7-new/arch/i386/kernel/cpu/mtrr/mtrr.h    2004-07-18 08:54:52.000000000 -0700
@@ -52,7 +52,6 @@
 };

 extern int generic_get_free_region(unsigned long base, unsigned long size);
-extern void generic_init_secondary(void);
 extern int generic_validate_add_page(unsigned long base, unsigned long size,
                                     unsigned int type);


