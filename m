Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318033AbSIJTTu>; Tue, 10 Sep 2002 15:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318035AbSIJTTu>; Tue, 10 Sep 2002 15:19:50 -0400
Received: from msp-65-29-16-62.mn.rr.com ([65.29.16.62]:10881 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S318033AbSIJTTt>; Tue, 10 Sep 2002 15:19:49 -0400
Date: Tue, 10 Sep 2002 14:23:47 -0500
From: Shawn <core@enodev.com>
To: Mike Galbraith <efault@gmx.de>
Cc: Shawn <core@enodev.com>, Andi Kleen <ak@suse.de>,
       Thunder from the hill <thunder@lightweight.ods.org>,
       linux-kernel@vger.kernel.org
Subject: Re: XFS?
Message-ID: <20020910142347.A5000@q.mn.rr.com>
References: <p73wupuq34l.fsf@oldwotan.suse.de> <20020909193820.GA2007@lnuxlab.ath.cx.suse.lists.linux.kernel> <Pine.LNX.4.44.0209091457590.3793-100000@hawkeye.luckynet.adm.suse.lists.linux.kernel> <p73wupuq34l.fsf@oldwotan.suse.de> <20020909162050.B4781@q.mn.rr.com> <5.1.0.14.2.20020910190828.00b27258@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <5.1.0.14.2.20020910190828.00b27258@pop.gmx.net>; from efault@gmx.de on Tue, Sep 10, 2002 at 07:15:08PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not sure what this is intended to communicate.

The question was specifically regarding filesystem support, so I'll
assume you meant to point out that XFS does not always work like it
should.

Then, am I incorrect that since almost all of XFS that's left to merge
is XFS code and not changes to the kernel at large?

If this is correct, could I then make the assumption that merging XFS
would be minimally impactful for those kernel user who do not enable it?

Linus incorporated reiserfs long before it "always functioned as it is
supposed to", so I find myself wondering where your point was.

(see below) and "^^^^^^^^^^^^^" don't fully cover your thoughts I'm
afraid.

On 09/10, Mike Galbraith said something like:
> At 04:20 PM 9/9/2002 -0500, Shawn wrote:
> >XFS needs a sponser. Who amung Linus's circle of trust cares to comment
> >or re-evaluate?
> >
> >If no one, I guess it's a moot point.
> 
> (see below)
> 
> >On 09/09, Andi Kleen said something like:
> > > Thunder from the hill <thunder@lightweight.ods.org> writes:
> > >
> > > > Hi,
> > > >
> > > > On Mon, 9 Sep 2002, khromy wrote:
> > > > > What's up with XFS in linux-2.5? I've seen some patches sent to the 
> > list
> > > > > but I havn't seen any replies from linus.. What needs to be done to
> > > > > finally merge it?
> > > >
> > > > It has been stated quite regularly that XFS
> > > > a) doesn't always work like it should yet
> > >
> > > That's quite bogus. While not being perfect XFS just works fine for lots
> > > of people in production and performs very well for a lot of tasks.
> > >
> > > > b) involves some changes which Linus doesn't like in particular, for
> > > >    pretty good reasons.
> > >
> > > I think that's FUD too. That last patch had 6 lines or so of changes
> > > to generic code, everything else was already merged.
> 
>                               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
>          -Mike
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--
Shawn Leas
core@enodev.com

I got food poisoning today.  I don't know when I'll use it.
						-- Stephen Wright
