Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266308AbTBPLDW>; Sun, 16 Feb 2003 06:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266310AbTBPLDW>; Sun, 16 Feb 2003 06:03:22 -0500
Received: from [195.39.17.254] ([195.39.17.254]:10500 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S266308AbTBPLDV>;
	Sun, 16 Feb 2003 06:03:21 -0500
Date: Sat, 15 Feb 2003 21:44:36 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>,
       davyd@zdlcomputing.com
Subject: Toshiba keyboard bug: point people to the patch
Message-ID: <20030215204436.GA8589@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Too many people mail me, and one of them was kind enough to put the
patch on the web. It would be nice to have this in both 2.4.X and
2.5.X [patch against 2.5.61].

								Pavel

--- clean/arch/i386/kernel/dmi_scan.c	2003-02-11 17:40:33.000000000 +0100
+++ linux/arch/i386/kernel/dmi_scan.c	2003-02-15 21:22:10.000000000 +0100
@@ -455,7 +455,7 @@
 
 static __init int broken_toshiba_keyboard(struct dmi_blacklist *d)
 {
-	printk(KERN_WARNING "Toshiba with broken keyboard detected. If your keyboard sometimes generates 3 keypresses instead of one, contact pavel@ucw.cz\n");
+	printk(KERN_WARNING "Toshiba with broken keyboard detected. If your keyboard sometimes generates 3 keypresses instead of one, see http://davyd.ucc.asn.au/projects/toshiba/README\n");
 	return 0;
 }
 

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
