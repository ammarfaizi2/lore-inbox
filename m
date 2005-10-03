Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932498AbVJCST0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498AbVJCST0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 14:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932495AbVJCST0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 14:19:26 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:55462 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S932498AbVJCSTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 14:19:25 -0400
Date: Mon, 3 Oct 2005 14:19:24 -0400
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Vadim Lobanov <vlobanov@speakeasy.net>, linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
Message-ID: <20051003181924.GB8011@csclub.uwaterloo.ca>
References: <20051002204703.GG6290@lkcl.net> <Pine.LNX.4.63.0510021704210.27456@cuia.boston.redhat.com> <20051002230545.GI6290@lkcl.net> <Pine.LNX.4.58.0510021637260.28193@shell2.speakeasy.net> <20051003005400.GM6290@lkcl.net> <Pine.LNX.4.58.0510021800240.19613@shell2.speakeasy.net> <20051003015302.GP6290@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051003015302.GP6290@lkcl.net>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2005 at 02:53:02AM +0100, Luke Kenneth Casson Leighton wrote:
>  sorry, vadim: haven't touched a shift key in over 20 years.

Except to type that ':' I suspect.

How about learning to use that shift key so that everyone else that
reads your typing don't have to spend so much time working it out when
proper syntax would have made it simpler.  It may save you 1% of your
time typing it, but you cost thousands of people much more as a result.
net loss for the world as a whole.

>  ah, i'm not: i just left out mentioning it :)
> 
>  the message passing needs to be communicated down to manage
>  threads, and also to provide a means to manage semaphores and
>  mutexes: ultimately, support for such an architecture would
>  work its way down to libc.
> 
>  and yes, if you _really_ didn't want a kernel in the way at all, you
>  could go embedded and just... do everything yourself.
> 
>  or port reactos, the free software reimplementation of nt,
>  to it, or something :)

Microkernel, message passing, blah blah blah.  Does GNU Hurd actually
run fast yet?  I think it exists finally and works (at least mostly) but
how does the performance compare?

Most of your arguments seem like a repeat of more acedemic theories most
of which have not been used in a real system where performance running
average software was important, at least I never heard of them.  Not
that that necesarily means much, other than they can't have gained much
popularity.

>  it won't stop - but the price of 90nm mask charges, at approx
>  $2m, is already far too high, and the number of large chips
>  being designed is plummetting like a stone as a result - from
>  like 15,000 per year a few years ago down to ... damn, can't remember -
>  less than a hundred (i think!  don't quote me on that!)

Hmm, so if we guess it might take 10 masks per processor type over it's
life time as they change features and such, that's still less than 1% of
the cost of the FAB in the first place.  I agree with the person that
said intel/AMD/company probably don't care much, as long as their
engineers make really darn sure that the mask is correct when they go to
make one.

>  okay: i will catch up on this bit, another time, because it is late
>  enough for me to be getting dizzy and appearing to be drunk.
> 
>  this is one answer (and there are others i will write another time.
>  hint: automated code analysis tools, auto-parallelising tools, both
>  offline and realtime):
> 
>  watch what intel and amd do: they will support _anything_ - clutch at
>  straws - to make parallelism palable, why?  because in order to be
>  competitive - and realistically priced - they don't have any choice.
> 
>  plus, i am expecting the chips to be thrown out there (like
>  the X-Box 360 which has SIX hardware threads remember) and
>  the software people to quite literally _have_ to deal with it.

Hey I like parallel processing.  i think it's neat, and I have often
made some of my own tools multithreaded just because I found it could be
done for the task, and I often find multithreaded simpler to code (I
seem to be a bit of a weirdo that way) for certain tasks.

>  i expect the hardware people to go: this is the limit, this is what we
>  can do, realistically price-performance-wise: lump it, deal with it.
> 
>  when intel and amd start doing that, everyone _will_ lump it.
>  and deal with it.
> 
>  ... why do you think intel is hyping support for and backing
>  hyperthreads support in XEN/Linux so much?

Ehm, because intel has it and their P4 desperately needs help to gain
any performance it can until they get the Pentium-M based desktop chips
finished with multiple cores, and of course because AMD doesn't have it.
Seem like good reasons for intel to try and push it.

Len Sorensen
