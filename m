Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263633AbTETIw6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 04:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263652AbTETIw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 04:52:58 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:51472 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S263633AbTETIw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 04:52:56 -0400
From: Adam Hunt <kinema@myrealbox.com>
To: linux-serial@vger.kernel.org
Subject: [PATCH] trivial typo in drivers/serial/Kconfig
Date: Tue, 20 May 2003 02:05:48 -0700
User-Agent: KMail/1.5.9
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200305200205.51792.kinema@myrealbox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes 2.5's menuconfig help references to the modules "serial" and 
"serial_cs".  These modules are now called "8250" and "8250_cs".

--adam





--- drivers/serial/Kconfig      2003-05-12 04:18:08.000000000 -0700
+++ drivers/serial/Kconfig      2003-05-20 01:45:38.000000000 -0700
@@ -23,7 +23,7 @@

          If you want to compile this driver as a module, say M here and read
          <file:Documentation/modules.txt>.  The module will be called
-         serial.
+         8250.
          [WARNING: Do not compile this driver as a module if you are using
          non-standard serial ports, since the configuration information will
          be lost when the driver is unloaded.  This limitation may be lifted
@@ -73,7 +73,7 @@

          This driver is also available as a module ( = code which can be
          inserted in and removed from the running kernel whenever you want).
-         The module will be called serial_cs.  If you want to compile it as
+         The module will be called 8250_cs.  If you want to compile it as
          a module, say M here and read <file:Documentation/modules.txt>.
          If unsure, say N.

