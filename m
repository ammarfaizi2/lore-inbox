Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316777AbSE0WZT>; Mon, 27 May 2002 18:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316779AbSE0WZS>; Mon, 27 May 2002 18:25:18 -0400
Received: from adsl-66-136-200-16.dsl.austtx.swbell.net ([66.136.200.16]:33410
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S316777AbSE0WZO>; Mon, 27 May 2002 18:25:14 -0400
Subject: Re: [BUG] 2.4 VM sucks. Again
From: Austin Gonyou <austin@digitalroadkill.net>
To: Marco Colombo <marco@esi.it>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0205271119430.5096-100000@Megathlon.ESI>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: http://www.digitalroadkill.net
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 27 May 2002 17:24:48 -0500
Message-Id: <1022538288.25097.2.camel@UberGeek>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm not referring to just *non* x86 arches in this case. Sorry about
that. Any setup can be non-monolithic, but the measurement to decide if
it is cost worthy is price/performance ratio. 

I'm not saying that "if it's not x86, it's monolithic",  in the context
of the discussion, it's really about large costly boxes, designed to be
large, costly boxes. That, from this perspective, is monolithic. 


On Mon, 2002-05-27 at 04:24, Marco Colombo wrote:
> On 24 May 2002, Austin Gonyou wrote:
> 
> > On Fri, 2002-05-24 at 11:31, Martin J. Bligh wrote:
> > > >> I'm not sure exactly what Roy was doing, but we were taking a machine
> > > >> with 16Gb of RAM, and reading files into the page cache - I think we built up
> > > >> 8 million buffer_heads according to slabinfo ... on a P4 they're 128 bytes each,
> > > >> on a P3 96 bytes.
> > > > 
> > > > The buffer heads one would make sense. I only test on realistic sized systems. 
> > > 
> > > Well, it'll still waste valuable memory there too, though you may not totally kill it.
> > > 
> > > > Once you pass 4Gb there are so many problems its not worth using x86 in the
> > > > long run
> > > 
> > I assume that you mean by "not worth using x86" you're referring to say,
> > degraded performance over other platforms? Well...if you talk
> > price/performance, using x86 is perfect in those terms since you can buy
> > more boxes and have a more fluid architecture, rather than building a
> > monolithic system. Monolithic systems aren't always the best. Just look
> > at Fermilab!
> 
> Uh? There are many alpha-based clusters out there. Why do you think 
> !x86 == monolithic?
> 
> .TM.
> -- 
>       ____/  ____/   /
>      /      /       /			Marco Colombo
>     ___/  ___  /   /		      Technical Manager
>    /          /   /			 ESI s.r.l.
>  _____/ _____/  _/		       Colombo@ESI.it
> 
