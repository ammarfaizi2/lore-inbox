Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965309AbWFAVKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965309AbWFAVKW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 17:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965312AbWFAVKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 17:10:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:42157 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965310AbWFAVKV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 17:10:21 -0400
Date: Thu, 1 Jun 2006 14:07:54 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>, Bernhard Kaindl <bk@suse.de>
Cc: Miles Lane <miles.lane@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm2 -- PCI: Bus #03 (-#06) is hidden behind transparent bridge #02 (-#02) (try 'pci=assign-busses')
Message-ID: <20060601210754.GA18548@kroah.com>
References: <a44ae5cd0606010752n637c6411l805115f8170f0ebb@mail.gmail.com> <20060601095335.c778bc98.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060601095335.c778bc98.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2006 at 09:53:35AM -0700, Andrew Morton wrote:
> On Thu, 1 Jun 2006 10:52:26 -0400
> "Miles Lane" <miles.lane@gmail.com> wrote:
> 
> > ACPI: setting ELCR to 0200 (from 0c38)
> > PM: Adding info for No Bus:platform
> > NET: Registered protocol family 16
> > ACPI: bus type pci registered
> > PCI: PCI BIOS revision 2.10 entry at 0xfd9c2, last bus=2
> > Setting up standard PCI resources
> > ACPI: Subsystem revision 20060310
> > ACPI: Interpreter enabled
> > ACPI: Using PIC for interrupt routing
> > PM: Adding info for acpi:acpi
> > ACPI: PCI Root Bridge [PCI0] (0000:00)
> > PCI: Probing PCI hardware (bus 00)
> > PM: Adding info for No Bus:pci0000:00
> > Boot video device is 0000:00:02.0
> > PCI quirk: region 1000-107f claimed by ICH4 ACPI/GPIO/TCO
> > PCI quirk: region 1180-11bf claimed by ICH4 GPIO
> > PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
> > PCI: Transparent bridge - 0000:00:1e.0
> > PCI: Bus #03 (-#06) is hidden behind transparent bridge #02 (-#02)
> > (try 'pci=assign-busses')
> > Please report the result to linux-kernel to fix this permanently
> 
> I guess you're supposed to try 'pci=assign-busses'.
> 
> Does the machine work OK without pci=assign-busses?
> 
> Does the machine work OK with pci=assign-busses?
> 
> Greg, what are we supposed to be doing here?  Grab the PCI IDs and add a
> quirk somewhere?

Not quite sure.  Bernhard, this was caused by your patch.  Any thoughts
as to what should be done?

thanks,

greg k-h
