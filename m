Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261903AbVAHJv3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261903AbVAHJv3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 04:51:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbVAHJsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 04:48:38 -0500
Received: from pop.gmx.net ([213.165.64.20]:54150 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261829AbVAHJqJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 04:46:09 -0500
X-Authenticated: #12437197
Date: Sat, 8 Jan 2005 11:49:18 +0200
From: Dan Aloni <da-x@gmx.net>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [PATCH] make mrproper to clean scripts/kconfig/libkconfig.so
Message-ID: <20050108094918.GA19474@callisto.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Dan Aloni <da-x@gmx.net>

--- linux-2.6.10/scripts/kconfig/Makefile	2004-12-25 11:52:42.000000000 +0200
+++ linux-2.6.10/scripts/kconfig/Makefile	2005-01-08 11:31:37.000000000 +0200
@@ -91,7 +91,7 @@
 gconf-objs	:= gconf.o kconfig_load.o zconf.tab.o
 endif
 
-clean-files	:= lkc_defs.h qconf.moc .tmp_qtcheck \
+clean-files	:= lkc_defs.h qconf.moc .tmp_qtcheck libkconfig.so \
 		   .tmp_gtkcheck zconf.tab.c zconf.tab.h lex.zconf.c
 
 # generated files seem to need this to find local include files


-- 
Dan Aloni
da-x@gmx.net
