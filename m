Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262872AbUKTBPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262872AbUKTBPv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 20:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263058AbUKTBPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 20:15:47 -0500
Received: from smtp2.wanadoo.fr ([193.252.22.29]:43226 "EHLO
	mwinf0212.wanadoo.fr") by vger.kernel.org with ESMTP
	id S263049AbUKTBPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 20:15:08 -0500
Message-ID: <419EA8A3.7040002@wanadoo.fr>
Date: Sat, 20 Nov 2004 03:14:59 +0100
From: Olsimar <olsimar@wanadoo.fr>
Reply-To: olsimar@wanadoo.fr
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: patch for bttv help in 2.6.X
Content-Type: multipart/mixed;
 boundary="------------090301060203080108030405"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090301060203080108030405
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi all

I found one mistake in the help of bttv in 2.6.10-rc2-bk4 :

"I2C bit-banging interfaces" in the character device section.

or it's in the device drivers section since 2.6.X.

I have made a patch for you.

bye

--- a/drivers/media/video/Kconfig       2004-11-19 20:46:04.000000000 +0100
+++ b/drivers/media/video/Kconfig       2004-11-20 02:57:07.000000000 +0100
@@ -22,7 +22,7 @@
          <file:Documentation/video4linux/bttv/> for more information.
 
          If you say Y or M here, you need to say Y or M to "I2C 
support" and
-         "I2C bit-banging interfaces" in the character device section.
+         "I2C bit-banging interfaces" in the device drivers section.
 
          To compile this driver as a module, choose M here: the
          module will be called bttv.


--------------090301060203080108030405
Content-Type: text/plain;
 name="patch-2.6.10-rc2-bk4-bttv-help"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-2.6.10-rc2-bk4-bttv-help"

diff -Nru a/drivers/media/video/Kconfig b/drivers/media/video/Kconfig
--- a/drivers/media/video/Kconfig	2004-11-19 20:46:04.000000000 +0100
+++ b/drivers/media/video/Kconfig	2004-11-20 02:57:07.000000000 +0100
@@ -22,7 +22,7 @@
 	  <file:Documentation/video4linux/bttv/> for more information.
 
 	  If you say Y or M here, you need to say Y or M to "I2C support" and
-	  "I2C bit-banging interfaces" in the character device section.
+	  "I2C bit-banging interfaces" in the device drivers section.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called bttv.

--------------090301060203080108030405--
