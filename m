Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262420AbULRAnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262420AbULRAnd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 19:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262500AbULRAnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 19:43:33 -0500
Received: from out012pub.verizon.net ([206.46.170.137]:16573 "EHLO
	out012.verizon.net") by vger.kernel.org with ESMTP id S262420AbULRAnZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 19:43:25 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hid-core: Configurable USB HID Mouse Interrupt Polling Interval
Date: Fri, 17 Dec 2004 19:43:23 -0500
User-Agent: KMail/1.7
Cc: Mikkel Krautz <krautz@gmail.com>, vojtech@suse.cz
References: <1103335970.15567.15.camel@localhost>
In-Reply-To: <1103335970.15567.15.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412171943.23891.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out012.verizon.net from [151.205.47.244] at Fri, 17 Dec 2004 18:43:24 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 December 2004 21:12, Mikkel Krautz wrote:
>Hi!
>
>This patch adds the option "USB HID Mouse Interrupt Polling
> Interval" to drivers/usb/input/Kconfig, and a few lines of code to
>drivers/usb/input/hid-core.c, to make the config option function.
>
>It allows people to change the interval, at which their USB HID mice
>are polled at. This is extremely useful for people who require high
>precision, or just likes the feeling of a very precise mouse. ;)
>
>As the Kconfig help implies, setting a lower polling interval is
> known to work on several mice produced by Logitech and Microsoft. I
> only have a Logitech MX500 to test it on. My results have been
> positive, and so have many other people's.
>
>Mikkel Krautz
>
Mikkel, could you please turn off the word wrap in your MTA's
composer and repost this?  I'd like to try it.

>
>
>Signed-off-by: Mikkel Krautz <krautz@gmail.com>
>---
>
>--- clean/drivers/usb/input/Kconfig
>+++ dirty/drivers/usb/input/Kconfig
>@@ -24,6 +24,38 @@
> 	  To compile this driver as a module, choose M here: the
> 	  module will be called usbhid.

[...]

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.30% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.

