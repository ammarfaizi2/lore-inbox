Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265772AbTL3MEz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 07:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265775AbTL3MEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 07:04:55 -0500
Received: from [139.30.44.16] ([139.30.44.16]:19391 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S265772AbTL3MEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 07:04:54 -0500
Date: Tue, 30 Dec 2003 13:04:48 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Andrew Morton <akpm@osdl.org>
cc: Valdis.Kletnieks@vt.edu, lkml <linux-kernel@vger.kernel.org>
Subject: [patch] un-document not yet merged CFQ io-scheduler
Message-ID: <Pine.LNX.4.53.0312301301350.27176@gockel.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The CFQ io-scheduler isn't yet merged, thus it seems a bit too early 
to document it.


--- linux-2.6.0-cset-20031230_0720/Documentation/kernel-parameters.txt.orig	2003-12-30 12:57:32.000000000 +0100
+++ linux-2.6.0-cset-20031230_0720/Documentation/kernel-parameters.txt	2003-12-30 12:57:58.000000000 +0100
@@ -305,7 +305,7 @@
 			arch/i386/kernel/cpu/cpufreq/elanfreq.c.
 
 	elevator=	[IOSCHED]
-			Format: {"as"|"cfq"|"deadline"|"noop"}
+			Format: {"as"|"deadline"|"noop"}
 			See Documentation/as-iosched.txt for details
 
 	es1370=		[HW,OSS]
