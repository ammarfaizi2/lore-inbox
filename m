Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263770AbUGRLDs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263770AbUGRLDs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 07:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbUGRLDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 07:03:48 -0400
Received: from web40309.mail.yahoo.com ([66.218.78.88]:3944 "HELO
	web40309.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263770AbUGRLDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 07:03:44 -0400
Message-ID: <20040718110343.42481.qmail@web40309.mail.yahoo.com>
Date: Sun, 18 Jul 2004 04:03:43 -0700 (PDT)
From: Adrian Sandor <aditsu@yahoo.com>
Subject: disabling irq, nobody cared
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

Apologizes if this is a duplicate, many people seem to
have similar error messages but it may or may not be
the same problem.
For the past couple of weeks I've been trying hard to
install a distribution of linux on this computer, and
failed every time.
Suse, Fedora, Knoppix hdd installation, Gentoo... all
failed with every kernel I tried.
The ones that didn't hang or reboot immediately
displayed error messages like:

irq 18: nobody cared!
Call Trace:
[<c01096d2>] __report_bad_irq+0x2a/0x8b
[<c01097bc>] note_interrupt+0x6f/0x9f
[<c0109ada>] do_IRQ+0x161/0x192
[<c0107dec>] common_interrupt+0x18/0x20
[<c0125a0b>] do_softirq+0x57/0xc2
[<c0109ab7>] do_IRQ+0x13e/0x192
[<c0107dec>] common_interrupt+0x18/0x20
[<c010501e>] default_idle+0x0/0x2c
[<c0105047>] default_idle+0x29/0x2c
[<c01050b0>] cpu_idle+0x33/0x3c
[<c0121a36>] printk+0x17d/0x1e6
handlers:
[<c02a028e>] (ide_intr+0x0/0x1cb)
[<c02a028e>] (ide_intr+0x0/0x1cb)
[<c02e108a>] (usb_hcd_irq+0x0/0x67)
Disabling IRQ #18

and

hdb: dma_timer_expiry: dma status == 0x64
hdb: DMA interrupt recovery
hdb: lost interrupt

with various irq numbers and stack traces. That either
slowed the system to a crawl or flooded the console
with "disabling irq x" messages.

I have tried different kernel options: SMP and no SMP,
disabling APIC, etc, different kernels: 2.4.25, 2.6.5,
2.6.8-rc1, even tried some patches, but nothing worked
(2.4 usually hanged, and 2.6 gave the above error
messages).
The only kernels that booted without problems were the
Gentoo (2004.1) and Knoppix (3.4) live cd kernels.
Knoppix (booted from cd) works generally well, but
hangs from time to time (especially when I access the
disks in mc).

I have an Asus P4P800 Deluxe mobo, and a P4 2.8GHz
with HT activated.
I uploaded a var/log/messages file at
http://aditsu.freeunixhost.com/messages.zip for your
reference (68KB zipped, 980KB unpacked). This is from
gentoo only.
The computer works flawlessly in windows xp.

Please help me out, so that all these wasted days
won't be in vain. I can provide any other necessary
information if I can understand how to obtain it (I'm
not a linux expert).

I'd appreciate if you could cc me in the replies.

Thanks
Adrian


		
__________________________________
Do you Yahoo!?
Vote for the stars of Yahoo!'s next ad campaign!
http://advision.webevents.yahoo.com/yahoo/votelifeengine/

