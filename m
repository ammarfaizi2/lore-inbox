Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbTIYNPo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 09:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261185AbTIYNPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 09:15:44 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:23754 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261162AbTIYNPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 09:15:43 -0400
Date: Thu, 25 Sep 2003 15:15:36 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.4 patch] fix USB_MOUSE help text
Message-ID: <20030925131536.GU15696@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The USB_MOUSE help text was obviously copied from the USB_KBD help text.
The patch below does a s/keyboard/mouse/g

Please apply
Adrian

--- linux-2.4.23-pre5/Documentation/Configure.help.old	2003-09-25 15:13:23.000000000 +0200
+++ linux-2.4.23-pre5/Documentation/Configure.help	2003-09-25 15:14:27.000000000 +0200
@@ -14742,8 +14742,8 @@
 USB HIDBP Mouse (basic) support
 CONFIG_USB_MOUSE
   Say Y here only if you are absolutely sure that you don't want
-  to use the generic HID driver for your USB keyboard and prefer
-  to use the keyboard in its limited Boot Protocol mode instead.
+  to use the generic HID driver for your USB mouse and prefer
+  to use the mouse in its limited Boot Protocol mode instead.
 
   This is almost certainly not what you want.
 
