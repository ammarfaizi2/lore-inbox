Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273904AbRJNDpR>; Sat, 13 Oct 2001 23:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273918AbRJNDpI>; Sat, 13 Oct 2001 23:45:08 -0400
Received: from nycsmtp3fa.rdc-nyc.rr.com ([24.29.99.79]:27654 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S273904AbRJNDo6>;
	Sat, 13 Oct 2001 23:44:58 -0400
Message-ID: <3BC90A96.2060509@si.rr.com>
Date: Sat, 13 Oct 2001 23:46:30 -0400
From: Frank Davis <fdavis@si.rr.com>
Reply-To: fdavis@si.rr.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] 2.4.12-ac1: more MODULE_LICENSE tags, mostly sound
Content-Type: multipart/mixed;
 boundary="------------080201010801030508070904"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080201010801030508070904
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,
   I have attached more MODULE_LICENSE patches against 2.4.12-ac1. 
Please review.
Regards,
Frank

--------------080201010801030508070904
Content-Type: text/plain;
 name="DMAS1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="DMAS1"

--- drivers/sound/dmasound/dmasound_atari.c.old	Sun Sep 30 20:39:28 2001
+++ drivers/sound/dmasound/dmasound_atari.c	Sat Oct 13 23:11:17 2001
@@ -1559,3 +1559,4 @@
 
 module_init(dmasound_atari_init);
 module_exit(dmasound_atari_cleanup);
+MODULE_LICENSE("GPL");

--------------080201010801030508070904
Content-Type: text/plain;
 name="DMAS2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="DMAS2"

--- drivers/sound/dmasound/dmasound_awacs.c.old	Sun Sep 30 20:39:28 2001
+++ drivers/sound/dmasound/dmasound_awacs.c	Sat Oct 13 23:13:12 2001
@@ -2180,3 +2180,4 @@
 
 module_init(dmasound_awacs_init);
 module_exit(dmasound_awacs_cleanup);
+MODULE_LICENSE("GPL");

--------------080201010801030508070904
Content-Type: text/plain;
 name="DMAS3"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="DMAS3"

--- drivers/sound/dmasound/dmasound_core.c.old	Mon Aug 27 11:53:18 2001
+++ drivers/sound/dmasound/dmasound_core.c	Sat Oct 13 23:15:18 2001
@@ -135,6 +135,7 @@
 MODULE_PARM(writeBufSize, "i");
 MODULE_PARM(numReadBufs, "i");
 MODULE_PARM(readBufSize, "i");
+MODULE_LICENSE("GPL");
 
 #ifdef MODULE
 static int sq_unit = -1;

--------------080201010801030508070904
Content-Type: text/plain;
 name="DMAS4"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="DMAS4"

--- drivers/sound/dmasound/dmasound_paula.c.old	Sun Sep 30 20:39:28 2001
+++ drivers/sound/dmasound/dmasound_paula.c	Sat Oct 13 23:16:56 2001
@@ -720,3 +720,4 @@
 
 module_init(dmasound_paula_init);
 module_exit(dmasound_paula_cleanup);
+MODULE_LICENSE("GPL");

--------------080201010801030508070904
Content-Type: text/plain;
 name="DMAS5"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="DMAS5"

--- drivers/sound/dmasound/dmasound_q40.c.old	Sun Sep 30 20:39:28 2001
+++ drivers/sound/dmasound/dmasound_q40.c	Sat Oct 13 23:18:28 2001
@@ -585,3 +585,4 @@
 
 module_init(dmasound_q40_init);
 module_exit(dmasound_q40_cleanup);
+MODULE_LICENSE("GPL");

--------------080201010801030508070904
Content-Type: text/plain;
 name="ITE8172"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ITE8172"

--- drivers/sound/ite8172.c.old	Fri Oct 12 18:44:27 2001
+++ drivers/sound/ite8172.c	Sat Oct 13 23:00:08 2001
@@ -1721,6 +1721,7 @@
 
 MODULE_AUTHOR("Monta Vista Software, stevel@mvista.com");
 MODULE_DESCRIPTION("IT8172 AudioPCI97 Driver");
+MODULE_LICENSE("GPL");
 
 /* --------------------------------------------------------------------- */
 

--------------080201010801030508070904
Content-Type: text/plain;
 name="LANAI"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="LANAI"

--- drivers/atm/lanai.c.old	Fri Oct 12 18:43:46 2001
+++ drivers/atm/lanai.c	Sat Oct 13 19:10:05 2001
@@ -2912,5 +2912,6 @@
 
 MODULE_AUTHOR("Mitchell Blank Jr <mitch@sfgoth.com>");
 MODULE_DESCRIPTION("Efficient Networks Speedstream 3010 driver");
+MODULE_LICENSE("GPL");
 
 #endif /* MODULE */

--------------080201010801030508070904
Content-Type: text/plain;
 name="VWSND"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="VWSND"

--- drivers/sound/vwsnd.c.old	Mon Aug 27 11:53:20 2001
+++ drivers/sound/vwsnd.c	Sat Oct 13 23:08:14 2001
@@ -3449,6 +3449,7 @@
 
 MODULE_DESCRIPTION("SGI Visual Workstation sound module");
 MODULE_AUTHOR("Bob Miller <kbob@sgi.com>");
+MODULE_LICENSE("GPL");
 
 static int __init init_vwsnd(void)
 {

--------------080201010801030508070904
Content-Type: text/plain;
 name="WAVEARTI"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="WAVEARTI"

--- drivers/sound/waveartist.c.old	Fri Apr 13 23:26:07 2001
+++ drivers/sound/waveartist.c	Sat Oct 13 23:06:45 2001
@@ -1812,6 +1812,7 @@
 
 module_init(init_waveartist);
 module_exit(cleanup_waveartist);
+MODULE_LICENSE("GPL");
 
 #ifndef MODULE
 static int __init setup_waveartist(char *str)

--------------080201010801030508070904
Content-Type: text/plain;
 name="NEC_VRC5"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="NEC_VRC5"

--- drivers/sound/nec_vrc5477.c.old	Fri Oct 12 18:44:29 2001
+++ drivers/sound/nec_vrc5477.c	Sat Oct 13 23:02:52 2001
@@ -1774,6 +1774,7 @@
 
 MODULE_AUTHOR("Monta Vista Software, jsun@mvista.com or jsun@junsun.net");
 MODULE_DESCRIPTION("NEC Vrc5477 audio (AC97) Driver");
+MODULE_LICENSE("GPL");
 
 /* --------------------------------------------------------------------- */
 extern void jsun_scan_pci_bus(void);

--------------080201010801030508070904--

