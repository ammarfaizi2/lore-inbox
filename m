Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266041AbTBGQiN>; Fri, 7 Feb 2003 11:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266043AbTBGQiM>; Fri, 7 Feb 2003 11:38:12 -0500
Received: from nycsmtp3out.rdc-nyc.rr.com ([24.29.99.224]:31141 "EHLO
	nycsmtp3out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S266041AbTBGQiM>; Fri, 7 Feb 2003 11:38:12 -0500
Date: Fri, 7 Feb 2003 11:57:16 -0500 (EST)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@master
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com, <trivial@rustcorp.com.au>
Subject: [PATCH] 2.5.59 : arch/cris/drivers/eeprom.c
Message-ID: <Pine.LNX.4.44.0302071155150.6917-100000@master>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  The following patch addresses buzilla buig # 308 , and removes a 
unneeded semicolon. Please review for inclusion.

Regards,
Frank

--- linux/arch/cris/drivers/eeprom.c.old	2003-01-16 21:22:02.000000000 -0500
+++ linux/arch/cris/drivers/eeprom.c	2003-02-07 03:17:58.000000000 -0500
@@ -815,7 +815,7 @@
       i2c_outbyte( eeprom.select_cmd | 1 );
     }
 
-    if(i2c_getack());
+    if(i2c_getack())
     {
       break;
     }

