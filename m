Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264777AbUGGAm5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264777AbUGGAm5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 20:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264771AbUGGAm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 20:42:57 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:31557 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S264725AbUGGAm4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 20:42:56 -0400
Subject: Re: quite big breakthrough in the BAD network performance, which
	mm6 did not fix
From: Redeeman <lkml@metanurb.dk>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: LKML Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <200407061930.i66JUpqI009671@eeyore.valparaiso.cl>
References: <200407061930.i66JUpqI009671@eeyore.valparaiso.cl>
Content-Type: text/plain
Date: Wed, 07 Jul 2004 02:42:53 +0200
Message-Id: <1089160973.903.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-07-06 at 15:30 -0400, Horst von Brand wrote:
> Redeeman <lkml@metanurb.dk> said:
> > On Mon, 2004-07-05 at 17:54 -0700, Matt Heler wrote:
> 
> > > Ok first take benchmarks ( use wget ), and secondly results from the
> > > internet vary day by day , hour to hour , minute by minute. Don't
> > > expect all sites on the internet to be the same speed, or even stay the
> > > same speed for that matter. For more accurate benchmark results setup a
> > > personal server on your own private network and benchmark http
> > > trasnfers using different kernels.
> 
> > i am aware of this, however, what i use to benchmark is kernel.org, as i
> > can see they have alot bandwith free.
> 
> How do you know that?
how i know? i dont think anyone in the matter of seconds begin to use
the spare ~800mbit/s of bandwith they do not use when i try, (according
to info from bwbar on kernel.org)
> 
> > if i use kernel.org http i get 50kb/s, if i use ftp, i can easily fetch
> > with 200kb/s
> 
> Trafic shaping somewhere along the route? Much more load on HTTP than FTP? 
> Are they the very same machines? Under the exact same load? Are the servers
> written with the same care? Are the clients?
> 
> > also, the gnu ftp, where i took gcc3.4.1, it gave me 200kb/s
> 
> Ditto.
> 
> Unless you set up something where there aren't dozens of unknown variables
> and a hundred or so that you have got no chance at all to even guess what
> their values/effects are...

