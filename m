Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932072AbVLCVxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbVLCVxU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 16:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbVLCVxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 16:53:20 -0500
Received: from nproxy.gmail.com ([64.233.182.199]:15448 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932072AbVLCVxT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 16:53:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jrkIRLL3pQzjho4reyh+FyEpfRHCoIAnqjyAqmykzfW9juh1K/bEAgG0FGFrY7EFUfWNqnyeWIItJ/9HSQJGJVeeWLNzR20GWeICffEWcNZJWjMOUVUjDRzmFYGrKo+ijqbp1ajZqX6n9L9JM2bgh0VDSENI1lrpzXpx34e0/f0=
Message-ID: <f0cc38560512031353q27ee0a2dh70e283f53671b70f@mail.gmail.com>
Date: Sat, 3 Dec 2005 22:53:18 +0100
From: "M." <vo.sinh@gmail.com>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1133645895.22170.33.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051203135608.GJ31395@stusta.de>
	 <9a8748490512030629t16d0b9ebv279064245743e001@mail.gmail.com>
	 <20051203201945.GA4182@kroah.com>
	 <f0cc38560512031254j3b28d579s539be721c247c10a@mail.gmail.com>
	 <20051203211209.GA4937@kroah.com>
	 <f0cc38560512031331x3f4006e5sc2ff51414f07ada7@mail.gmail.com>
	 <1133645895.22170.33.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/05, Arjan van de Ven <arjan@infradead.org> wrote:
>
> > <sorry for the direct reply>
> >
> > makes sense, but are you sure having distros like Debian, enterprise
> > products from redhat etc using the same 6months release for their
> > stable versions does not translate in minor fragmentation on kernel
> > development
>
> I'm quite sure that there isn't significant fragmentation; all those
> distros in their maintenance generally only take patches that are
> already upstream (or they send them upstream during the maintenance)
> just to make sure that their long term costs don't go insane
> (eg for the $nextversion, the distros can just start clean because they
> know all bugfixes from maintenance versions are already in the new
> kernel.org kernel they get; not doing that is REALLY expensive so
> distros like to avoid that)
>
>
> > and in benefits for every user?
>
> you can't have it both ways; you can't be "new" and "old stable" at the
> same time.
>
> > . Another
> > advantage would be to benefit external projects and hardware producers
> > writing open drivers, enlowering the effort in writing and mantaining
> > a driver.
>
> there is an even better model for those: Get it merged into kernel.org!
>
>
> There is an even bigger deal here: even if you're not ready to get
> merged yet, staying on the same old version for 6 months is NOT going to
> help you. In fact it's worse: it is 10x easier to deal with 6 small
> steps of 1 month than to deal with 1 big step of 6 months.
>
>
from the kernel.org point of view it does make sense but from users
pov i think no. Users stuck with old drivers not actively mantained
would benefit from this.

There are some open drivers wrote by hardware mantainers which will
never get into kernel.org cause of code not following kernel style
guides and so on. Yeah, you should not buy poorly supported hardware
and use bad drivers but a lot of new users have poorly supported
hardware and a "more stable than usual and at fixed dates" release
could enlower the skills barrier in approaching linux.

Michele
