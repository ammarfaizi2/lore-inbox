Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265094AbSL0Slr>; Fri, 27 Dec 2002 13:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265095AbSL0Slr>; Fri, 27 Dec 2002 13:41:47 -0500
Received: from uranus.lan-ks.de ([194.45.71.1]:39945 "EHLO uranus.lan-ks.de")
	by vger.kernel.org with ESMTP id <S265094AbSL0Slq> convert rfc822-to-8bit;
	Fri, 27 Dec 2002 13:41:46 -0500
X-MDaemon-Deliver-To: <linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Subject: [2.5.53, PATCH] misleading configure help
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
Date: Fri, 27 Dec 2002 19:42:06 +0100
Message-ID: <87r8c3pam9.fsf@gswi1164.jochen.org>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When looking at ISAPNP I found that ISAPNP can't build as a module.
The following patch fixes the documentation:

--- linux-2.5.53/drivers/pnp/Kconfig.jh	2002-12-27 15:56:59.000000000 +0100
+++ linux-2.5.53/drivers/pnp/Kconfig	2002-12-27 15:57:13.000000000 +0100
@@ -56,11 +56,6 @@
 	  Say Y here if you would like support for ISA Plug and Play devices.
 	  Some information is in <file:Documentation/isapnp.txt>.
 
-	  This support is also available as a module called isapnp.o ( =
-	  code which can be inserted in and removed from the running kernel
-	  whenever you want). If you want to compile it as a module, say M
-	  here and read <file:Documentation/modules.txt>.
-
 	  If unsure, say Y.
 
 config PNPBIOS

-- 
Wenn Du nicht weiﬂt was Du tust, tu's mit Eleganz.
