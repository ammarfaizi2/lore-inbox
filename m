Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263847AbUGFNZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263847AbUGFNZg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 09:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263851AbUGFNZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 09:25:36 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:56325 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S263847AbUGFNZc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 09:25:32 -0400
Subject: Re: quite big breakthrough in the BAD network performance, which
	mm6 did not fix
From: Redeeman <lkml@metanurb.dk>
To: LKML Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <200407051754.38690.lkml@lpbproductions.com>
References: <1089070720.14870.6.camel@localhost>
	 <200407051754.38690.lkml@lpbproductions.com>
Content-Type: text/plain
Date: Tue, 06 Jul 2004 15:25:30 +0200
Message-Id: <1089120330.10626.8.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-07-05 at 17:54 -0700, Matt Heler wrote:
> Ok first take benchmarks ( use wget ), and secondly results from the internet 
> vary day by day , hour to hour , minute by minute. Don't expect all sites on 
> the internet to be the same speed, or even stay the same speed for that 
> matter. For more accurate benchmark results setup a personal server on your 
> own private network and benchmark http trasnfers using different kernels. 
i am aware of this, however, what i use to benchmark is kernel.org, as i
can see they have alot bandwith free.
if i use kernel.org http i get 50kb/s, if i use ftp, i can easily fetch
with 200kb/s
also, the gnu ftp, where i took gcc3.4.1, it gave me 200kb/s
> 
> Matt H.
> 
> 
> 
> On Monday 05 July 2004 4:38 pm, Redeeman wrote:
> > hey, i have had a breakthrough in the investigation...
> > it turns out that some sites does not load.. but you know all about
> > that, and a "fix" with sysctl fixes some of it.
> >
> > networking was generally slow - or not!
> > it seems that its only HTTP transfers going insanely slow. which also
> > probably is those ipv4 issues, so now we just need to figure out what
> > changed, and what we need to change to fix it, so that we again can get
> > all sites loading, and HTTP protocol fully functionel again.
> >
> > hope someone has some ideas.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

