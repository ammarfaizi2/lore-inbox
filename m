Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266252AbUJRJra@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266252AbUJRJra (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 05:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266096AbUJRJo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 05:44:56 -0400
Received: from out014pub.verizon.net ([206.46.170.46]:17089 "EHLO
	out014.verizon.net") by vger.kernel.org with ESMTP id S265395AbUJRJmw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 05:42:52 -0400
Message-ID: <41739019.8090002@verizon.net>
Date: Mon, 18 Oct 2004 05:42:49 -0400
From: Jim Nelson <james4765@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: More patches to arch/sparc/Kconfig [4 of 5]
Content-Type: multipart/mixed;
 boundary="------------070609000504020002060600"
X-Authentication-Info: Submitted using SMTP AUTH at out014.verizon.net from [209.158.211.53] at Mon, 18 Oct 2004 04:42:49 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070609000504020002060600
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Makes sun4 default to "N" - most SPARC32 systems did not use these.

Apply against 2.6.9-rc4.

diff -u  arch/sparc/Kconfig.orig arch/sparc/Kconfig


--------------070609000504020002060600
Content-Type: text/x-patch;
 name="arch_sparc_kconfig-fix-sun4-default.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="arch_sparc_kconfig-fix-sun4-default.patch"

--- ./arch/sparc/Kconfig.orig	2004-10-16 09:53:49.626021592 -0400
+++ ./arch/sparc/Kconfig	2004-10-16 10:09:58.304756208 -0400
@@ -222,6 +222,7 @@
 config SUN4
 	bool "Support for SUN4 machines (disables SUN4[CDM] support)"
 	depends on !SMP
+	default n
 	help
 	  Say Y here if, and only if, your machine is a sun4. Note that
 	  a kernel compiled with this option will run only on sun4.


--------------070609000504020002060600--
