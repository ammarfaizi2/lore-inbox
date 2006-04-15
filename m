Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965185AbWDOWJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965185AbWDOWJo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 18:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965183AbWDOWJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 18:09:44 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:16906 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S965185AbWDOWJn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 18:09:43 -0400
Date: Sun, 16 Apr 2006 00:09:35 +0200
From: Jean-Luc =?iso-8859-1?Q?L=E9ger?= 
	<jean-luc.leger@dspnet.fr.eu.org>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] cleanup default value of SYSCALL_DEBUG
Message-ID: <20060415220935.GB47644@dspnet.fr.eu.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Default values for boolean and tristate options can only be 'y', 'm' or 'n'.
This patch removes wrong default for SYSCALL_DEBUG.

Signed-off-by: Jean-Luc Léger <jean-luc.leger@dspnet.fr.eu.org>

Index: linux-2.6.17-rc1/arch/um/Kconfig.debug
===================================================================
--- linux-2.6.17-rc1/arch/um/Kconfig.debug.old  2006-04-15 22:16:33.000000000 +0200
+++ linux-2.6.17-rc1/arch/um/Kconfig.debug      2006-04-15 22:16:59.000000000 +0200
@@ -49,7 +49,6 @@
 
 config SYSCALL_DEBUG
 	bool "Enable system call debugging"
-	default N
 	depends on DEBUG_INFO
 	help
 	This adds some system debugging to UML, including keeping a ring buffer

