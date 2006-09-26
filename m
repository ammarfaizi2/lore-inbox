Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbWIZRzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbWIZRzM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 13:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbWIZRzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 13:55:00 -0400
Received: from [198.99.130.12] ([198.99.130.12]:9891 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932220AbWIZRyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 13:54:44 -0400
Message-Id: <200609261753.k8QHrMrV005540@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH 3/5] UML - disable header exporting
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 26 Sep 2006 13:53:22 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Disable header exporting on UML since it exports no headers.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.17/include/asm-um/Kbuild
===================================================================
--- linux-2.6.17.orig/include/asm-um/Kbuild	2006-09-13 09:54:34.000000000 -0400
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1 +0,0 @@
-include include/asm-generic/Kbuild.asm

