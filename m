Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261839AbVEZWfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261839AbVEZWfq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 18:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbVEZWfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 18:35:45 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:24337 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261839AbVEZWfl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 18:35:41 -0400
Message-Id: <200505262230.j4QMUVwq014693@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org, torvalds@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 5/7] UML - single-space a help message
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 26 May 2005 18:30:31 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One of the ubd driver help strings was bust.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11/arch/um/drivers/ubd_kern.c
===================================================================
--- linux-2.6.11.orig/arch/um/drivers/ubd_kern.c	2005-05-26 17:17:01.000000000 -0400
+++ linux-2.6.11/arch/um/drivers/ubd_kern.c	2005-05-26 17:23:52.000000000 -0400
@@ -439,9 +439,9 @@ static int udb_setup(char *str)
 __setup("udb", udb_setup);
 __uml_help(udb_setup,
 "udb\n"
-"    This option is here solely to catch ubd -> udb typos, which can be\n\n"
-"    to impossible to catch visually unless you specifically look for\n\n"
-"    them.  The only result of any option starting with 'udb' is an error\n\n"
+"    This option is here solely to catch ubd -> udb typos, which can be\n"
+"    to impossible to catch visually unless you specifically look for\n"
+"    them.  The only result of any option starting with 'udb' is an error\n"
 "    in the boot output.\n\n"
 );
 

