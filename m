Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316780AbSE0XI6>; Mon, 27 May 2002 19:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316781AbSE0XI5>; Mon, 27 May 2002 19:08:57 -0400
Received: from [209.184.141.163] ([209.184.141.163]:16283 "HELO UberGeek")
	by vger.kernel.org with SMTP id <S316780AbSE0XI4>;
	Mon, 27 May 2002 19:08:56 -0400
Subject: Re: [BUG] 2.4 VM sucks. Again
From: Austin Gonyou <austin@digitalroadkill.net>
To: Austin Gonyou <austin@digitalroadkill.net>
Cc: Marco Colombo <marco@esi.it>, linux-kernel@vger.kernel.org
In-Reply-To: <1022538288.25097.2.camel@UberGeek>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 27 May 2002 18:08:52 -0500
Message-Id: <1022540932.29149.3.camel@UberGeek>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just to clarify, it was Sparc v. x86. (which is what I meant to state in
my first sentence there. :)

On Mon, 2002-05-27 at 17:24, Austin Gonyou wrote:
> I'm not referring to just *non* x86 arches in this case. Sorry about
> that. Any setup can be non-monolithic, but the measurement to decide if
> it is cost worthy is price/performance ratio. 
> 
> I'm not saying that "if it's not x86, it's monolithic",  in the context
> of the discussion, it's really about large costly boxes, designed to be
> large, costly boxes. That, from this perspective, is monolithic. 
> 
> 
> On Mon, 2002-05-27 at 04:24, Marco Colombo wrote:
> > On 24 May 2002, Austin Gonyou wrote:
> > 
> > > On Fri, 2002-05-24 at 11:31, Martin J. Bligh wrote:
> > > > >> I'm not sure exactly what Roy was doing, but we were taking a machine
> > > > >> with 16Gb of RAM, and reading files into the page cache - I think we built up
> > > > >> 8 million buffer_heads according to slabinfo ... on a P4 they're 128 bytes each,
> > > > >> on a P3 96 bytes.
> > > > > 
> > > > > The buffer heads one would make sense. I only test on realistic sized systems. 
> > > > 
> > > > Well, it'll still waste valuable memory there too, though you may not totally kill it.
> > > > 
> > > > > Once you pass 4Gb there are so many problems its not worth using x86 in the
> > > > > long run
> > > > 
> > > I assume that you mean by "not worth using x86" you're referring to say,
> > > degraded performance over other platforms? Well...if you talk
> > > price/performance, using x86 is perfect in those terms since you can buy
> > > more boxes and have a more fluid architecture, rather than building a
> > > monolithic system. Monolithic systems aren't always the best. Just look
> > > at Fermilab!
> > 
> > Uh? There are many alpha-based clusters out there. Why do you think 
> > !x86 == monolithic?
> > 
> > .TM.
> > -- 
> >       ____/  ____/   /
> >      /      /       /			Marco Colombo
> >     ___/  ___  /   /		      Technical Manager
> >    /          /   /			 ESI s.r.l.
> >  _____/ _____/  _/		       Colombo@ESI.it
> > 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
