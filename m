Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268035AbUJJCGd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268035AbUJJCGd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 22:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268037AbUJJCGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 22:06:33 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:13968 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268035AbUJJCG3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 22:06:29 -0400
Message-ID: <58cb370e041009190678aa4c87@mail.gmail.com>
Date: Sun, 10 Oct 2004 04:06:25 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Martins Krikis <mkrikis@yahoo.com>
Subject: Re: [Announce] "iswraid" (ICH5R/ICH6R ataraid sub-driver) for 2.4.28-pre3
Cc: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
In-Reply-To: <20041010010051.73780.qmail@web13708.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <58cb370e04100916441c1b74d@mail.gmail.com>
	 <20041010010051.73780.qmail@web13708.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Oct 2004 18:00:51 -0700 (PDT), Martins Krikis
<mkrikis@yahoo.com> wrote:
> --- Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> 
> > On Sat, 9 Oct 2004 16:03:00 -0700 (PDT), Martins Krikis
> > <mkrikis@yahoo.com> wrote:
> > > --- Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl> wrote:
> > >
> > > > I may sound like an ignorant but...
> > > >
> > > > Why can't device mapper be merged into 2.4 instead?
> > >
> > > "Instead" is the key word here... That would mean that
> > > Boji's and my work has been largely in vain and that the
> > > driver that to my best knowledge currently provides the
> > > simplest (from a user's point of view) cooperation with
> > > Intel RAID OROM and the most comlete feature-set regarding
> > > Intel RAID metadata interpretation and updates would not
> > > make it to the kernel. I have nothing against device mapper
> > > being merged into 2.4 but I don't consider that a fair
> > > reason for not considering iswraid.
> >
> > Well, in some way this speaks against merging iswraid in 2.4.
> > If it provides "the most comlete feature-set regarding Intel RAID
> > metadata interpretation and updates" then merging it would
> > create regression when compared to 2.6, wouldn't it?
> 
> Are you trying to say that "iswraid might look too good"
> compared to what is currently available on 2.6 and therefore
> should not be considered for inclusion in 2.4? A most interesting
> reason indeed, I'm glad I said "fair" higher above, which it

I said it before: iswraid in 2.4 is fine with.

> certainly wouldn't be. Now, if such criteria were applied
> against all new work, wouldn't that discourage new people
> from contributing?

We SHOULD be discouraging new people from
contributing to DEPRECATED kernel series.

You can treat my complaints as "2.4 kernel tax". :-)

> > > > Is there something wrong with 2.4 device mapper patch?
> > >
> > > I don't think so. However, I do believe that iswraid has
> > > some advantages, one of them being the ability to just link
> > > it statically with the rest of the kernel and not needing
> > > any user-space support code, i.e., initrd is not necessary.
> >
> > Yep, no doubt it is easier to use but harder to maintain.
> 
> Which is why it is the 2.6 kernel way. As for 2.4,
> iswraid exists and I was planning to take responsibility
> for it. Not that I'm a kernel expert, but I believe I
> know what I was trying to put in iswraid.

I don't question that.

> > > My email archive and the feedback on iswraid's project
> > > page actually contains many requests for an iswraid port
> > > to 2.6. Which I'm reading as a sign that some users
> > > actually like it.
> >
> > iswraid and 2.6 is a no go for obvious reason (no ataraid)
> 
> Actually, that is not the reason. There is very little
> dependence on ataraid in iswraid. It would be quite easy
> to make iswraid a completely standalone driver. It has not
> been ported to 2.6 primarily because it would not be welcome

not because user-space solution is superior?

> there, but I never expected any animosity towards it in 2.4.

I'm sorry that I dare to not love iswraid... ;-)
