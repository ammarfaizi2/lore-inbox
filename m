Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261512AbSJDH1c>; Fri, 4 Oct 2002 03:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261516AbSJDH1c>; Fri, 4 Oct 2002 03:27:32 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:26126 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261512AbSJDH1a>;
	Fri, 4 Oct 2002 03:27:30 -0400
Date: Fri, 4 Oct 2002 00:30:10 -0700
From: Greg KH <greg@kroah.com>
To: jbradford@dial.pipex.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OT] 2.6 not 3.0 - (WAS Re: [PATCH-RFC] 4 of 4 - New problem
Message-ID: <20021004073010.GC4260@kroah.com>
References: <20021004063738.GB4260@kroah.com> <200210040717.g947Hx2P000478@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210040717.g947Hx2P000478@darkstar.example.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2002 at 08:17:58AM +0100, jbradford@dial.pipex.com wrote:
> > Hm, must have missed those.  I haven't seen any USB 2.0 complaints in
> > quite some time.  The majority of USB "issues" are crappy usb storage
> > devices that don't match the USB storage spec, or PCI IRQ routing
> > problems.
> 
> We have to code for the devices that are out there.  Big deal if we
> follow the spec to the letter - if Mr Average plugs in his USB device
> and it doesn't work, well, it doesn't work.  It's no good lecturing
> him on the spec.  I don't usually take that view, but when there are a
> large number of broken devices, what are the other options?

I agree, we must make these devices work.  But when your dealing with
odd devices, that violate the spec in random ways, and you don't have
documentation on how these devices are broken, and you aren't getting
paid to provide support for these devices, development can be a bit slow
at times.  And because of these factors, we will almost always lag
behind the OSes that manufacturers directly support.

> > But hey, no one cares about USB, I'm used to it :)
> 
> I certainly don't care about USB, I don't even have a USB port on my
> main box, but if you're saying that the current support is 3.0
> material, then I totally disagree.

I didn't say that it was "3.0 material", you did.

What is pretty major is the core device model.  Lots of driver api
changes and cleanups have happened in 2.5.  It's almost starting to look
sane in places :)

greg k-h
