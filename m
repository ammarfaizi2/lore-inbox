Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265825AbUGZTbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265825AbUGZTbN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 15:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265777AbUGZTad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 15:30:33 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:8432 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S265993AbUGZSJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 14:09:11 -0400
Date: Mon, 26 Jul 2004 14:45:15 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: "R. J. Wysocki" <rjwysocki@sisk.pl>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Con Kolivas <kernel@kolivas.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Autotune swappiness01
Message-ID: <20040726144515.A10583@mail.kroptech.com>
References: <cone.1090801520.852584.20693.502@pc.kolivas.org> <4104E863.6070102@kolivas.org> <4104EF5F.9070405@yahoo.com.au> <200407261553.09594.rjwysocki@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200407261553.09594.rjwysocki@sisk.pl>; from rjwysocki@sisk.pl on Mon, Jul 26, 2004 at 03:53:09PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2004 at 03:53:09PM +0200, R. J. Wysocki wrote:
> On Monday 26 of July 2004 13:47, Nick Piggin wrote:
> > Con Kolivas wrote:
> > > Nick Piggin wrote:
> > >> Con Kolivas wrote:
> > >>> In my ideal, nonsensical, impossible to obtain world we have an
> > >>> autoregulating operating system that doesn't need any knobs.
> > >>
> > >> Some thinks are fundamental tradeoffs that can't be autotuned.
> > >>
> > >> Latency vs throughput comes up in a lot of places, eg. timeslices.
> > >>
> > >> Maximum throughput via effective use of swap, versus swapping as
> > >> a last resort may be another.
> > >
> > > As I said... it was ideal, nonsensical, and impossible. Doesn't sound
> > > like you're arguing with me.
> >
> > No, you're right. My ideal operating system knows what the user
> > wants too ;)
> 
> Well, what I hate about various computer programs is that they seem to assume 
> to know what I (the USER) want and they don't let me do anything else that 
> they "know" what I should/would do. ;-)
> 
> > Most of the time though, you are right. The quality/desirability of an
> > implementation will be inversely proportional to the number of knobs
> > sticking out of it (with bonus points for those that are meaningful to
> > 2 people on the planet).
> 
> Can you please tell me why you think that the least tunable implementation 
> should be the best/most desirable one?  I always prefer the most tunable 
> implementations which is quite opposite to what you have said, but this is my 
> personal opinion, of course.

The implementation with the least *need* for tuning is the most
desirable. I, for one, don't care if there are a dozen knobs as long as
99% of users don't have to touch them. But if common usage scenarios
require turning knobs to get reasonable performance, the algorithm is
lacking.

Thanks to fuel injection and engine management I can drive from LA to
Denver and not need to tweak my carburator half way up the Rockies.
I've given up some chances for tuning, but overall I'm better off. If 
you want to stick a trimpot or ten out the side of the engine management 
computer so true gearheads can tweak another couple HP or MPG out of the
engine, great. But don't expect me to fiddle with it every time driving
conditions change; it's not an excuse to make the management algorithms
inadequate for common driving patterns.

--Adam

