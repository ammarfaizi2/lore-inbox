Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264266AbUGFTa5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264266AbUGFTa5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 15:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264358AbUGFTa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 15:30:57 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:44186 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S264266AbUGFTaz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 15:30:55 -0400
Message-Id: <200407061930.i66JUpqI009671@eeyore.valparaiso.cl>
To: Redeeman <lkml@metanurb.dk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: quite big breakthrough in the BAD network performance, which mm6 did not fix 
In-Reply-To: Your message of "Tue, 06 Jul 2004 15:25:30 +0200."
             <1089120330.10626.8.camel@localhost> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Tue, 06 Jul 2004 15:30:51 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Redeeman <lkml@metanurb.dk> said:
> On Mon, 2004-07-05 at 17:54 -0700, Matt Heler wrote:

> > Ok first take benchmarks ( use wget ), and secondly results from the
> > internet vary day by day , hour to hour , minute by minute. Don't
> > expect all sites on the internet to be the same speed, or even stay the
> > same speed for that matter. For more accurate benchmark results setup a
> > personal server on your own private network and benchmark http
> > trasnfers using different kernels.

> i am aware of this, however, what i use to benchmark is kernel.org, as i
> can see they have alot bandwith free.

How do you know that?

> if i use kernel.org http i get 50kb/s, if i use ftp, i can easily fetch
> with 200kb/s

Trafic shaping somewhere along the route? Much more load on HTTP than FTP? 
Are they the very same machines? Under the exact same load? Are the servers
written with the same care? Are the clients?

> also, the gnu ftp, where i took gcc3.4.1, it gave me 200kb/s

Ditto.

Unless you set up something where there aren't dozens of unknown variables
and a hundred or so that you have got no chance at all to even guess what
their values/effects are...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
