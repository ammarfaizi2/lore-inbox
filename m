Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280800AbRKBTEQ>; Fri, 2 Nov 2001 14:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280797AbRKBTDL>; Fri, 2 Nov 2001 14:03:11 -0500
Received: from air-1.osdl.org ([65.201.151.5]:31499 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S280795AbRKBTCA>;
	Fri, 2 Nov 2001 14:02:00 -0500
Message-ID: <3BE2EBF4.52E3F906@osdl.org>
Date: Fri, 02 Nov 2001 10:54:44 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kirill Ratkin <kratkin@egartech.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: PCMCIA->USB
In-Reply-To: <3BE29AC3.DEB4B31A@egartech.com> <3BE2CC18.976C2A9B@osdl.org> <3BE2D20C.3F7E7817@egartech.com> <3BE2D2F9.B9058C81@osdl.org> <3BE2DBA9.847AA3C0@egartech.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Ratkin wrote:
> 
> "Randy.Dunlap" wrote:
> >
> > Kirill Ratkin wrote:
> > >
> > > "Randy.Dunlap" wrote:
> > > >
> > > > The usb-ohci driver has been known to work with PCMCIA/USB OHCI
> > > > cards.
> >
> > Do you mean that you are working on a PCMCIA (CardBus I hope ?)
> > to USB card and want to know if it will work with Linux?
> >
> > Is it OHCI- or UHCI- or ECHI-based (USB controller)?
> 
> I have device (see description below) and I started to find
> documentation for it now (I'd like to write driver of it for education
> goals). And I ask because may be somebody wrote it already and there
> isn't necessary to write same one.
> 
> --->>>---
> ? For PC, Notebook and MAC Powerbook ? Adds two USB ports into your
> notebook
> computer for instant multiple USB device connections ? Built in driver
> support from Apple and
> Microsoft PC : Windows 98 , Windows 98 SE, Windows ME, Windows 2000 Mac
> : OS 8.6 or
> later ? Compliant with USB Specification, Version 1.1 ? Compliant with
> OpenHCI
> Specification, Revision 1.0a ? Chip set: Opti chip ? Regulatory
> approval(s): FCC Class B & CE
> ? Version: v1.0
> ---<<<---

That's an OHCI ("OpenHCI" above) controller.
The usb-ohci driver works with that chip.
You don't need to write another one.

~Randy
