Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267953AbUIWBSc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267953AbUIWBSc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 21:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267940AbUIWBSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 21:18:32 -0400
Received: from [12.177.129.25] ([12.177.129.25]:1732 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S267953AbUIWBRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 21:17:25 -0400
Message-Id: <200409230222.i8N2MfiF004275@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, blaisorblade_spam@yahoo.it
Subject: [PATCH] UML - linker script cleanup
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 22 Sep 2004 22:22:41 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From "D. Bahi" @ enterasys.com - remove an unneeded line from the dynamic
linker script.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.9-rc2-mm1-orig/arch/um/kernel/dyn.lds.S
===================================================================
--- linux-2.6.9-rc2-mm1-orig.orig/arch/um/kernel/dyn.lds.S	2004-09-22 19:51:41.000000000 -0400
+++ linux-2.6.9-rc2-mm1-orig/arch/um/kernel/dyn.lds.S	2004-09-22 20:22:42.000000000 -0400
@@ -5,9 +5,6 @@
 ENTRY(_start)
 jiffies = jiffies_64;
 
-SEARCH_DIR("/usr/local/i686-pc-linux-gnu/lib"); SEARCH_DIR("/usr/local/lib"); SEARCH_DIR("/lib"); SEARCH_DIR("/usr/lib");
-/* Do we need any of these for elf?
-   __DYNAMIC = 0;    */
 SECTIONS
 {
   . = START + SIZEOF_HEADERS;

