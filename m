Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264915AbUGGFqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264915AbUGGFqe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 01:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264917AbUGGFqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 01:46:33 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:48913 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S264915AbUGGFq2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 01:46:28 -0400
Subject: Re: quite big breakthrough in the BAD network performance, which
	mm6 did not fix
From: Redeeman <lkml@metanurb.dk>
To: LKML Mailinglist <linux-kernel@vger.kernel.org>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>
In-Reply-To: <200407061812.24526.lkml@lpbproductions.com>
References: <200407061930.i66JUpqI009671@eeyore.valparaiso.cl>
	 <1089160973.903.1.camel@localhost>
	 <200407061812.24526.lkml@lpbproductions.com>
Content-Type: text/plain
Date: Wed, 07 Jul 2004 07:46:26 +0200
Message-Id: <1089179186.10677.8.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this must be some misunderstanding, i do not want to complain, and i
dont hope people get that impression, i am trying to do feedback, so
that issues can be fixed.

the thing about testing against a local apache, i did that, and its
fast, however, i still take that with a grain of salt, because, as said
before, even though that internet speed may vary from time to time, i
can see that kernel.org has plenty bandwith, and when 2.6.5 then
downloads with 200kb/s from http://kernel.org, and 2.6.7 only 50kb/s,
this should be able to prove its some issues with 2.6.7, but thats just
my opinion
On Tue, 2004-07-06 at 18:12 -0700, Matt Heler wrote:
> Not to sound mean about this. But either you prove your claim with benchmarks 
> in a controlled enviroment ( that means in a private network ), or you stop 
> trolling and complaining. The linux kernel is a free piece of software, if 
> you don't like one version of it, then feel free to use some earlier version. 
> Otherwise please stop. 
> 
> Matt H.
> 
> 
> On Tuesday 06 July 2004 5:42 pm, Redeeman wrote:
> > On Tue, 2004-07-06 at 15:30 -0400, Horst von Brand wrote:
> > > Redeeman <lkml@metanurb.dk> said:
> > > > On Mon, 2004-07-05 at 17:54 -0700, Matt Heler wrote:
> > > > > Ok first take benchmarks ( use wget ), and secondly results from the
> > > > > internet vary day by day , hour to hour , minute by minute. Don't
> > > > > expect all sites on the internet to be the same speed, or even stay
> > > > > the same speed for that matter. For more accurate benchmark results
> > > > > setup a personal server on your own private network and benchmark
> > > > > http trasnfers using different kernels.
> > > >
> > > > i am aware of this, however, what i use to benchmark is kernel.org, as
> > > > i can see they have alot bandwith free.
> > >
> > > How do you know that?
> >
> > how i know? i dont think anyone in the matter of seconds begin to use
> > the spare ~800mbit/s of bandwith they do not use when i try, (according
> > to info from bwbar on kernel.org)
> >
> > > > if i use kernel.org http i get 50kb/s, if i use ftp, i can easily fetch
> > > > with 200kb/s
> > >
> > > Trafic shaping somewhere along the route? Much more load on HTTP than
> > > FTP? Are they the very same machines? Under the exact same load? Are the
> > > servers written with the same care? Are the clients?
> > >
> > > > also, the gnu ftp, where i took gcc3.4.1, it gave me 200kb/s
> > >
> > > Ditto.
> > >
> > > Unless you set up something where there aren't dozens of unknown
> > > variables and a hundred or so that you have got no chance at all to even
> > > guess what their values/effects are...
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

