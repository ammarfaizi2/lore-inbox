Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbUDCEOO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 23:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261576AbUDCEOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 23:14:14 -0500
Received: from waste.org ([209.173.204.2]:3308 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261468AbUDCEON (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 23:14:13 -0500
Date: Fri, 2 Apr 2004 22:14:06 -0600
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] improve CONFIG_EMBEDDED help text
Message-ID: <20040403041406.GU6248@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Make CONFIG_EMBEDDED description more accurate

Index: tiny/init/Kconfig
===================================================================
--- tiny.orig/init/Kconfig	2004-03-25 14:09:38.000000000 -0600
+++ tiny/init/Kconfig	2004-03-25 15:49:17.000000000 -0600
@@ -183,12 +183,12 @@
 
 
 menuconfig EMBEDDED
-	bool "Remove kernel features (for embedded systems)"
+	bool "Configure standard kernel features (for small systems)"
 	help
-	  This option allows certain base kernel features to be removed from
-	  the build.  This is for specialized environments which can tolerate
-	  a "non-standard" kernel.  Only use this if you really know what you
-	  are doing.
+	  This option allows certain base kernel options and settings
+          to be disabled or tweaked. This is for specialized
+          environments which can tolerate a "non-standard" kernel.
+          Only use this if you really know what you are doing.
 
 config KALLSYMS
 	 bool "Load all symbols for debugging/kksymoops" if EMBEDDED

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
