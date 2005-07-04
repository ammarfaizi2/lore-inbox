Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261604AbVGDK4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbVGDK4A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 06:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbVGDKz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 06:55:59 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:63937 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S261613AbVGDKxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 06:53:44 -0400
Date: Mon, 4 Jul 2005 12:53:36 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Bodo Eggert <7eggert@gmx.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kconfig changes 4: s/menu/menuconfig/ profiling menu
In-Reply-To: <Pine.LNX.4.58.0507041231200.6165@be1.lrz>
Message-ID: <Pine.LNX.4.58.0507041251220.8687@be1.lrz>
References: <Pine.LNX.4.58.0506301152460.11960@be1.lrz>
 <Pine.LNX.4.58.0507041134410.3798@be1.lrz> <Pine.LNX.4.58.0507041210190.6165@be1.lrz>
 <Pine.LNX.4.58.0507041231200.6165@be1.lrz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Part 4: The profiling menu.

In many config submenus, the first menu option will enable the rest 
of the menu options. For these menus, It's appropriate to use the more 
convenient "menuconfig" keyword.

This patch is designed for 2.6.12 and .13-rc1


--- a/./arch/sh/oprofile/Kconfig	2004-08-14 07:36:14.000000000 +0200
+++ b/./arch/sh/oprofile/Kconfig	2005-07-04 12:45:58.000000000 +0200
@@ -1,9 +1,6 @@
-
-menu "Profiling support"
-	depends on EXPERIMENTAL
-
-config PROFILING
+menuconfig PROFILING
 	bool "Profiling support (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
 	help
 	  Say Y here to enable the extended profiling support mechanisms used
 	  by profilers such as OProfile.
@@ -19,5 +16,3 @@ config OPROFILE
 
 	  If unsure, say N.
 
-endmenu
-
--- a/./arch/arm/oprofile/Kconfig	2004-08-14 07:36:57.000000000 +0200
+++ b/./arch/arm/oprofile/Kconfig	2005-07-04 12:46:17.000000000 +0200
@@ -1,9 +1,6 @@
-
-menu "Profiling support"
-	depends on EXPERIMENTAL
-
-config PROFILING
+menuconfig PROFILING
 	bool "Profiling support (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
 	help
 	  Say Y here to enable the extended profiling support mechanisms used
 	  by profilers such as OProfile.
@@ -18,6 +15,3 @@ config OPROFILE
 	  and applications.
 
 	  If unsure, say N.
-
-endmenu
-
--- a/./arch/ppc/oprofile/Kconfig	2004-08-14 07:36:32.000000000 +0200
+++ b/./arch/ppc/oprofile/Kconfig	2005-07-04 12:46:35.000000000 +0200
@@ -1,9 +1,6 @@
-
-menu "Profiling support"
-	depends on EXPERIMENTAL
-
-config PROFILING
+menuconfig PROFILING
 	bool "Profiling support (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
 	help
 	  Say Y here to enable the extended profiling support mechanisms used
 	  by profilers such as OProfile.
@@ -18,6 +15,3 @@ config OPROFILE
 	  and applications.
 
 	  If unsure, say N.
-
-endmenu
-
--- a/./arch/i386/oprofile/Kconfig	2004-08-14 07:36:59.000000000 +0200
+++ b/./arch/i386/oprofile/Kconfig	2005-07-04 12:46:56.000000000 +0200
@@ -1,9 +1,6 @@
-
-menu "Profiling support"
-	depends on EXPERIMENTAL
-
-config PROFILING
+menuconfig PROFILING
 	bool "Profiling support (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
 	help
 	  Say Y here to enable the extended profiling support mechanisms used
 	  by profilers such as OProfile.
@@ -18,6 +15,3 @@ config OPROFILE
 	  and applications.
 
 	  If unsure, say N.
-
-endmenu
-
--- a/./arch/m32r/oprofile/Kconfig	2005-05-02 02:23:53.000000000 +0200
+++ b/./arch/m32r/oprofile/Kconfig	2005-07-04 12:47:10.000000000 +0200
@@ -1,9 +1,6 @@
-
-menu "Profiling support"
-	depends on EXPERIMENTAL
-
-config PROFILING
+menuconfig PROFILING
 	bool "Profiling support (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
 	help
 	  Say Y here to enable the extended profiling support mechanisms used
 	  by profilers such as OProfile.
@@ -18,6 +15,3 @@ config OPROFILE
 	  and applications.
 
 	  If unsure, say N.
-
-endmenu
-
--- a/./arch/ia64/oprofile/Kconfig	2005-05-02 02:23:53.000000000 +0200
+++ b/./arch/ia64/oprofile/Kconfig	2005-07-04 12:47:27.000000000 +0200
@@ -1,9 +1,6 @@
-
-menu "Profiling support"
-	depends on EXPERIMENTAL
-
-config PROFILING
+menuconfig PROFILING
 	bool "Profiling support (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
 	help
 	  Say Y here to enable the extended profiling support mechanisms used
 	  by profilers such as OProfile.
@@ -21,6 +18,3 @@ config OPROFILE
 	  counters.
 
 	  If unsure, say N.
-
-endmenu
-
--- a/./arch/mips/oprofile/Kconfig	2005-05-02 02:25:32.000000000 +0200
+++ b/./arch/mips/oprofile/Kconfig	2005-07-04 12:47:42.000000000 +0200
@@ -1,9 +1,6 @@
-
-menu "Profiling support"
-	depends on EXPERIMENTAL
-
-config PROFILING
+menuconfig PROFILING
 	bool "Profiling support (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
 	help
 	  Say Y here to enable the extended profiling support mechanisms used
 	  by profilers such as OProfile.
@@ -18,6 +15,3 @@ config OPROFILE
 	  and applications.
 
 	  If unsure, say N.
-
-endmenu
-
--- a/./arch/s390/oprofile/Kconfig	2005-06-19 14:16:18.000000000 +0200
+++ b/./arch/s390/oprofile/Kconfig	2005-07-04 12:47:56.000000000 +0200
@@ -1,7 +1,4 @@
-
-menu "Profiling support"
-
-config PROFILING
+menuconfig PROFILING
 	bool "Profiling support"
 	help
 	  Say Y here to enable profiling support mechanisms used by
@@ -17,6 +14,3 @@ config OPROFILE
 	  and applications.
 
 	  If unsure, say N.
-
-endmenu
-
--- a/./arch/sh64/oprofile/Kconfig	2004-08-14 07:36:12.000000000 +0200
+++ b/./arch/sh64/oprofile/Kconfig	2005-07-04 12:48:09.000000000 +0200
@@ -1,9 +1,6 @@
-
-menu "Profiling support"
-	depends on EXPERIMENTAL
-
-config PROFILING
+menuconfig PROFILING
 	bool "Profiling support (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
 	help
 	  Say Y here to enable the extended profiling support mechanisms used
 	  by profilers such as OProfile.
@@ -18,6 +15,3 @@ config OPROFILE
 	  and applications.
 
 	  If unsure, say N.
-
-endmenu
-
--- a/./arch/alpha/oprofile/Kconfig	2004-08-14 07:36:56.000000000 +0200
+++ b/./arch/alpha/oprofile/Kconfig	2005-07-04 12:48:23.000000000 +0200
@@ -1,9 +1,6 @@
-
-menu "Profiling support"
-	depends on EXPERIMENTAL
-
-config PROFILING
+menuconfig PROFILING
 	bool "Profiling support (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
 	help
 	  Say Y here to enable the extended profiling support mechanisms used
 	  by profilers such as OProfile.
@@ -18,6 +15,3 @@ config OPROFILE
 	  and applications.
 
 	  If unsure, say N.
-
-endmenu
-
--- a/./arch/ppc64/oprofile/Kconfig	2004-08-14 07:36:17.000000000 +0200
+++ b/./arch/ppc64/oprofile/Kconfig	2005-07-04 12:48:40.000000000 +0200
@@ -1,9 +1,6 @@
-
-menu "Profiling support"
-	depends on EXPERIMENTAL
-
-config PROFILING
+menuconfig PROFILING
 	bool "Profiling support (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
 	help
 	  Say Y here to enable the extended profiling support mechanisms used
 	  by profilers such as OProfile.
@@ -18,6 +15,3 @@ config OPROFILE
 	  and applications.
 
 	  If unsure, say N.
-
-endmenu
-
--- a/./arch/sparc64/oprofile/Kconfig	2004-08-14 07:37:55.000000000 +0200
+++ b/./arch/sparc64/oprofile/Kconfig	2005-07-04 12:48:55.000000000 +0200
@@ -1,9 +1,6 @@
-
-menu "Profiling support"
-	depends on EXPERIMENTAL
-
-config PROFILING
+menuconfig PROFILING
 	bool "Profiling support (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
 	help
 	  Say Y here to enable the extended profiling support mechanisms used
 	  by profilers such as OProfile.
@@ -18,6 +15,3 @@ config OPROFILE
 	  and applications.
 
 	  If unsure, say N.
-
-endmenu
-
--- a/./arch/parisc/oprofile/Kconfig	2004-08-14 07:37:38.000000000 +0200
+++ b/./arch/parisc/oprofile/Kconfig	2005-07-04 12:49:10.000000000 +0200
@@ -1,9 +1,6 @@
-
-menu "Profiling support"
-	depends on EXPERIMENTAL
-
-config PROFILING
+menuconfig PROFILING
 	bool "Profiling support (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
 	help
 	  Say Y here to enable the extended profiling support mechanisms used
 	  by profilers such as OProfile.
@@ -18,6 +15,3 @@ config OPROFILE
 	  and applications.
 
 	  If unsure, say N.
-
-endmenu
-
--- a/./arch/x86_64/oprofile/Kconfig	2004-08-14 07:37:25.000000000 +0200
+++ b/./arch/x86_64/oprofile/Kconfig	2005-07-04 12:49:23.000000000 +0200
@@ -1,9 +1,6 @@
-
-menu "Profiling support"
-	depends on EXPERIMENTAL
-
-config PROFILING
+menuconfig PROFILING
 	bool "Profiling support (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
 	help
 	  Say Y here to enable the extended profiling support mechanisms used
 	  by profilers such as OProfile.
@@ -18,6 +15,3 @@ config OPROFILE
 	  and applications.
 
 	  If unsure, say N.
-
-endmenu
-
-- 
Top 100 things you don't want the sysadmin to say:
85. It didn't do that a minute ago...
