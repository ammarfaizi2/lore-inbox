Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266869AbUGLQSF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266869AbUGLQSF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 12:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266883AbUGLQSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 12:18:05 -0400
Received: from defout.telus.net ([199.185.220.240]:60114 "EHLO
	priv-edtnes46.telusplanet.net") by vger.kernel.org with ESMTP
	id S266869AbUGLQSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 12:18:00 -0400
Subject: ehci problem with maxtor USB HDD with >=2.6.7
From: Dale K Dicks <dale_d@telusplanet.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Home
Message-Id: <1089649059.9190.14.camel@linuxbox.home.bluffs.ab.ca>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 12 Jul 2004 10:17:39 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ehci_hcd 0000:00:10.3: EHCI Host Controller
ehci_hcd 0000:00:10.3: irq 10, pci mem d69fec00
ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 3
ehci_hcd 0000:00:10.3: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 6 ports detected
ehci_hcd 0000:00:10.3: fatal error
ehci_hcd 0000:00:10.3: HC died; cleaning up
process `named' is using obsolete setsockopt SO_BSDCOMPAT
usb usb3: string descriptor 0 read error: -19
usb usb3: string descriptor 0 read error: -19
usb usb3: string descriptor 0 read error: -19
usb usb3: string descriptor 0 read error: -19
usb usb3: string descriptor 0 read error: -19
usb usb3: string descriptor 0 read error: -19
usb usb3: string descriptor 0 read error: -19
usb usb3: string descriptor 0 read error: -19
usb usb3: string descriptor 0 read error: -19
usb usb3: string descriptor 0 read error: -19
usb usb3: string descriptor 0 read error: -19
usb usb3: string descriptor 0 read error: -19

The drive will detect/work properly with uhci.

I tried this with 2.6.8-rc2 and have the exact same problem.

ACPI: PCI interrupt 0000:00:10.3[A] -> GSI 10 (level, low) -> IRQ 10
ehci_hcd 0000:00:10.3: EHCI Host Controller
ehci_hcd 0000:00:10.3: irq 10, pci mem d680ac00
ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:10.3: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ehci_hcd 0000:00:10.3: fatal error
ehci_hcd 0000:00:10.3: HC died; cleaning up
.....
usb usb1: string descriptor 0 read error: -19
usb usb1: string descriptor 0 read error: -19
usb usb1: string descriptor 0 read error: -19
usb usb1: string descriptor 0 read error: -19
usb usb1: string descriptor 0 read error: -19
usb usb1: string descriptor 0 read error: -19
usb usb1: string descriptor 0 read error: -19
usb usb1: string descriptor 0 read error: -19
usb usb1: string descriptor 0 read error: -19
usb usb1: string descriptor 0 read error: -19
usb usb1: string descriptor 0 read error: -19
usb usb1: string descriptor 0 read error: -19

-------------------------------------------------------------
Dale KD                           Public PGP Key ID: B158ED5E
Calgary, Alberta, Canada          hkp://subkeys.pgp.net
-------------------------------------------------------------

