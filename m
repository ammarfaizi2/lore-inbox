Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263156AbUCSXsy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 18:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263152AbUCSXsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 18:48:54 -0500
Received: from codeblau.walledcity.de ([212.84.209.34]:6156 "EHLO codeblau.de")
	by vger.kernel.org with ESMTP id S263156AbUCSXsr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 18:48:47 -0500
Date: Sat, 20 Mar 2004 00:49:31 +0100
From: Felix von Leitner <leitner@codeblau.de>
To: linux-kernel@vger.kernel.org
Subject: usb broken in 2.6.5-rc1?
Message-ID: <20040319234931.GA11183@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My mouse works, but this happens when I connect my USB 2.0 mass storage
device:


usb 1-3: new high speed USB device using address 2
irq 21: nobody cared!
Call Trace:
 [<c010960a>] __report_bad_irq+0x2a/0x90
 [<c01096fc>] note_interrupt+0x6c/0xa0
 [<c01099d1>] do_IRQ+0x121/0x130
 [<c0107cf4>] common_interrupt+0x18/0x20

handlers:
[<c0291c00>] (usb_hcd_irq+0x0/0x70)
[<c0291c00>] (usb_hcd_irq+0x0/0x70)
[<c0291c00>] (usb_hcd_irq+0x0/0x70)
Disabling IRQ #21
usb 1-3: control timeout on ep0out
usb 1-3: control timeout on ep0out
usb 1-3: device not accepting address 2, error -110
usb 1-3: new high speed USB device using address 3
usb 1-3: control timeout on ep0out
usb 1-3: control timeout on ep0out
usb 1-3: device not accepting address 3, error -110
usb 1-3: new high speed USB device using address 4
usb 1-3: control timeout on ep0out
usb 1-3: control timeout on ep0out
usb 1-3: device not accepting address 4, error -110
usb 1-3: new high speed USB device using address 5
usb 1-3: control timeout on ep0out
usb 1-3: control timeout on ep0out
usb 1-3: device not accepting address 5, error -110
usb 1-3: new high speed USB device using address 6
usb 1-3: control timeout on ep0out
usb 1-3: control timeout on ep0out
usb 1-3: device not accepting address 6, error -110
usb 1-3: new high speed USB device using address 7
usb 1-3: control timeout on ep0out
usb 1-3: control timeout on ep0out
usb 1-3: device not accepting address 7, error -110
usb 1-3: new high speed USB device using address 8
usb 1-3: control timeout on ep0out
usb 1-3: control timeout on ep0out
usb 1-3: device not accepting address 8, error -110
usb 1-3: new high speed USB device using address 9
usb 1-3: control timeout on ep0out
usb 1-3: control timeout on ep0out
usb 1-3: device not accepting address 9, error -110
usb 1-3: new high speed USB device using address 10
usb 1-3: control timeout on ep0out
[and so on]

Oh, and my mouse stops working.

Has anyone ever seen USB mass storage actually work under Linux?
Just curious.  This is a VIA chipset, by the way.

Felix
