Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271313AbTG2Hmw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 03:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271317AbTG2Hmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 03:42:51 -0400
Received: from [203.145.184.221] ([203.145.184.221]:51984 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S271313AbTG2Hms (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 03:42:48 -0400
Subject: [TRIVIAL][PATCH 2.6.0-test2] Fix unused variable warning for mxser.c
From: Vinay K Nallamothu <vinay-rc@naturesoft.net>
To: trivial@rustcorp.com.au
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 29 Jul 2003 13:30:04 +0530
Message-Id: <1059465604.1299.20.camel@lima.royalchallenge.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following warnings:
drivers/char/mxser.c: In function `mxser_module_init':
drivers/char/mxser.c:501: warning: unused variable `ret2'
drivers/char/mxser.c:501: warning: unused variable `ret1'


--- linux-2.6.0-test2/drivers/char/mxser.c	2003-07-15 17:22:30.000000000 +0530
+++ linux-2.6.0-test2-nvk/drivers/char/mxser.c	2003-07-29 13:10:10.000000000 +0530
@@ -498,7 +498,6 @@
 {
 	int i, m, retval, b;
 	int n, index;
-	int ret1, ret2;
 	struct mxser_hwconf hwconf;
 
 	mxvar_sdriver = alloc_tty_driver(MXSER_PORTS + 1);

