Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265826AbTGLOA0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 10:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265833AbTGLOA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 10:00:26 -0400
Received: from baloney.puettmann.net ([194.97.54.34]:13713 "EHLO
	baloney.puettmann.net") by vger.kernel.org with ESMTP
	id S265826AbTGLOAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 10:00:24 -0400
Date: Sat, 12 Jul 2003 16:14:31 +0200
To: linux-kernel@vger.kernel.org
Subject: Problems with usb-ohci on 2.4.22-preX
Message-ID: <20030712141431.GA3240@puettmann.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Ruben Puettmann <ruben@puettmann.net>
X-Scanner: exiscan *19bL8x-0000r2-00*Mct4TegkCMo* (Puettmann.NeT, Germany)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


        hy,

i try to install linux on my new motherboard EPOX 8RDA3+ 
with nvidia nforce2 chipset.

If I try to attached some usb devices ( usb memory stick ) I got this
errors ( 2.4.22-pre5 pre2..): 


PCI: Setting latency timer of device 00:02.2 to 64
ehci_hcd 00:02.2: nVidia Corporation nForce2 USB Controller
ehci_hcd 00:02.2: irq 20, pci mem f88eb000
usb.c: new USB bus registered, assigned bus number 1
PCI: 00:02.2 PCI cache line size set incorrectly (0 bytes) by BIOS/FW.
PCI: 00:02.2 PCI cache line size corrected to 64.
ehci_hcd 00:02.2: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-19/2.4
hub.c: USB hub found
hub.c: 6 ports detected
PCI: Setting latency timer of device 00:02.0 to 64
usb-ohci.c: USB OHCI at membase 0xf88f3000, IRQ 20
usb-ohci.c: usb-00:02.0, nVidia Corporation nForce2 USB Controller
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 3 ports detected
PCI: Setting latency timer of device 00:02.1 to 64
usb-ohci.c: USB OHCI at membase 0xf88f5000, IRQ 22
usb-ohci.c: usb-00:02.1, nVidia Corporation nForce2 USB Controller (#2)
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 3 ports detected
uhci.c: USB Universal Host Controller Interface driver v1.1
usb-uhci.c: $Revision: 1.275 $ time 15:11:40 Jul 12 2003
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
hub.c: new USB device 00:02.1-3, assigned address 2
usb_control/bulk_msg: timeout
usb-ohci.c: unlink URB timeout
usb.c: USB device not accepting new address=2 (error=-110)
hub.c: new USB device 00:02.1-3, assigned address 3
usb_control/bulk_msg: timeout
usb-ohci.c: unlink URB timeout
usb.c: USB device not accepting new address=3 (error=-110)
eth0: Setting 10mbps full-duplex based on auto-negotiated partner ability 4461.
eth0.2: add 01:00:5e:00:00:01 mcast address to master interface
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (7168 buckets, 57344 max) - 292 bytes per conntrack
hub.c: new USB device 00:02.0-3, assigned address 2
usb_control/bulk_msg: timeout
usb-ohci.c: unlink URB timeout
usb.c: unable to get device descriptor (error=-12)
hub.c: new USB device 00:02.0-3, assigned address 3
usb_control/bulk_msg: timeout
usb-ohci.c: unlink URB timeout
usb.c: USB device not accepting new address=3 (error=-110)
hub.c: new USB device 00:02.1-2, assigned address 4
usb_control/bulk_msg: timeout
usb-ohci.c: unlink URB timeout
usb.c: USB device not accepting new address=4 (error=-110)
hub.c: new USB device 00:02.1-2, assigned address 5
usb_control/bulk_msg: timeout
usb-ohci.c: unlink URB timeout
usb.c: USB device not accepting new address=5 (error=-110)

This happend's with usb-ohci and usb-ehci loaded or only with usb-ohci.


        thanks for help 

                Ruben


-- 
Ruben Puettmann
ruben@puettmann.net
http://www.puettmann.net
