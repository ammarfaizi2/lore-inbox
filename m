Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265487AbUGZVaJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265487AbUGZVaJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 17:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265932AbUGZVaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 17:30:09 -0400
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:55305 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S265487AbUGZV36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 17:29:58 -0400
Message-ID: <410577D4.1010800@zero10.demon.co.uk>
Date: Mon, 26 Jul 2004 22:29:56 +0100
From: DaMouse <damouse@zero10.demon.co.uk>
User-Agent: Mozilla Thunderbird 0.6+ (Windows/20040706)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Autotune swappiness01
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perhaps the answer is a CONFIG_USERCONFIG or similar like in the car scenario,
those who like to take tools with them to fiddle and those who just like to drive.

-DaMouse

Previous Messages:

On Monday 26 of July 2004 20:45, Adam Kropelin wrote:
> On Mon, Jul 26, 2004 at 03:53:09PM +0200, R. J. Wysocki wrote:
> > On Monday 26 of July 2004 13:47, Nick Piggin wrote:
> > > Con Kolivas wrote:
> > > > Nick Piggin wrote:
> > > >> Con Kolivas wrote:
> > > >>> In my ideal, nonsensical, impossible to obtain world we have an
> > > >>> autoregulating operating system that doesn't need any knobs.
> > > >>
> > > >> Some thinks are fundamental tradeoffs that can't be autotuned.
> > > >>
> > > >> Latency vs throughput comes up in a lot of places, eg. timeslices.
> > > >>
> > > >> Maximum throughput via effective use of swap, versus swapping as
> > > >> a last resort may be another.
> > > >
> > > > As I said... it was ideal, nonsensical, and impossible. Doesn't sound
> > > > like you're arguing with me.
> > >
> > > No, you're right. My ideal operating system knows what the user
> > > wants too ;)
> >
> > Well, what I hate about various computer programs is that they seem to
> > assume to know what I (the USER) want and they don't let me do anything
> > else that they "know" what I should/would do. ;-)
> >
> > > Most of the time though, you are right. The quality/desirability of an
> > > implementation will be inversely proportional to the number of knobs
> > > sticking out of it (with bonus points for those that are meaningful to
> > > 2 people on the planet).
> >
> > Can you please tell me why you think that the least tunable
> > implementation should be the best/most desirable one?  I always prefer
> > the most tunable implementations which is quite opposite to what you have
> > said, but this is my personal opinion, of course.
>
> The implementation with the least *need* for tuning is the most
> desirable. I, for one, don't care if there are a dozen knobs as long as
> 99% of users don't have to touch them. But if common usage scenarios
> require turning knobs to get reasonable performance, the algorithm is
> lacking.

I agree in 100%.

> Thanks to fuel injection and engine management I can drive from LA to
> Denver and not need to tweak my carburator half way up the Rockies.
> I've given up some chances for tuning, but overall I'm better off. If
> you want to stick a trimpot or ten out the side of the engine management
> computer so true gearheads can tweak another couple HP or MPG out of the
> engine, great. But don't expect me to fiddle with it every time driving
> conditions change; it's not an excuse to make the management algorithms
> inadequate for common driving patterns.

I didn't mean that.  Actually, I was trying to say that an additional "knob" 
(or "knobs") might be useful in determining the "common settings" acceptable 
for the 99% of users.  Then, it could be "hidden" (which I wouldn't do, but 
well ...).
Yours,
rjw

