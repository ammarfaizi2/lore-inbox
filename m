Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261673AbVGDM6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbVGDM6c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 08:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbVGDM6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 08:58:31 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:18311 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S261673AbVGDMxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 08:53:48 -0400
Date: Mon, 4 Jul 2005 14:53:36 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Bodo Eggert <7eggert@gmx.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kconfig changes 4: s/menu/menuconfig/ CPU scaling menu
In-Reply-To: <Pine.LNX.4.58.0507041231200.6165@be1.lrz>
Message-ID: <Pine.LNX.4.58.0507041451550.11818@be1.lrz>
References: <Pine.LNX.4.58.0506301152460.11960@be1.lrz>
 <Pine.LNX.4.58.0507041134410.3798@be1.lrz> <Pine.LNX.4.58.0507041210190.6165@be1.lrz>
 <Pine.LNX.4.58.0507041231200.6165@be1.lrz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Part 4b: The CPU scaling menu.

In many config submenus, the first menu option will enable the rest 
of the menu options. For these menus, It's appropriate to use the more 
convenient "menuconfig" keyword.

This patch applies to 2.6.12 and 2.6.13-rc1

--- x/drivers/cpufreq/Kconfig	2005-07-04 13:50:17.000000000 +0200
+++ b/drivers/cpufreq/Kconfig	2005-07-04 12:25:21.000000000 +0200
@@ -1,4 +1,4 @@
-config CPU_FREQ
+menuconfig CPU_FREQ
 	bool "CPU Frequency scaling"
 	help
 	  CPU Frequency scaling allows you to change the clock speed of 

-- 
Top 100 things you don't want the sysadmin to say:
5. Just add yourself to the password file and make a directory...
