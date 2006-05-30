Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbWE3JBl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbWE3JBl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 05:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbWE3JBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 05:01:41 -0400
Received: from mail.linicks.net ([217.204.244.146]:34241 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S932195AbWE3JBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 05:01:40 -0400
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Trivial typo fixes to arch/i386/Kconfig
Date: Tue, 30 May 2006 10:01:38 +0100
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605301001.38734.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Missing double quotes on two source lines - applied to 2.6.16.18.

Nick


--- arch/i386/KconfigORIG	2006-05-05 22:06:10.000000000 +0100
+++ arch/i386/Kconfig	2006-05-30 09:55:36.000000000 +0100
@@ -685,7 +685,7 @@
 
 	  If unsure, say Y. Only embedded should say N here.
 
-source kernel/Kconfig.hz
+source "kernel/Kconfig.hz"
 
 config KEXEC
 	bool "kexec system call (EXPERIMENTAL)"
@@ -755,7 +755,7 @@
 menu "Power management options (ACPI, APM)"
 	depends on !X86_VOYAGER
 
-source kernel/power/Kconfig
+source "kernel/power/Kconfig"
 
 source "drivers/acpi/Kconfig"
 

-- 
"Person who say it cannot be done should not interrupt person doing it."
-Chinese Proverb
