Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268090AbUIKLcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268090AbUIKLcj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 07:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268097AbUIKLcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 07:32:39 -0400
Received: from dpvc-162-83-93-166.fred.east.verizon.net ([162.83.93.166]:55991
	"EHLO ccs.covici.com") by vger.kernel.org with ESMTP
	id S268090AbUIKLce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 07:32:34 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16706.57937.202228.211164@ccs.covici.com>
Date: Sat, 11 Sep 2004 07:32:33 -0400
From: John covici <covici@ccs.covici.com>
To: linux-kernel@vger.kernel.org
Subject: asus Motherboard's usb failing with 2.6.8
X-Mailer: VM 7.17 under Emacs 21.3.50.2
Reply-To: covici@ccs.covici.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an Asus Motherboard and I cannot get usb2.0 to work properly.
I get the following messages:
ehci_hcd 0000:00:10.4: VIA Technologies, Inc. USB 2.0
ehci_hcd 0000:00:10.4: BIOS handoff failed (104, 1010001)
ehci_hcd 0000:00:10.4: can't reset
ehci_hcd 0000:00:10.4: init 0000:00:10.4 fail, -95
ehci_hcd: probe of 0000:00:10.4 failed with error -95

The relevant lspci listings are:
0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc. A7V600 motherboard
	Flags: bus master, medium devsel, latency 64, IRQ 21
	I/O ports at c400 [size=32]
	Capabilities: [80] Power Management version 2

0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc. A7V600 motherboard
	Flags: bus master, medium devsel, latency 64, IRQ 21
	I/O ports at c800 [size=32]
	Capabilities: [80] Power Management version 2

0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc. A7V600 motherboard
	Flags: bus master, medium devsel, latency 64, IRQ 21
	I/O ports at d000 [size=32]
	Capabilities: [80] Power Management version 2

0000:00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc. A7V600 motherboard
	Flags: bus master, medium devsel, latency 64, IRQ 21
	I/O ports at d400 [size=32]
	Capabilities: [80] Power Management version 2

0000:00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86) (prog-if 20 [EHCI])
	Subsystem: Asustek Computer, Inc. A7V600 motherboard
	Flags: bus master, medium devsel, latency 64, IRQ 21
	Memory at fbc00000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 2

Any assistance would be appreciated.

-- 
         John Covici
         covici@ccs.covici.com
