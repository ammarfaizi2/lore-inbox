Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262947AbTDFMYx (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 08:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262948AbTDFMYx (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 08:24:53 -0400
Received: from halo.ispgateway.de ([62.67.200.127]:28323 "HELO
	halo.ispgateway.de") by vger.kernel.org with SMTP id S262947AbTDFMYw (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 08:24:52 -0400
Subject: USB devices in 2.5.xx do not show in /dev
From: Jens Ansorg <jens@ja-web.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1049632582.3405.0.camel@lisaserver>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 06 Apr 2003 14:36:23 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying an 2.5.66-mm kernel on 1386

I have 3 USB devices connected.
The mouse works - mostly (no wheel support)
But scanner and printer do not work.

The modules scanner and usblp seem to load fine

Apr  6 14:14:37 lisaserver kernel: drivers/usb/core/usb.c: registered
new driver usbscanner
Apr  6 14:14:37 lisaserver kernel: drivers/usb/image/scanner.c:
0.4.11:USB Scanner Driver
Apr  6 14:15:50 lisaserver kernel: drivers/usb/core/usb.c: registered
new driver usblp
Apr  6 14:15:50 lisaserver kernel: drivers/usb/class/usblp.c: v0.13: USB
Printer Device Class driver


but I do not get the devices under /dev to actually use them

I have a gentoo system that uses 
*  sys-apps/devfsd
      Latest version available: 1.3.25-r3
      Latest version installed: 1.3.25-r3

to load /dev


any ideas?

thanks
Jens



-- 
Jens Ansorg <jens@ja-web.de>

