Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264379AbTKZXWJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 18:22:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264371AbTKZXWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 18:22:09 -0500
Received: from 217-124-42-65.dialup.nuria.telefonica-data.net ([217.124.42.65]:30848
	"EHLO dardhal.mired.net") by vger.kernel.org with ESMTP
	id S264370AbTKZXWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 18:22:05 -0500
Date: Thu, 27 Nov 2003 00:22:00 +0100
From: Jose Luis Domingo Lopez <linux-net@24x7linux.com>
To: linux-net@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [2.6.0-test10-mm1] Typo in Documentation/networking/ip-sysctl.txt
Message-ID: <20031126232200.GA10178@localhost>
Mail-Followup-To: linux-net@vger.kernel.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all:

There is a small typo in Documentation/networking/ip-sysctl.txt. It
still says HZ for i386 architecture is 100, when it is no longer true.
The following patch should update it to current HZ=1000 for i386.

Although the hint following the text points to the correct place to
check for the correct value, HZ=100 for i386 is not correct in 2.6.x.

Greetings.

-- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.6.0-test10-mm1)


--- linux-2.6.0-test10-mm1/Documentation/networking/ip-sysctl.txt	2003-07-14 05:33:46.000000000 +0200
+++ linux-2.6.0-test10-mm1-patches/Documentation/networking/ip-sysctl.txt	2003-11-27 00:08:29.000000000 +0100
@@ -490,7 +490,7 @@
 	Allows you to write a number, which can be used as required.
 	Default value is 0.
 
-(1) Jiffie: internal timeunit for the kernel. On the i386 1/100s, on the
+(1) Jiffie: internal timeunit for the kernel. On the i386 1/1000s, on the
 Alpha 1/1024s. See the HZ define in /usr/include/asm/param.h for the exact
 value on your system. 
 
