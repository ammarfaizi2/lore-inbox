Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275125AbTHRVcH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 17:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275126AbTHRVcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 17:32:07 -0400
Received: from covert.black-ring.iadfw.net ([209.196.123.142]:65284 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id S275125AbTHRVcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 17:32:02 -0400
Date: Mon, 18 Aug 2003 16:31:56 -0500
From: Art Haas <ahaas@airmail.net>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] Trivial C99 patch for watchdog/sc1200wdt.c
Message-ID: <20030818213156.GC27281@artsapartment.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

A trivial C99 fixup for this file. Against current BK.

Art Haas

===== drivers/char/watchdog/sc1200wdt.c 1.7 vs edited =====
--- 1.7/drivers/char/watchdog/sc1200wdt.c	Thu Feb 13 05:20:50 2003
+++ edited/drivers/char/watchdog/sc1200wdt.c	Wed Apr  2 06:54:50 2003
@@ -292,7 +292,7 @@
 
 static struct notifier_block sc1200wdt_notifier =
 {
-	notifier_call:	sc1200wdt_notify_sys
+	.notifier_call	= sc1200wdt_notify_sys
 };
 
 static struct file_operations sc1200wdt_fops =
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
