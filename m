Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262555AbVBYHIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262555AbVBYHIr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 02:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262640AbVBYHIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 02:08:47 -0500
Received: from cantor.suse.de ([195.135.220.2]:2257 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262555AbVBYHIO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 02:08:14 -0500
Date: Fri, 25 Feb 2005 08:08:13 +0100
From: Olaf Hering <olh@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.11-rc5
Message-ID: <20050225070813.GA13735@suse.de>
References: <Pine.LNX.4.58.0502232014190.18997@ppc970.osdl.org> <20050224145049.GA21313@suse.de> <1109287708.15026.25.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1109287708.15026.25.camel@gaston>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Fri, Feb 25, Benjamin Herrenschmidt wrote:

> On Thu, 2005-02-24 at 15:50 +0100, Olaf Hering wrote:
> >  On Wed, Feb 23, Linus Torvalds wrote:
> > 
> > > This time it's really supposed to be a quickie, so people who can, please 
> > > check it out, and we'll make the real 2.6.11 asap.
> > 
> > radeonfb oopses on intel.
> > Havent checked yet when it started with it.
> > 
> > ACPI: PCI interrupt 0000:00:12.0[A] -> GSI 11 (level, low) -> IRQ 11
> > eth0: VIA Rhine II at 0x1c400, 00:11:5b:83:1e:76, IRQ 11.
> > eth0: MII PHY found at address 1, status 0x7869 advertising 05e1 Link 45e1.
> > usb 5-1: new low speed USB device using uhci_hcd and address 2
> > ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
> > radeonfb: Found Intel x86 BIOS ROM Image
> > radeonfb: Retreived PLL infos from BIOS
> > radeonfb: Reference=27.00 MHz (RefDiv=60) Memory=133.00 Mhz, System=133.00 MHz
> > radeonfb: PLL min 12000 max 35000
> > NET: Registered protocol family 23
> > radeonfb: Monitor 1 type DFP found
> > radeonfb: EDID probed
> > radeonfb: Monitor 2 type no found
> > radeonfb: Assuming panel size 8x1
> 
> Hrm... that's totally bogus. What machine is this ?

Some i386 box with radeon 7000.

> > radeonfb: Can't find mode for panel size, going back to CRT
> > Unable to handle kernel paging request at virtual address f3fb4000
> 
> I'm having a hard time parsing this oops. Looks like fbcon is screwing
> up, I'm not sure what radeonfb has to do with the problem there...

I will try with atyfb on another intel box.
