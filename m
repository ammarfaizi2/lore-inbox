Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVpBReRll6sqX1Stm9eR1BMVPewA==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Sat, 03 Jan 2004 09:15:31 +0000
Message-ID: <00cb01c415a4$14606ce0$d100000a@sbs2003.local>
From: "Dmitry Torokhov" <dtor_core@ameritech.net>
X-Mailer: Microsoft CDO for Exchange 2000
To: <Administrator@osdl.org>
Subject: Re: [PATCH 5/7] missing module licenses
Date: Mon, 29 Mar 2004 16:39:53 +0100
User-Agent: KMail/1.5.4
Cc: "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Content-Class: urn:content-classes:message
References: <200401030350.43437.dtor_core@ameritech.net> <200401030400.55755.dtor_core@ameritech.net> <200401030401.35798.dtor_core@ameritech.net>
Importance: normal
Priority: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
In-Reply-To: <200401030401.35798.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:39:54.0390 (UTC) FILETIME=[14F90360:01C415A4]

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
