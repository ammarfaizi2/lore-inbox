Return-Path: <linux-kernel-owner+w=401wt.eu-S965158AbWL2Xqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965158AbWL2Xqw (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 18:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965169AbWL2Xqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 18:46:52 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:45682 "EHLO
	saraswathi.solana.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965158AbWL2Xqv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 18:46:51 -0500
Message-Id: <200612292341.kBTNfSLf005539@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 3/6] UML - Console whitespace and comment tidying
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 29 Dec 2006 18:41:28 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some comment and whitespace cleanups in the console and mconsole code.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

--
 arch/um/drivers/stdio_console.c |    2 --
 arch/um/include/mconsole_kern.h |    2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)


Index: linux-2.6.18-mm/arch/um/drivers/stdio_console.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/stdio_console.c	2006-12-29 17:26:54.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/stdio_console.c	2006-12-29 18:20:43.000000000 -0500
@@ -30,8 +30,6 @@
 
 #define MAX_TTYS (16)
 
-/* ----------------------------------------------------------------------------- */
-
 /* Referenced only by tty_driver below - presumably it's locked correctly
  * by the tty driver.
  */
Index: linux-2.6.18-mm/arch/um/include/mconsole_kern.h
===================================================================
--- linux-2.6.18-mm.orig/arch/um/include/mconsole_kern.h	2006-12-29 17:26:54.000000000 -0500
+++ linux-2.6.18-mm/arch/um/include/mconsole_kern.h	2006-12-29 18:21:37.000000000 -0500
@@ -20,7 +20,7 @@ struct mc_device {
 	char *name;
 	int (*config)(char *, char **);
 	int (*get_config)(char *, char *, int, char **);
-        int (*id)(char **, int *, int *);
+	int (*id)(char **, int *, int *);
 	int (*remove)(int, char **);
 };
 

