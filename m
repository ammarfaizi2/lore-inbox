Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263847AbUGRMWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263847AbUGRMWn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 08:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263850AbUGRMWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 08:22:43 -0400
Received: from slimnet.xs4all.nl ([194.109.194.192]:18320 "EHLO slimnas.slim")
	by vger.kernel.org with ESMTP id S263847AbUGRMWl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 08:22:41 -0400
Subject: Re: Linux 2.6.8-rc2
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: Jurriaan <thunder7@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040718113552.GA23190@middle.of.nowhere>
References: <Pine.LNX.4.58.0407172237370.12598@ppc970.osdl.org>
	 <1090149153.3198.3.camel@paragon.slim>
	 <20040718113552.GA23190@middle.of.nowhere>
Content-Type: text/plain
Message-Id: <1090153502.3198.7.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 18 Jul 2004 14:25:02 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-07-18 at 13:35, Jurriaan wrote:
> From: Jurgen Kramer <gtm.kramer@inter.nl.net>
> Date: Sun, Jul 18, 2004 at 01:12:33PM +0200
> > On Sun, 2004-07-18 at 07:41, Linus Torvalds wrote:
> > > MTD updates, i2c updates and some USB updates, and a lot of small stuff
> > > (sparse cleanups and fixes from Al etc).
> > > 
> > > 		Linus
> > > 
> > Just gave it a try. My EHCI controller is still failing (Asus P4C800-E
> > i875p) as in the 2.6.7-mm series.
> > 
> > <snip>
> > ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
> > ehci_hcd 0000:00:1d.7: EHCI Host Controller
> > ehci_hcd 0000:00:1d.7: BIOS handoff failed (104, 1010001)
> > ehci_hcd 0000:00:1d.7: can't reset
> > ehci_hcd 0000:00:1d.7: init 0000:00:1d.7 fail, -95
> > ehci_hcd: probe of 0000:00:1d.7 failed with error -95
> > USB Universal Host Controller Interface driver v2.2
> > <snip>
> > 
> That is most probably something in your bios. My Epox 4PCA3+ (also i875
> chipset) says:
> 
> ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
> ehci_hcd 0000:00:1d.7: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller
> PCI: Setting latency timer of device 0000:00:1d.7 to 64
> ehci_hcd 0000:00:1d.7: irq 23, pci mem f988a000
> ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
> PCI: cache line size of 128 is not supported by device 0000:00:1d.7
> ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 8 ports detected
> USB Universal Host Controller Interface driver v2.2

I didn't change any BIOS settings lately and newer BIOS versions stop
booting stops after initializing ACPI..:-(. 2.6.5 works as a charm.

> HTH,
> Jurriaan

Jurgen


