Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265409AbTAEXHg>; Sun, 5 Jan 2003 18:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265373AbTAEXHg>; Sun, 5 Jan 2003 18:07:36 -0500
Received: from [195.39.17.254] ([195.39.17.254]:9988 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S265409AbTAEXHe>;
	Sun, 5 Jan 2003 18:07:34 -0500
Date: Mon, 6 Jan 2003 00:13:49 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: include order for i2c-amd8111
Message-ID: <20030105231349.GA8714@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

It seems all linux then all asm is prefered order...
								Pavel

--- clean/drivers/i2c/busses/i2c-amd8111.c	2003-01-05 22:58:27.000000000 +0100
+++ linux-sensors/drivers/i2c/busses/i2c-amd8111.c	2003-01-05 21:13:25.000000000 +0100
@@ -11,7 +11,6 @@
 #include <linux/version.h>
 #include <linux/module.h>
 #include <linux/pci.h>
-#include <asm/io.h>
 #include <linux/kernel.h>
 #include <linux/stddef.h>
 #include <linux/sched.h>
@@ -19,6 +18,7 @@
 #include <linux/init.h>
 #include <linux/i2c.h>
 #include <linux/delay.h>
+#include <asm/io.h>
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR ("Vojtech Pavlik <vojtech@suse.cz>");

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
