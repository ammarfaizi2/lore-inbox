Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265937AbUACJHS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 04:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265939AbUACJGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 04:06:00 -0500
Received: from smtp809.mail.sc5.yahoo.com ([66.163.168.188]:44938 "HELO
	smtp809.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265940AbUACJE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 04:04:27 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH 5/7] missing module licenses
Date: Sat, 3 Jan 2004 04:02:15 -0500
User-Agent: KMail/1.5.4
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200401030350.43437.dtor_core@ameritech.net> <200401030400.55755.dtor_core@ameritech.net> <200401030401.35798.dtor_core@ameritech.net>
In-Reply-To: <200401030401.35798.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401030402.16745.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

===================================================================


ChangeSet@1.1575, 2004-01-03 02:47:21-05:00, dtor_core@ameritech.net
  Input: Add missing MODULE_LICENSEs


 maple_keyb.c |    1 +
 newtonkbd.c  |    2 ++
 2 files changed, 3 insertions(+)


===================================================================



diff -Nru a/drivers/input/keyboard/maple_keyb.c b/drivers/input/keyboard/maple_keyb.c
--- a/drivers/input/keyboard/maple_keyb.c	Sat Jan  3 03:09:34 2004
+++ b/drivers/input/keyboard/maple_keyb.c	Sat Jan  3 03:09:34 2004
@@ -14,6 +14,7 @@
 
 MODULE_AUTHOR("YAEGASHI Takeshi <t@keshi.org>");
 MODULE_DESCRIPTION("SEGA Dreamcast keyboard driver");
+MODULE_LICENSE("GPL");
 
 static unsigned char dc_kbd_keycode[256] = {
 	  0,  0,  0,  0, 30, 48, 46, 32, 18, 33, 34, 35, 23, 36, 37, 38,
diff -Nru a/drivers/input/keyboard/newtonkbd.c b/drivers/input/keyboard/newtonkbd.c
--- a/drivers/input/keyboard/newtonkbd.c	Sat Jan  3 03:09:34 2004
+++ b/drivers/input/keyboard/newtonkbd.c	Sat Jan  3 03:09:34 2004
@@ -33,6 +33,8 @@
 #include <linux/serio.h>
 
 MODULE_AUTHOR("Justin Cormack <j.cormack@doc.ic.ac.uk>");
+MODULE_DESCRIPTION("Newton keyboard driver");
+MODULE_LICENSE("GPL");
 
 #define NKBD_KEY	0x7f
 #define NKBD_PRESS	0x80
