Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268846AbRG0NQI>; Fri, 27 Jul 2001 09:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268851AbRG0NP4>; Fri, 27 Jul 2001 09:15:56 -0400
Received: from smtp.alcove.fr ([212.155.209.139]:21764 "EHLO smtp.alcove.fr")
	by vger.kernel.org with ESMTP id <S268846AbRG0NPr>;
	Fri, 27 Jul 2001 09:15:47 -0400
Date: Fri, 27 Jul 2001 15:15:51 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH 2.4.8-pre1 - RESEND] Configure.help updates for sonypi & meye
Message-ID: <20010727151551.A6860@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi Linus,

This patch adds the missing Configure.help entries for the 
sonypi and motion eye driver.

Stelian.

--- linux-2.4.8-pre1.orig/Documentation/Configure.help	Fri Jul 27 14:56:25 2001
+++ linux-2.4.8-pre1/Documentation/Configure.help	Fri Jul 27 15:10:31 2001
@@ -14228,6 +14228,19 @@
 
   If unsure, say N.
 
+Sony Vaio Programmable I/O Control Device support
+CONFIG_SONYPI
+  This driver enables access to the Sony Programmable I/O Control Device
+  which can be found in many (all ?) Sony Vaio laptops.
+
+  If you have one of those laptops, read Documentation/sonypi.txt,
+  and say Y or M here.
+
+  If you want to compile the driver as a module ( = code which can be
+  inserted in and removed from the running kernel whenever you want),
+  say M here and read <file:Documentation/modules.txt>. The module will be
+  called sonypi.o.
+
 Intel Random Number Generator support
 CONFIG_INTEL_RNG
   This driver provides kernel-side support for the Random Number
@@ -17520,6 +17533,19 @@
   module called pms.o ( = code which can be inserted in and removed
   from the running kernel whenever you want). If you want to compile
   it as a module, say M here and read Documentation/modules.txt.
+
+CONFIG_VIDEO_MEYE
+  This is the video4linux driver for the Motion Eye camera found
+  in the Vaio Picturebook laptops. Please read the material in
+  <file:Documentation/video4linux/meye.txt> for more information.
+
+  If you say Y or M here, you need to say Y or M to "Sony Programmable
+  I/O Control Device" in the character device section.
+
+  This driver is available as a module called meye.o ( = code
+  which can be inserted in and removed from the running kernel
+  whenever you want). If you want to compile it as a module, say M
+  here and read <file:Documentation/modules.txt>.
 
 IBM's S/390 architecture
 CONFIG_ARCH_S390
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|---------------- Free Software Engineer -----------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|------------- Alcôve, liberating software ---------------|
