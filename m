Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290624AbSARHeN>; Fri, 18 Jan 2002 02:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290625AbSARHeD>; Fri, 18 Jan 2002 02:34:03 -0500
Received: from [208.29.163.248] ([208.29.163.248]:23455 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S290624AbSARHdp>; Fri, 18 Jan 2002 02:33:45 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Ben Greear <greearb@candelatech.com>
Cc: linux-kernel@vger.kernel.org
Date: Thu, 17 Jan 2002 23:33:26 -0800 (PST)
Subject: Re: Tulip driver bug in 2.4.17 (fwd)
In-Reply-To: <3C479D4E.1010908@candelatech.com>
Message-ID: <Pine.LNX.4.40.0201172331130.27276-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jan 2002, Ben Greear wrote:

> David Lang wrote:
>
> > On Thu, 17 Jan 2002, Ben Greear wrote:
> >
> >
> >>You're not using a PCI extender/riser card, are you?
> >>
> >
> > Yes, (it's in a 2u rackmount case). it's a low right-angle extender
>
>
> You're screwed :)
>
> It seems to be a hardware/PCI problem.  I replaced 4-port NICS (the DFE-570-TX),
> motherboards, cpus, entire chassis...the problem followed the riser cards.

then why does the same card work properly with the old driver? if it's
truely a hardware problem then all versions of the driver should fail. if
it's possible for one version to work around the problem (or avoid
triggering it) then other versions should be able to.

> To debug, take off the face-plates of your NICS and run them in your box
> w/out the riser..or take the MB completely out of the case.  I'll bet
> you a dozen realtec nics that that will fix your lockup problem! :)
>
> While you're doing that...order a $54 riser from adexelec.com.  Their
> riser fixed the problem for me.  If the riser isn't obvious on
> Adex's page, let me know and I'll find the version of the one I got.
>
> Btw, if you find a butter-fly riser for a 1U chassis that works, let
> me know..cause I see the same problem in my 1U servers...
>
> Enjoy,
> Ben
>
>
> --
> Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
> President of Candela Technologies Inc      http://www.candelatech.com
> ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
>
>
