Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265222AbUJRJgF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265222AbUJRJgF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 05:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265195AbUJRJgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 05:36:04 -0400
Received: from out007pub.verizon.net ([206.46.170.107]:44006 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S265222AbUJRJgA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 05:36:00 -0400
Message-ID: <41738E7F.4080505@verizon.net>
Date: Mon, 18 Oct 2004 05:35:59 -0400
From: Jim Nelson <james4765@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Patch to kernel/power/Kconfig
Content-Type: multipart/mixed;
 boundary="------------060202020201050704050903"
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [209.158.211.53] at Mon, 18 Oct 2004 04:35:59 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060202020201050704050903
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Fixes misspelling in kernel/power/Kconfig

Apply against 2.6.9-rc4.

diff -u  kernel/power/Kconfig.orig kernel/power/Kconfig


--------------060202020201050704050903
Content-Type: text/x-patch;
 name="typo_fix_kernel-power-Kconfig.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="typo_fix_kernel-power-Kconfig.patch"

--- kernel/power/Kconfig.orig	2004-10-16 08:58:00.312882090 -0400
+++ kernel/power/Kconfig	2004-10-16 08:58:38.811749044 -0400
@@ -29,7 +29,7 @@
 	bool "Software Suspend (EXPERIMENTAL)"
 	depends on EXPERIMENTAL && PM && SWAP
 	---help---
-	  Enable the possibilty of suspendig machine. It doesn't need APM.
+	  Enable the possibilty of suspending machine. It doesn't need APM.
 	  You may suspend your machine by 'swsusp' or 'shutdown -z <time>' 
 	  (patch for sysvinit needed). 
 


--------------060202020201050704050903--
