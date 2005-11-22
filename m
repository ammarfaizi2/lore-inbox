Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750832AbVKVOHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbVKVOHP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 09:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbVKVOHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 09:07:15 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:5011 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP
	id S1750832AbVKVOHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 09:07:13 -0500
Date: Tue, 22 Nov 2005 15:07:20 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Airlie <airlied@gmail.com>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Small PCI core patch
Message-ID: <20051122140719.GA6784@stiffy.osknowledge.org>
References: <20051121225303.GA19212@kroah.com> <20051121230136.GB19212@kroah.com> <1132616132.26560.62.camel@gaston> <21d7e9970511211647r4df761a2l287715368bf89eb6@mail.gmail.com> <1132623268.20233.14.camel@localhost.localdomain> <1132626478.26560.104.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132626478.26560.104.camel@gaston>
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.15-rc2-marc
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Benjamin Herrenschmidt <benh@kernel.crashing.org> [2005-11-22 13:27:57 +1100]:

> On Tue, 2005-11-22 at 01:34 +0000, Alan Cox wrote:
> > On Maw, 2005-11-22 at 11:47 +1100, Dave Airlie wrote:
> > > And funny enough unlike SCSI adapters and things for large server
> > > installations, nobody seems to really care enough about graphics
> > > cards, I've heard horror stories about how little Linux companies
> > 
> > Its easy to see why
> > 
> > The graphics market between Nvidia and ATI is extreme rivalry
> > There have been some ugly patent lawsuits
> > Good software tricks can make the weaker hardware win
> > Its very hard to write
> 
> On the other hand, there is little justification not to open source at
> least the kernel & basic mode setting part. It's all plumbing and mode
> setting stuff, monitor detection, etc... it's not part of any of the big
> added value or IP stuff that can be found in the 3D engine.
> 
> I've talked to them several times about that, trying to advocate really
> only putting the GL -> engine command stream generation in a binary blob
> (in userland where it belongs) and have everything else open sourced,
> but they aren't interested. In many cases, the replies I get are along
> the lines of "why would we do that ? nVidia doesn't" or "why could we
> care", or "give us a business justification" (the later translates to:
> prove us that by doing so, we'll sell that many more million cards,
> which is obviously impossible) etc... They really doesn't give a shit
> about what we think, and will continue to do so until they get a bit fat
> lawsuite, that is my opinion at least.

I assume they will rather completely drop development of the driver
instead of developing an OSS driver. I cannot imagine that the 'few'
people using Nvidia cards on some non-Windows systems are enough to
proceed developing the closed-source driver. Or maybe they just stop
developing the driver to hit us hard in the face! So we're left with
nothing than just some old closed-source crap. I think it's getting
even more realistic when a lawsuit is knocking on their doors. Don't you
think?

I use my Nvidia card without the Nvidia drivers for long time now. For
pure X without games and just GNOME and coding I have no need to run the
proprietary driver at all. But maybe for others (mostly for people with
laptops where you cannot simply change video cards due to a
vendor-designed form-factor) it could get worst. What is left for them?
Run non-X environments on the laptop? Even run Windows on it? Puh!

A damn stupid circumstance with Nvidia in the end... 

Marc
