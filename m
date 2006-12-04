Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967738AbWLDXQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967738AbWLDXQc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 18:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967753AbWLDXQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 18:16:29 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:47870 "EHLO
	saraswathi.solana.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759821AbWLDXQW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 18:16:22 -0500
Message-Id: <200612042312.kB4NCLHf024561@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 2/4] UML - Include asm/page.h in order to get PAGE_SHIFT
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 04 Dec 2006 18:12:21 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Include the proper header to get a definition of PAGE_SHIFT.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.17/arch/um/include/sysdep-i386/stub.h
===================================================================
--- linux-2.6.17.orig/arch/um/include/sysdep-i386/stub.h	2006-06-17 21:49:35.000000000 -0400
+++ linux-2.6.17/arch/um/include/sysdep-i386/stub.h	2006-11-13 16:41:37.000000000 -0500
@@ -9,6 +9,7 @@
 #include <sys/mman.h>
 #include <asm/ptrace.h>
 #include <asm/unistd.h>
+#include <asm/page.h>
 #include "stub-data.h"
 #include "kern_constants.h"
 #include "uml-config.h"

