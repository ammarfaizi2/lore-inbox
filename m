Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266633AbUF3MA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266633AbUF3MA6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 08:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266635AbUF3MA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 08:00:57 -0400
Received: from viefep14-int.chello.at ([213.46.255.13]:44126 "EHLO
	viefep14-int.chello.at") by vger.kernel.org with ESMTP
	id S266633AbUF3MAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 08:00:55 -0400
Message-ID: <40E2AB75.9090907@kwaxi.org>
Date: Wed, 30 Jun 2004 14:00:53 +0200
From: Daniel Wagner <daniel@kwaxi.org>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040605)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: irq X: nobody cared, Stack pointer is garbage
X-Enigmail-Version: 0.83.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

When i was first trying linux kernel 2.6.7 (compiled with gcc 3.3.4) i
always got the following error during booting:

irq 11: nobody cared!
Stack pointer is garbage, not printing trace
handlers:
[<c027d140>] (ata_interrupt+0x0/0x140)
[<f0c512e0>] (usb_hcd_irq+0x0/0x70 [usbcore])
Disabling IRQ 11

As an effect no device which is assigned to irq 11 did work (e.g.
soundcard and sata-controller)

Currently i'm testing my system without "noapic nolapic" parameters and

CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y

enabled.

I use an Asus A7N8X2.0 Deluxe mainboard (nForce2 chipset).

With previous versions of the linux kernel i never had this problem.

Any suggestions.

greetings,
Daniel

-- 
Nuclear weapons can wipe out life on Earth, if used properly.
(http://kwaxi.org)
