Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261400AbTCYD2m>; Mon, 24 Mar 2003 22:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261405AbTCYD2l>; Mon, 24 Mar 2003 22:28:41 -0500
Received: from vitelus.com ([64.81.243.207]:18697 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S261400AbTCYD2l>;
	Mon, 24 Mar 2003 22:28:41 -0500
Date: Mon, 24 Mar 2003 19:39:04 -0800
From: Aaron Lehmann <aaronl@vitelus.com>
To: Greg KH <greg@kroah.com>
Cc: trivial@rustycorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] Tweak to allow usb-midi to be built
Message-ID: <20030325033904.GE22181@vitelus.com>
References: <20030325032133.GD22181@vitelus.com> <20030325032857.GA11874@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030325032857.GA11874@kroah.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 24, 2003 at 07:28:57PM -0800, Greg KH wrote:
> What kernel version is this?  And what makefile?  Can you send the diff
> so that it can be applied with patch -p1?

This is a recent snapshot from Linus' tree. The patch applies to
drivers/usb/Makefile (sorry).

--- drivers/usb/Makefile        2003-03-24 19:20:00.000000000 -0800
+++ drivers/usb/Makefile~       2003-03-24 19:16:21.000000000 -0800
@@ -15,6 +15,7 @@
 obj-$(CONFIG_USB_AUDIO)                += class/
 obj-$(CONFIG_USB_BLUETOOTH_TTY)        += class/
 obj-$(CONFIG_USB_PRINTER)      += class/
+obj-$(CONFIG_USB_MIDI)         += class/
 
 obj-$(CONFIG_USB_STORAGE)      += storage/

