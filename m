Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263208AbSJCIoh>; Thu, 3 Oct 2002 04:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263211AbSJCIoh>; Thu, 3 Oct 2002 04:44:37 -0400
Received: from uranus.lan-ks.de ([194.45.71.1]:61706 "EHLO uranus.lan-ks.de")
	by vger.kernel.org with ESMTP id <S263208AbSJCIoe> convert rfc822-to-8bit;
	Thu, 3 Oct 2002 04:44:34 -0400
X-MDaemon-Deliver-To: <linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH, TRIVIAL] formatting of drivers/char/Config.in
X-Face: ""xJff<P[R~C67]V?J|X^Dr`YigXK|;1wX<rt^>%{>hr-{:QXl"Xk2O@@(+F]e{"%EYQiW@mUuvEsL>=mx96j12qW[%m;|:B^n{J8k?Mz[K1_+H;$v,nYx^1o_=4M,L+]FIU~[[`-w~~xsy-BX,?tAF_.8u&0y*@aCv;a}Y'{w@#*@iwAl?oZpvvv
X-Message-Flag: This space is intentionally left blank
X-Noad: Please don't send me ad's by mail.  I'm bored by this type of mail.
X-Note: sending SPAM is a violation of both german and US law and will
	at least trigger a complaint at your provider's postmaster.
X-GPG: 1024D/77D4FC9B 2000-08-12 Jochen Hein (28 Jun 1967, Kassel, Germany) 
     Key fingerprint = F5C5 1C20 1DFC DEC3 3107  54A4 2332 ADFC 77D4 FC9B
X-BND-Spook: RAF Taliban BND BKA Bombe Waffen Terror AES GPG
X-No-Archive: yes
From: Jochen Hein <jochen@jochen.org>
Date: Thu, 03 Oct 2002 10:25:58 +0200
Message-ID: <873croq67d.fsf@gswi1164.jochen.org>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When switching my .config from 2.4.19 to 2.5.40 with "make oldconfig"
I noticed:

--- linux-2.5.40/drivers/char/Config.in.orig	2002-10-03 10:07:47.000000000 +0200
+++ linux-2.5.40/drivers/char/Config.in	2002-10-03 10:08:02.000000000 +0200
@@ -190,6 +190,6 @@
    tristate 'ACP Modem (Mwave) support' CONFIG_MWAVE
 fi
 
-tristate '  RAW driver (/dev/raw/rawN)' CONFIG_RAW_DRIVER
+tristate 'RAW driver (/dev/raw/rawN)' CONFIG_RAW_DRIVER
 
 endmenu

Just a remark:  Some options I'm not sure about had no help texts.  A
lot did, and that helped me a lot.  So, please add the missing peaces.
Now to try it out...

Jochen

-- 
Wenn Du nicht weiﬂt was Du tust, tu's mit Eleganz.
