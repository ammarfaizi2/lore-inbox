Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268344AbUIQCoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268344AbUIQCoO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 22:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268370AbUIQCoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 22:44:14 -0400
Received: from smtp100.rog.mail.re2.yahoo.com ([206.190.36.78]:50063 "HELO
	smtp100.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S268344AbUIQCoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 22:44:12 -0400
From: Shawn Starr <shawn.starr@rogers.com>
Organization: sh0n.net
Subject: [2.6.9-rc2-bk2][USB HID] Problem with USB <-> PS/2 converter for keyboard -  USB unable to set Port - continued
Date: Thu, 16 Sep 2004 22:44:09 -0400
User-Agent: KMail/1.7
To: linux-kernel@vger.kernel.org
Cc: Vojtech Pavlik <vojtech@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409162244.09448.shawn.starr@rogers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Is this a known issue? I can still reproduce this problem: 

usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
ehci_hcd 0000:00:1d.7: GetStatus port 3 status 001c03 POWER sig=?  CSC CONNECT 
hub 4-0:1.0: port 3, status 0501, change 0001, 480 Mb/s 
hub 4-0:1.0: debounce: port 3: total 100ms stable 100ms status 0x501 
hub 4-0:1.0: port 3 not reset yet, waiting 50ms
ehci_hcd 0000:00:1d.7: port 3 full speed --> companion
ehci_hcd 0000:00:1d.7: GetStatus port 3 status 003c01 POWER OWNER sig=? CONNECT 
uhci_hcd 0000:00:1d.1: wakeup_hc
uhci_hcd 0000:00:1d.1: port 1 portsc 0082
hub 2-0:1.0: port 1, status 0100, change 0001, 12 Mb/s
hub 2-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x100
ehci_hcd 0000:00:1d.7: GetStatus port 3 status 001c03 POWER sig=?  CSC CONNECT 
hub 4-0:1.0: port 3, status 0501, change 0001, 480 Mb/s
hub 4-0:1.0: debounce: port 3: total 100ms stable 100ms status 0x501
hub 4-0:1.0: port 3 not reset yet, waiting 50ms
ehci_hcd 0000:00:1d.7: port 3 full speed --> companion
ehci_hcd 0000:00:1d.7: GetStatus port 3 status 003c01 POWER OWNER sig=? CONNECT 
uhci_hcd 0000:00:1d.1: suspend_hc
uhci_hcd 0000:00:1d.1: wakeup_hc
uhci_hcd 0000:00:1d.1: port 1 portsc 00b2
hub 2-0:1.0: port 1, status 0100, change 0001, 12 Mb/s
hub 2-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x100
ehci_hcd 0000:00:1d.7: GetStatus port 3 status 001c03 POWER sig=?  CSC CONNECT 
hub 4-0:1.0: port 3, status 0501, change 0001, 480 Mb/s
ehci_hcd 0000:00:1d.7: GetStatus port 3 status 001c03 POWER sig=?  CSC CONNECT

Please let me know what other info other than what I have provided in previous email I will be glad to get this information for you.

This is a Thinkpad T42 Laptop USB 2.0 ports (2 of them external 6 total interal wired for bluetooth and such).

Shawn.
