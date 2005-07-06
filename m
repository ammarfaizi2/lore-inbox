Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262100AbVGFCqQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbVGFCqQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 22:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbVGFCln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 22:41:43 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:6809 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262061AbVGFCTW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 22:19:22 -0400
Subject: [PATCH] [23/48] Suspend2 2.1.9.8 for 2.6.12: 600-suspend-header.patch
In-Reply-To: <11206164393426@foobar.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 6 Jul 2005 12:20:41 +1000
Message-Id: <11206164411219@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Nigel Cunningham <nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruNp 601-kernel_power_power-header.patch-old/kernel/power/power.h 601-kernel_power_power-header.patch-new/kernel/power/power.h
--- 601-kernel_power_power-header.patch-old/kernel/power/power.h	2005-07-06 11:29:15.000000000 +1000
+++ 601-kernel_power_power-header.patch-new/kernel/power/power.h	2005-07-04 23:14:19.000000000 +1000
@@ -1,6 +1,8 @@
 #include <linux/suspend.h>
 #include <linux/utsname.h>
 
+#include "suspend.h"
+
 /* With SUSPEND_CONSOLE defined, it suspend looks *really* cool, but
    we probably do not take enough locks for switching consoles, etc,
    so bad things might happen.

