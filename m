Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750852AbVKWOok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbVKWOok (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 09:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750858AbVKWOok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 09:44:40 -0500
Received: from styx.suse.cz ([82.119.242.94]:46761 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1750852AbVKWOoj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 09:44:39 -0500
Date: Wed, 23 Nov 2005 15:44:37 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Kasper Sandberg <lkml@metanurb.dk>, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Christmas list for the kernel
Message-ID: <20051123144437.GB7328@ucw.cz>
References: <9e4733910511221031o44dd90caq2b24fbac1a1bae7b@mail.gmail.com> <20051122204918.GA5299@kroah.com> <9e4733910511221313t4a1e3c67wc7b08160937eb5c5@mail.gmail.com> <1132694935.10574.2.camel@localhost> <9e4733910511221341u695f6765k985ecf0c54daba49@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910511221341u695f6765k985ecf0c54daba49@mail.gmail.com>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2005 at 04:41:02PM -0500, Jon Smirl wrote:
> On 11/22/05, Kasper Sandberg <lkml@metanurb.dk> wrote:
> > > Currently you have to compile most of this stuff into the kernel.
> > forgive my ignorance, but whats stopping you from doing this now?
> 
> It would be better if all of the legacy drivers could exist on
> initramfs and only be loaded if the actual hardware is present. With
> the current code someone like Redhat has to compile all of the legacy
> support into their distribution kernel. That code will be present even
> on new systems that don't have the hardware.
> 
> An example of this is that the serial driver is hard coded to report
> four legacy serial ports when my system physically only has two. I
> have to change a #define and recompile the kernel to change this.

Interesting. Something goes wrong on your system - I have only a single
serial port on my machine and it's correctly identified by PnP, with no
other ports showing up.

> The goal should be able to build something like Knoppix without
> Knoppix needing any device probing scripts. Linux is 90% of the way
> there but not 100% yet.
> 
> X is also part of the problem. Even if the kernel nicely identifies
> all of the video hardware and input devices, X ignores this info and
> looks for everything again anyway. In a more friendly system X would
> use the info the kernel provides and automatically configure itself
> for the devices present or hotplugged. You could get rid of your
> xorg.cong file in this model.
 
There is always the hope. :)

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
