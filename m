Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264064AbRFGAsB>; Wed, 6 Jun 2001 20:48:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264072AbRFGArl>; Wed, 6 Jun 2001 20:47:41 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:41886 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S264064AbRFGArk>;
	Wed, 6 Jun 2001 20:47:40 -0400
Message-ID: <3B1ED74E.12684800@candelatech.com>
Date: Wed, 06 Jun 2001 18:22:22 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: "David S. Miller" <davem@redhat.com>,
        "Matt D. Robinson" <yakker@alacritech.com>,
        "La Monte H.P. Yarroll" <piggy@em.cig.mot.com>,
        linux-kernel@vger.kernel.org, sctp-developers-list@cig.mot.com
Subject: Re: [PATCH] sockreg2.4.5-05 inet[6]_create() register/unregister table
In-Reply-To: <200106051659.LAA20094@em.cig.mot.com>
		<3B1E5CC1.553B4EF1@alacritech.com>
		<15134.42714.3365.32233@theor.em.cig.mot.com>
		<15134.43914.98253.998655@pizda.ninka.net>
		<3B1EBB13.34721ED9@alacritech.com>
		<15134.48456.5360.764458@pizda.ninka.net> <200106062351.f56NpOs20522@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:
> 
> David S. Miller writes:
> >
> > Matt D. Robinson writes:
> >  > > This allows people to make proprietary implementations of TCP under
> >  > > Linux.  And we don't want this just as we don't want to add a way to
> >  > > allow someone to do a proprietary Linux VM.
> >  >
> >  > And if as Joe User I don't want Linux TCP, but Joe's TCP, they can't
> >  > do that (in a supportable way)?  Are you saying Linux is, "do it my
> >  > way, or it's the highway"?
> 
> Pardon my cynicism, but this reads more like "I'm an ACME Inc. and I
> want to sell a proprietary TCP stack for Linux, please change Linux to
> make this possible/easy". I doubt there are many Joe Users out there
> who want to replace their TCP stack. I bet they would be much happier
> to see patches go in which improve the performance of the generic
> kernel.

Maybe Joe's TCP slows things down by 200% for the average user, so it
will never go into the kernel proper.  However, it has one vital
feature that Bob needs that the faster (normal) stack can't offer.

Bob gains if he can make the choice.  If the 200% slower  and - some sum of $$
makes him choose Joes TCP, so be it.  Joes TCP could be open source, or
written by the devil himself, and the technical decision can still be made
by Bob.

Now, if there are legal issues with a proprietary loadable module, that may
be another topic of discussion altogether.  Is there any restriction
on what kind of module you can load?  For instance, suppose I write an ethernet
driver that has a built in TCP/IP stack in it somehow?  This may not be smart,
but it is technically possible...

> If it bothers you that Linux caters more the the users and less to the
> vendors, then use another OS. We don't mind. The door is over there.
> Please don't slam it on your way out.

Don't spite potential users just in the hope that you might be
able to spite a few companies too.  There is no need for Joe's
TCP to be non-open-source...a modular TCP stack might be a really
good option for making $$ though support fees...  If there is a
need to keep certain (proprietary) code out of the kernel, let
lawyers & public pressure do it, not overly broad technical restrictions.

> 
> > If Joe's TCP is opensource, they are more than welcome to publish
> > such changes.
> 
> Yep. And then we can all benefit.

Agreed.

Ben

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
