Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313988AbSDQAzs>; Tue, 16 Apr 2002 20:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313991AbSDQAzr>; Tue, 16 Apr 2002 20:55:47 -0400
Received: from mail.mesatop.com ([208.164.122.9]:65284 "EHLO thor.mesatop.com")
	by vger.kernel.org with ESMTP id <S313988AbSDQAzp>;
	Tue, 16 Apr 2002 20:55:45 -0400
Subject: [PATCH] 2.5.8-dj1, add one help text to drivers/char/Config.help
From: Steven Cole <elenstev@mesatop.com>
To: linux-kernel@vger.kernel.org
Cc: Dave Jones <davej@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1019004381.16110.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution/1.0.2-5mdk 
Date: 16 Apr 2002 18:54:16 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a help text to drivers/char/Config.help.
The text was obtained from the 2.4.19-pre7 Configure.help.

Steven

--- linux-2.5.8-dj1/drivers/char/Config.help.orig	Tue Apr 16 13:49:20 2002
+++ linux-2.5.8-dj1/drivers/char/Config.help	Tue Apr 16 13:50:10 2002
@@ -1003,6 +1003,12 @@
   The module is called machzwd.o.  If you want to compile it as a
   module, say M here and read <file:Documentation/modules.txt>.
 
+CONFIG_INDYDOG
+  Hardware driver for the Indy's/I2's watchdog. This is a
+  watchdog timer that will reboot the machine after a 60 second
+  timer expired and no process has written to /dev/watchdog during
+  that time.
+
 CONFIG_60XX_WDT
  This driver can be used with the watchdog timer found on some
  single board computers, namely the 6010 PII based computer.



