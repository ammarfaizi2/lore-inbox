Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263795AbUGRLgL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263795AbUGRLgL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 07:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263802AbUGRLgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 07:36:11 -0400
Received: from smtp-vbr7.xs4all.nl ([194.109.24.27]:19212 "EHLO
	smtp-vbr7.xs4all.nl") by vger.kernel.org with ESMTP id S263795AbUGRLgG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 07:36:06 -0400
Date: Sun, 18 Jul 2004 13:35:52 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: Jurgen Kramer <gtm.kramer@inter.nl.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.8-rc2
Message-ID: <20040718113552.GA23190@middle.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
References: <Pine.LNX.4.58.0407172237370.12598@ppc970.osdl.org> <1090149153.3198.3.camel@paragon.slim>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1090149153.3198.3.camel@paragon.slim>
X-Message-Flag: Still using Outlook? As you can see, it has some errors.
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jurgen Kramer <gtm.kramer@inter.nl.net>
Date: Sun, Jul 18, 2004 at 01:12:33PM +0200
> On Sun, 2004-07-18 at 07:41, Linus Torvalds wrote:
> > MTD updates, i2c updates and some USB updates, and a lot of small stuff
> > (sparse cleanups and fixes from Al etc).
> > 
> > 		Linus
> > 
> Just gave it a try. My EHCI controller is still failing (Asus P4C800-E
> i875p) as in the 2.6.7-mm series.
> 
> <snip>
> ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
> ehci_hcd 0000:00:1d.7: EHCI Host Controller
> ehci_hcd 0000:00:1d.7: BIOS handoff failed (104, 1010001)
> ehci_hcd 0000:00:1d.7: can't reset
> ehci_hcd 0000:00:1d.7: init 0000:00:1d.7 fail, -95
> ehci_hcd: probe of 0000:00:1d.7 failed with error -95
> USB Universal Host Controller Interface driver v2.2
> <snip>
> 
That is most probably something in your bios. My Epox 4PCA3+ (also i875
chipset) says:

ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
ehci_hcd 0000:00:1d.7: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 23, pci mem f988a000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v2.2

HTH,
Jurriaan
-- 
4) "No Spamming allowed!":  How to know when an AUP is actually enforced
or just placed there to placate the net-nazi
	'Top ten seminars at an upcoming DMA conference' as seen in nanae
Debian (Unstable) GNU/Linux 2.6.7-mm7 2x6078 bogomips load 0.30
