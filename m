Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261642AbSJQC3M>; Wed, 16 Oct 2002 22:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261643AbSJQC3M>; Wed, 16 Oct 2002 22:29:12 -0400
Received: from www.netops.co.uk ([195.224.68.226]:17580 "EHLO netops.co.uk")
	by vger.kernel.org with ESMTP id <S261642AbSJQC3L>;
	Wed, 16 Oct 2002 22:29:11 -0400
Date: Thu, 17 Oct 2002 03:35:03 +0100 (BST)
From: Steve Parker <steve.parker@netops.co.uk>
X-X-Sender: steve@www
To: linux-kernel@vger.kernel.org
Subject: 2.5.41 still not testable by end users
Message-ID: <Pine.GSO.4.44.0210170326540.25203-100000@www>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been trying to test the 2.5 kernel since 2.5.39, but these warnings
really scare me off... if there's to be a freeze at the end of October,
these really need to be fixed until I (as a -maybe typical- user) feel
comfortable testing it....

I can take Linus' assurances that there is little chance of data
corruption, but while I'm getting messages like these, I can't use it as
my regular system, and I don't have any "Use regularly but don't depend
on" boxes lying around - it's rather oxymoronic.

This machine has run 2.0, 2.2, and 2.4 perfectly happily; if 2.5 can cope
with a pretty bog-standard hard disk (2.4.18 reports: HITACHI_DK239A-65)
then I'll happily test it (2.5 feels faster than 2.4 as a desktop system
from what I've seen) but until it boots without grief, I don't feel safe
testing it.

>From what I've seen, this has been, "Yeah, dealt with" since 2.5.39, but
it still isn't fixed - I don't know whose problem it is, but before it's
done, I can't give any feedback,

Thanks for an excellent kernel so far guys,

Steve.... here's the dmesg output:

Oct 16 21:40:59 declan kernel: Debug: sleeping function called from
illegal context at mm/slab.c:1374
Oct 16 21:40:59 declan kernel: Call Trace:
Oct 16 21:40:59 declan kernel:  [__might_sleep+84/96]
__might_sleep+0x54/0x60
Oct 16 21:40:59 declan kernel:  [kmem_cache_alloc+38/432]
kmem_cache_alloc+0x26/0x1b0
Oct 16 21:40:59 declan kernel:  [startup_8259A_irq+10/16]
startup_8259A_irq+0xa/0x10
Oct 16 21:40:59 declan kernel:  [blk_init_free_list+76/208]
blk_init_free_list+0x4c/0xd0
Oct 16 21:40:59 declan kernel:  [request_irq+140/168]
request_irq+0x8c/0xa8
Oct 16 21:40:59 declan kernel:  [blk_init_queue+12/212]
blk_init_queue+0xc/0xd4
Oct 16 21:40:59 declan kernel:  [ide_init_queue+40/104]
ide_init_queue+0x28/0x68
Oct 16 21:41:00 declan kernel:  [do_ide_request+0/24]
do_ide_request+0x0/0x18
Oct 16 21:41:00 declan kernel:  [init_irq+637/820] init_irq+0x27d/0x334
Oct 16 21:41:00 declan kernel:  [hwif_init+274/600] hwif_init+0x112/0x258
Oct 16 21:41:00 declan kernel:  [probe_hwif_init+28/108]
probe_hwif_init+0x1c/0x6c
Oct 16 21:41:00 declan kernel:  [ide_setup_pci_device+61/104]
ide_setup_pci_device+0x3d/0x68
Oct 16 21:41:00 declan kernel:  [piix_init_one+55/64]
piix_init_one+0x37/0x40
Oct 16 21:41:00 declan kernel:  [init+46/376] init+0x2e/0x178
Oct 16 21:41:00 declan kernel:  [init+0/376] init+0x0/0x178
Oct 16 21:41:00 declan kernel:  [kernel_thread_helper+5/12]
kernel_thread_helper+0x5/0xc
Oct 16 21:41:00 declan kernel:


