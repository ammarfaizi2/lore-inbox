Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271790AbRHRGus>; Sat, 18 Aug 2001 02:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271791AbRHRGui>; Sat, 18 Aug 2001 02:50:38 -0400
Received: from odyssey.netrox.net ([204.253.4.3]:24223 "EHLO t-rex.netrox.net")
	by vger.kernel.org with ESMTP id <S271790AbRHRGuT>;
	Sat, 18 Aug 2001 02:50:19 -0400
Subject: [PATCH] Configure.help: Bad URL for CONFIG_SYN_COOKIES
From: Robert Love <rml@tech9.net>
To: elenstev@mesatop.com, esr@thyrsus.com
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99 (Preview Release)
Date: 18 Aug 2001 02:50:05 -0400
Message-Id: <998117417.2184.44.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The provided URL for more information re SYN Cookies is bad.  I
originally posted a patch to fix this in the 2.4-pre series but it was
not merged.  I am reposting because I was in need of the URL and again
got stuck on the stale URL in Configure.help.

This is against Configure.help 2.41, as in 2.4.8-ac7.



--- linux/Documentation/Configure.help~	Sat Aug 18 02:32:33 2001
+++ linux/Documentation/Configure.help	Sat Aug 18 02:35:32 2001
@@ -2655,8 +2655,7 @@
   continue to connect, even when your machine is under attack. There
   is no need for the legitimate users to change their TCP/IP software;
   SYN cookies work transparently to them. For technical information
-  about SYN cookies, check out
-  <ftp://koobera.math.uic.edu/syncookies.html>.
+  about SYN cookies, check out <http://cr.yp.to/syncookies.html>.
 
   If you are SYN flooded, the source address reported by the kernel is
   likely to have been forged by the attacker; it is only reported as
@@ -2675,7 +2674,7 @@
 
   at boot time after the /proc file system has been mounted.
 
-  If unsure, say Y.
+  If unsure, say N.
 
 HCI EMU (virtual device) driver
 CONFIG_BLUEZ_HCIEMU



-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

