Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933562AbWKQMzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933562AbWKQMzi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 07:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933567AbWKQMzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 07:55:38 -0500
Received: from main.gmane.org ([80.91.229.2]:8678 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S933562AbWKQMzh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 07:55:37 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: emacs visiting of [patch 2.6.19-rc6] Documentation/rtc.txt updates (for rtc class)
Date: Fri, 17 Nov 2006 12:55:25 +0000 (UTC)
Organization: Palacky University in Olomouc, experimental physics department.
Message-ID: <slrnelrcnc.7lr.olecom@flower.upol.cz>
References: <200611162309.31879.david-b@pacbell.net>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: flower.upol.cz
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>, Oleg Verych <olecom@flower.upol.cz>
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-11-17, David Brownell wrote:
> Index: g26/Documentation/rtc.txt

Just another emacs visiting...
Will try to build and reboot to test stuff tomorrow.

Index: 2.6_current/Documentation/rtc.txt
===================================================================
--- 2.6_current.orig/Documentation/rtc.txt	2006-11-17 13:33:10.979411250 +0100
+++ 2.6_current/Documentation/rtc.txt	2006-11-17 13:33:40.981286250 +0100
@@ -18,7 +18,7 @@
 
     *	/dev/rtc ... is the RTC provided by PC compatible systems,
 	so it's not very portable to non-x86 systems.
-    
+
     *	/dev/rtc0, /dev/rtc1 ... are part of a framework that's
 	supported by a wide variety of RTC chips on all systems.
 
@@ -86,9 +86,9 @@
 interrupt handler is only a few lines of code to minimize any possibility
 of this effect.
 
-Also, if the kernel time is synchronized with an external source, the 
-kernel will write the time back to the CMOS clock every 11 minutes. In 
-the process of doing this, the kernel briefly turns off RTC periodic 
+Also, if the kernel time is synchronized with an external source, the
+kernel will write the time back to the CMOS clock every 11 minutes. In
+the process of doing this, the kernel briefly turns off RTC periodic
 interrupts, so be aware of this if you are doing serious work. If you
 don't synchronize the kernel time with an external source (via ntp or
 whatever) then the kernel will keep its hands off the RTC, allowing you

