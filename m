Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267740AbUIUPC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267740AbUIUPC5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 11:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267745AbUIUPC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 11:02:56 -0400
Received: from agent1.tuc.com ([12.106.254.36]:30104 "EHLO agent1.tuc.com")
	by vger.kernel.org with ESMTP id S267740AbUIUPCy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 11:02:54 -0400
Subject: 2.6.9-rc2-mm1 usb breakage
From: Paul Giordano <giordano@covad.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1095778967.12904.7.camel@pgiorda.tuc.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 21 Sep 2004 10:02:47 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Booting a TYAN S2462 motheboard with 2.6.9-rc2-mm1:

09:00:17 CDT pgiorda [debug] ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host
Controller (OHCI) Driver (PCI) ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host
Controller (OHCI) Driver (PCI)
09:00:17 CDT pgiorda [info] ACPI: PCI interrupt 0000:00:07.4[D] -> GSI
19 (level, low) -> IRQ 19 ACPI: PCI interrupt 0000:00:07.4[D] -> GSI 19
(level, low) -> IRQ 19
09:00:17 CDT pgiorda [info] ohci_hcd 0000:00:07.4: Advanced Micro
Devices [AMD] AMD-766 [ViperPlus] USB ohci_hcd 0000:00:07.4: Advanced
Micro Devices [AMD] AMD-766 [ViperPlus] USB
09:00:17 CDT pgiorda [info] ohci_hcd 0000:00:07.4: irq 19, pci mem
0xdc000 ohci_hcd 0000:00:07.4: irq 19, pci mem 0xdc000
09:00:17 CDT pgiorda [info] ohci_hcd 0000:00:07.4: new USB bus
registered, assigned bus number 1 ohci_hcd 0000:00:07.4: new USB bus
registered, assigned bus number 1
09:00:17 CDT pgiorda [err] ohci_hcd 0000:00:07.4: init err (00002edf
2a2f) ohci_hcd 0000:00:07.4: init err (00002edf 2a2f)
09:00:17 CDT pgiorda [err] ohci_hcd 0000:00:07.4: can't start ohci_hcd
0000:00:07.4: can't start
09:00:17 CDT pgiorda [err] ohci_hcd 0000:00:07.4: init error -75
ohci_hcd 0000:00:07.4: init error -75
09:00:17 CDT pgiorda [info] ohci_hcd 0000:00:07.4: remove, state 0
ohci_hcd 0000:00:07.4: remove, state 0
09:00:17 CDT pgiorda [info] ohci_hcd 0000:00:07.4: USB bus 1
deregistered ohci_hcd 0000:00:07.4: USB bus 1 deregistered
09:00:17 CDT pgiorda [warning] ohci_hcd: probe of 0000:00:07.4 failed
with error -75 ohci_hcd: probe of 0000:00:07.4 failed with error -75

No USB after that.

Please cc me, I'm not on the list.

Thanks,
Gio

