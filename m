Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261694AbUJ1PMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261694AbUJ1PMc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 11:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261712AbUJ1PIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 11:08:17 -0400
Received: from out007pub.verizon.net ([206.46.170.107]:31395 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S261697AbUJ1PBP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 11:01:15 -0400
From: james4765@verizon.net
To: kernel-janitors@lists.osdl.org
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, james4765@verizon.net
Message-Id: <20041028150111.2776.47585.86377@localhost.localdomain>
In-Reply-To: <20041028150029.2776.69333.50087@localhost.localdomain>
References: <20041028150029.2776.69333.50087@localhost.localdomain>
Subject: [PATCH 7/9] to arch/sparc/Kconfig
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [209.158.211.53] at Thu, 28 Oct 2004 10:01:11 -0500
Date: Thu, 28 Oct 2004 10:01:12 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description: Add default for SUN4 in arch/sparc/Kconfig.
Apply against 2.6.9.

Signed-off by: James Nelson <james4765@gmail.com>

diff -u ./arch/sparc/Kconfig.orig ./arch/sparc/Kconfig
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
