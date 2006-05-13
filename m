Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932259AbWEMKlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbWEMKlI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 06:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbWEMKlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 06:41:08 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:63985 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S932259AbWEMKlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 06:41:06 -0400
Date: Sat, 13 May 2006 12:41:05 +0200
From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
To: mactel-linux-devel@lists.sourceforge.net
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: intel mac mini: USB keyboard is disfunctional after several hours of passive operation until disconnect/reconnect
Message-ID: <20060513104105.GA10908@cip.informatik.uni-erlangen.de>
Mail-Followup-To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	mactel-linux-devel@lists.sourceforge.net,
	LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

     [ Resend because I mistyped the eMail of mactel-linux-devel ]

I have problems with my USB keyboard after several hours of not using
it. It simply accepts no input after I come back to my machine. I use
BIOS (firmware update 1.1 for intel mac mini) emulation and kernel 2.6.15.2.
When I disconnect it, it works like charm again. Has anyone an idea or sees the
same effect? I had running 2.6.15.2 two weeks without rebooting running on my
mac mini and did not experience such problems. My only idea is that it has
something todo with the firmware upgrade for the bios comp. layer. Does
anybody sees such effects in here who has firmware update 1.1 installed? My
solution so far is to unplug my keyboard and put it in after 3 seconds. After
that it works again. The mouse is working all the time.  I use a SUN
Type 6 USB keyboard which is shipped with SunRays. I also tried to use
another SunRay keyboard which doesn't change the problem.

May 12 00:58:57 mini kernel: usb 2-1: USB disconnect, address 2
May 12 00:59:08 mini kernel: usb 2-1: new low speed USB device using uhci_hcd and address 3
May 12 00:59:08 mini kernel: usb 2-1: configuration #1 chosen from 1 choice
May 12 00:59:08 mini kernel: input: HID 0430:0005 as /class/input/input4
May 12 00:59:08 mini kernel: input: USB HID v1.00 Keyboard [HID 0430:0005] on usb-0000:00:1d.0-1

May 12 09:14:21 mini kernel: usb 2-1: USB disconnect, address 3
May 12 09:14:43 mini kernel: usb 2-1: new low speed USB device using uhci_hcd and address 4
May 12 09:14:43 mini kernel: usb 2-1: configuration #1 chosen from 1 choice
May 12 09:14:43 mini kernel: input: HID 0430:0005 as /class/input/input5
May 12 09:14:43 mini kernel: input: USB HID v1.00 Keyboard [HID 0430:0005] on usb-0000:00:1d.0-1

May 13 02:01:31 mini kernel: usb 2-1: USB disconnect, address 4
May 13 02:01:41 mini kernel: usb 4-1: new low speed USB device using uhci_hcd and address 2
May 13 02:01:41 mini kernel: usb 4-1: configuration #1 chosen from 1 choice
May 13 02:01:41 mini kernel: input: HID 0430:0005 as /class/input/input6
May 13 02:01:41 mini kernel: input: USB HID v1.00 Keyboard [HID 0430:0005] on usb-0000:00:1d.2-1

May 13 08:52:04 mini kernel: usb 4-1: USB disconnect, address 2
May 13 08:52:08 mini kernel: usb 4-1: new low speed USB device using uhci_hcd and address 3
May 13 08:52:08 mini kernel: usb 4-1: configuration #1 chosen from 1 choice
May 13 08:52:09 mini kernel: input: HID 0430:0005 as /class/input/input7
May 13 08:52:09 mini kernel: input: USB HID v1.00 Keyboard [HID 0430:0005] on usb-0000:00:1d.2-1

        Thomas
