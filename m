Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263905AbTE3RZn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 13:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263909AbTE3RZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 13:25:43 -0400
Received: from webhaste.com ([64.62.134.242]:61201 "HELO vortex.webhaste.com")
	by vger.kernel.org with SMTP id S263905AbTE3RZk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 13:25:40 -0400
Message-ID: <33268.65.122.196.250.1054315605.squirrel@mail.webhaste.com>
Date: Fri, 30 May 2003 10:26:45 -0700 (PDT)
Subject: usb problems with wireless device..
From: <esp@pyroshells.com>
To: <linux-kernel@vger.kernel.org>
X-Priority: 3
Importance: Normal
X-Mailer: SquirrelMail (version 1.2.9)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

argh.. lets try this again..

I've got a wusb v2.1 wireless connection device, which I'm trying to use
with linux 2.4.20-4GB (standard suse linux 8.2), and have been getting the
following errors inside of dmesg:

----
hub.c: new USB device 00:02.0-2, assigned address 3
usbdfu.c: USB Device Fimware Uploader (DFU) v0.8
usb.c: registered new driver usbdfu
at76c503.c: Atmel at76c503 Wireless LAN Driver v0.8
usbdfu.c: get_op_mode() failed: -32
usbdfu.c: downloading firmware
usbdfu.c: remap
usb.c: registered new driver at76c503
at76c503.c: driver registered
usbdevfs: USBDEVFS_CONTROL failed dev 3 rqt 128 rq 6 len 18 ret -110
<repeats about 1000 times>
usbdevfs: USBDEVFS_CONTROL failed dev 3 rqt 128 rq 6 len 18 ret -110
usbdfu.c: resetting device
usbdfu.c: scanning unclaimed devices
usbdfu.c: op_mode = 4
usbdfu.c: firmware already loaded
at76c503.c: downloading external firmware
at76c503.c: firmware version 0.100.2 #16
at76c503.c: using MAC 00:06:25:0d:55:bd
at76c503.c: using net device eth0
at76c503.c: using BSSID 02:00:ce:1c:07:00
eth0: no IPv6 routers present
---

It looks like eth0 exists with the right MAC address, but when I
try running dhcpcd on eth0 it basically hangs the dhcpcd call, and when I
try to plug in the linksys unit into the usb slot with KDE
running, KDE hangs..

This is very annoying. I'm not sure what's causing the get_op_mode call to
fail, nor what's causing the usbdevfs call to fail.

Any help would be appreciated - let me know what diagnostic info people
would need in order to file a fixable bug report, too..

Thanks,

Ed

Thanks much,

Ed


