Return-Path: <linux-kernel-owner+w=401wt.eu-S932507AbXAQPos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932507AbXAQPos (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 10:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932498AbXAQPor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 10:44:47 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:45112 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932507AbXAQPoq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 10:44:46 -0500
Date: Wed, 17 Jan 2007 10:44:45 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Pavel Machek <pavel@ucw.cz>
cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       kernel list <linux-kernel@vger.kernel.org>,
       Linux usb mailing list 
	<linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] 2.6.20-rc5: usb mouse breaks suspend to ram
In-Reply-To: <20070116214706.GA2182@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44L0.0701171043300.2381-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jan 2007, Pavel Machek wrote:

> Strange, I can't reproduce the hang any more.
> 
> I found other weirdness while trying to hang it: if I move the mouse
> while suspending, it is _not_ completely powered off while machine is
> suspended. LED still shines, at half brightness...?! 

dmesg output (with CONFIG_USB_DEBUG) would be helpful, and so would a 
usbmon log (see Documentation/usb/usbmon.txt).

Alan Stern

