Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262129AbVBJO6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbVBJO6z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 09:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbVBJO6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 09:58:55 -0500
Received: from mo01.iij4u.or.jp ([210.130.0.20]:47552 "EHLO mo01.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S262129AbVBJO6x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 09:58:53 -0500
Date: Thu, 10 Feb 2005 23:58:45 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.11-rc3-mm2] remove TANBAC_TB0219 doubly registered in
 kernel config
Message-Id: <20050210235845.71d588fe.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes TANBAC_TB0219 doubly registered in kernel config.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff a-orig/arch/mips/Kconfig a/arch/mips/Kconfig
--- a-orig/arch/mips/Kconfig	Thu Feb 10 21:13:55 2005
+++ a/arch/mips/Kconfig	Thu Feb 10 22:16:12 2005
@@ -1170,10 +1170,6 @@
 	depends on TOSHIBA_JMR3927 || TOSHIBA_RBTX4927
 	default y
 
-config TANBAC_TB0219
-	bool "Added TANBAC TB0219 Base board support"
-	depends on TANBAC_TB0229
-
 endmenu
 
 menu "CPU selection"
