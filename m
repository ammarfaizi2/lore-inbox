Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbTDOMbK (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 08:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbTDOMbK 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 08:31:10 -0400
Received: from f10.law8.hotmail.com ([216.33.241.10]:43279 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id S261335AbTDOMbI 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 08:31:08 -0400
X-Originating-IP: [67.86.246.131]
X-Originating-Email: [seandarcy@hotmail.com]
From: "sean darcy" <seandarcy@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.67-bk4 & 5  - boot oops at  USB Mass Storage
Date: Tue, 15 Apr 2003 08:42:53 -0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F102ZBNCogiwHsqhA5300000785@hotmail.com>
X-OriginalArrivalTime: 15 Apr 2003 12:42:53.0881 (UTC) FILETIME=[887D3290:01C3034C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.67 boots fine. With bk4 or bk5 I get an oops right after:

USB Mass Storage support registered

Unable to handle kernel NULL pointer dereference at virtual address 00000040
printing EIP:
c026af44
*pde=00000000
oops: 0002 [#1]
cpu: 0
EIP: 0060:[c026af44] Not tainted

On 2.5.67, dmesg gives:

...............
ehci-hcd 00:10.3: VIA Technologies, In USB 2.0
ehci-hcd 00:10.3: irq 10, pci mem e0840e00
Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecated.
ehci-hcd 00:10.3: new USB bus registered, assigned bus number 1
ehci-hcd 00:10.3: USB 2.0 enabled, EHCI 1.00, driver 2003-Jan-22
hub 1-0:0: USB hub found
hub 1-0:0: 6 ports detected
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver 
v2.0uhci-hcd 00:10.0: VIA Technologies, In USB
uhci-hcd 00:10.0: irq 11, io base 0000dc00
uhci-hcd 00:10.0: new USB bus registered, assigned bus number 2
hub 2-0:0: USB hub found
hub 2-0:0: 2 ports detected
uhci-hcd 00:10.1: VIA Technologies, In USB (#2)
uhci-hcd 00:10.1: irq 10, io base 0000e000
uhci-hcd 00:10.1: new USB bus registered, assigned bus number 3
hub 3-0:0: USB hub found
hub 3-0:0: 2 ports detected
uhci-hcd 00:10.2: VIA Technologies, In USB (#3)
uhci-hcd 00:10.2: irq 5, io base 0000e400
uhci-hcd 00:10.2: new USB bus registered, assigned bus number 4
hub 4-0:0: USB hub found
hub 4-0:0: 2 ports detected
drivers/usb/core/usb.c: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
.........


I have a kt400 mobo.

jay


_________________________________________________________________


