Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261326AbVGTBnf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbVGTBnf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 21:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbVGTBnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 21:43:35 -0400
Received: from mail20.syd.optusnet.com.au ([211.29.132.201]:2286 "EHLO
	mail20.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261326AbVGTBnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 21:43:33 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: Interbench real time benchmark results
Date: Wed, 20 Jul 2005 11:45:39 +1000
User-Agent: KMail/1.8.1
Cc: dwalker@mvista.com, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, ck@vds.kolivas.org
References: <200507200816.11386.kernel@kolivas.org> <1121822524.26927.85.camel@dhcp153.mvista.com> <9a8748490507191831267b17d9@mail.gmail.com>
In-Reply-To: <9a8748490507191831267b17d9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507201145.39378.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jul 2005 11:31 am, Jesper Juhl wrote:
> On 7/20/05, Daniel Walker <dwalker@mvista.com> wrote:
> > On Wed, 2005-07-20 at 11:04 +1000, Con Kolivas wrote:
> > > On Wed, 20 Jul 2005 10:23 am, Daniel Walker wrote:
> > > > On Wed, 2005-07-20 at 00:32 +0200, Ingo Molnar wrote:
> > > > >  - networking is another frequent source of latencies - it might
> > > > > make sense to add a workload doing lots of socket IO. (localhost
> > > > > might be enough, but not for everything)
> > > >
> > > > The Gnutella test?
> > >
> > > I've seen some massive latencies on mainline when throwing network
> > > loads from outside, but with my limited knowledge I haven't found a way
> > > to implement such a thing locally. I'll look at this gnutella test at
> > > some stage to see what it is and if I can adopt the load within
> > > interbench. Thanks for the suggestion.
> >
> > There isn't actually a test called "The Gnutella test" , but I think
> > Gnutella clients put lots of network load on a system (Lee was talking
> > about that not to long ago). I was thinking that type of load may have
> > been what Ingo was talking about.
>
> If you want to generate a lot of network related interrupts, wouldn't
> a much simpler way to do that be a simple
>
>   ping -f targetbox
>
> from a host connected to `targetbox' via a crosswired ethernet cable
> or a fast switch..?
>
> Also easy to modify the size of the ping packets if you want to.

Well that load works very well, but once again it isn't really something that 
can be done locally on one box running init 1.

Cheers,
Con
