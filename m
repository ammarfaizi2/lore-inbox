Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbWFAWAQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbWFAWAQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 18:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbWFAWAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 18:00:15 -0400
Received: from pih-relay04.plus.net ([212.159.14.131]:58596 "EHLO
	pih-relay04.plus.net") by vger.kernel.org with ESMTP
	id S1750762AbWFAWAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 18:00:13 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Greg KH <greg@kroah.com>
Subject: Re: 2.6.17-rc5-mm2 -- PCI: Bus #03 (-#06) is hidden behind transparent bridge #02 (-#02) (try 'pci=assign-busses')
Date: Thu, 1 Jun 2006 22:59:57 +0100
User-Agent: KMail/1.9.1
Cc: Bernhard Kaindl <bk@suse.de>, Miles Lane <miles.lane@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
References: <a44ae5cd0606010752n637c6411l805115f8170f0ebb@mail.gmail.com> <200606012155.16545.s0348365@sms.ed.ac.uk> <20060601213133.GC18948@kroah.com>
In-Reply-To: <20060601213133.GC18948@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606012259.57868.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 June 2006 22:31, Greg KH wrote:
> On Thu, Jun 01, 2006 at 09:55:16PM +0100, Alistair John Strachan wrote:
> > On Thursday 01 June 2006 21:30, Miles Lane wrote:
> > > Yes, my machine is a dv1240us HP laptop.  The machine appears to be
> > > working fine.  I haven't tested all the devices, but the ones I am
> > > using regularly are all happy campers.
> >
> > It seems many HP and Compaq notebooks that this problem; I've got the
> > same thing on my NC6000 and it works fine too. BIOS problem?
> >
> > Andrew, I think this message should be silenced (or at least the note
> > about LKML) if there's no evidence of breakage. For the last LKML 4-5
> > reporters, they reported no side-affects. At the very least, the message
> > could be toned down somewhat.

I've just noticed I get this on my Athlon64/nForce4 desktop machine too!

[   26.985673] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   26.985675] PCI: Probing PCI hardware (bus 00)
[   26.990495] PCI: Transparent bridge - 0000:00:09.0
[   26.990528] PCI: Bus #02 (-#05) is hidden behind transparent bridge #01 
(-#02) (try 'pci=assign-busses')
[   26.990531] Please report the result to linux-kernel to fix this 
permanently
[   26.990716] Boot video device is 0000:06:00.

This machine has PCI, PCIe, a heinous PCI-to-Cardbus adaptor with a 16bit 
PCMCIA card in it! Still working fine.

> Bernhard put that message in there for a good reason, let's let him
> decide if something needs to change or not.

Sure, of course. My bad.

-- 
Cheers,
Alistair.

Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
