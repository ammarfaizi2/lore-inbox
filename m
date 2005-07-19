Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261713AbVGSURF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261713AbVGSURF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 16:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261980AbVGSURE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 16:17:04 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:24975 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261687AbVGSUQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 16:16:59 -0400
Subject: Re: Weird USB errors on HD
From: Lee Revell <rlrevell@joe-job.com>
To: Greg KH <greg@kroah.com>
Cc: Karim Yaghmour <karim@opersys.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050719192918.GA19803@kroah.com>
References: <42DD2EA4.5040507@opersys.com>
	 <20050719192918.GA19803@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Tue, 19 Jul 2005 16:16:55 -0400
Message-Id: <1121804216.4299.7.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-19 at 15:29 -0400, Greg KH wrote:
> Ugh, you have a bad device or power supply, or aren't giving it enough
> power to drive the thing.  Nothing we can do in Linux for that, sorry.
> Buy a wall-powered usb hub, that usually helps.
> 

I get the same messages on boot from a bus with no devices connected to
it (hub 4).  I have not connected the motherboard header because I don't
use that bus, could this be related?

PCI0 USB0 USB1 USB2 USB3 USB4 USB5 USB6 LAN0 AC97 MC97 
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
uhci_hcd 0000:00:10.0: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:10.0: irq 11, io base 0x0000d400
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
uhci_hcd 0000:00:10.1: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2)
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:10.1: irq 10, io base 0x0000d800
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:10.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#3)
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:10.2: irq 12, io base 0x0000dc00
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ehci_hcd 0000:00:10.3: VIA Technologies, Inc. USB 2.0 
ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 4
ehci_hcd 0000:00:10.3: irq 14, io mem 0xea004000
ehci_hcd 0000:00:10.3: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 6 ports detected
hub 4-0:1.0: over-current change on port 5
hub 4-0:1.0: over-current change on port 6
usb 2-2: new low speed USB device using uhci_hcd and address 2
input: USB HID v1.00 Mouse [Microsoft Microsoft Trackball Optical®] on usb-0000:00:10.1-2
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver

Lee

