Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261404AbTCYDLM>; Mon, 24 Mar 2003 22:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261405AbTCYDLM>; Mon, 24 Mar 2003 22:11:12 -0500
Received: from vitelus.com ([64.81.243.207]:10505 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S261404AbTCYDLL>;
	Mon, 24 Mar 2003 22:11:11 -0500
Date: Mon, 24 Mar 2003 19:21:34 -0800
From: Aaron Lehmann <aaronl@vitelus.com>
To: greg@kroah.com, trivial@rustycorp.com.au, linux-kernel@vger.kernel.org
Subject: [TRIVIAL] Tweak to allow usb-midi to be built
Message-ID: <20030325032133.GD22181@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Makefile    2003-03-24 19:20:00.000000000 -0800
+++ Makefile~   2003-03-24 19:16:21.000000000 -0800
@@ -15,6 +15,7 @@
 obj-$(CONFIG_USB_AUDIO)                += class/
 obj-$(CONFIG_USB_BLUETOOTH_TTY)        += class/
 obj-$(CONFIG_USB_PRINTER)      += class/
+obj-$(CONFIG_USB_MIDI)         += class/
 
 obj-$(CONFIG_USB_STORAGE)      += storage/
