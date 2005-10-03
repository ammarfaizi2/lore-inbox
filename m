Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932250AbVJCOUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbVJCOUr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 10:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932246AbVJCOUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 10:20:47 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:15560 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932250AbVJCOUr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 10:20:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CaqHFhStoRpsve+a/uFBSYX9fUhKlKZYVFaGyuplxCtooWrG0VNR+pUVixJykC9MhFWUtcr70bUGOlcwaR83inTinfFACLXObajN2NdUzjrciCEX2GjRNdmWXUFI+5MmgRnSCNAj95sNn3f8VfQlxQi54zO6yDRS7OKRIlpJowo=
Message-ID: <35fb2e590510030720t416dc210xc4e4eb11b3972822@mail.gmail.com>
Date: Mon, 3 Oct 2005 15:20:46 +0100
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: what's next for the linux kernel?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051002204703.GG6290@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051002204703.GG6290@lkcl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/05, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:

> as i love to put my oar in where it's unlikely that people
> will listen, and as i have little to gain or lose by doing
> so, i figured you can decide for yourselves whether to be
> selectively deaf or not:

Hi Luke,

Haven't seen you since I believe you gave a somewhat interesting talk
on FUSE at an OxLUG a year or more back. I don't think anyone here is
selectively deaf, but some might just ignore you for such comments :-)

> what prompted me to send this message now was a recent report
> where linus' no1 patcher is believed to be close to overload,
> and in that report, i think it was andrew morton, it was
> said that he believed the linux kernel development rate to be
> slowing down, because it is nearing completion.

There was some general bollocks about Andrew being burned out, but
that wasn't what the point was as far as I saw it - more about how
things could be better streamlined than a sudden panic moment.

> i think it safe to say that a project only nears completion
> when it fulfils its requirements and, given that i believe that
> there is going to be a critical shift in the requirements, it
> logically follows that the linux kernel should not be believed
> to be nearing completion.

Whoever said it was?

> with me so far? :)

I don't think anyone with moderate grasp of the English language won't
have understood what you wrote above. They might not understand why
you said it, but that's another issue.

> the basic premise: 90 nanometres is basically... well...
> price/performance-wise, it's hit a brick wall at about 2.5Ghz, and
> both intel and amd know it: they just haven't told anyone.

But you /know/ this because you're a microprocessor designer as well
as a contributor to the FUSE project?

> anyone (big) else has a _really_ hard time getting above 2Ghz,
> because the amount of pipelining required is just... insane
> (see recent ibm powerpc5 see slashdot - what speed does it do?
> surprise: 2.1Ghz when everyone was hoping it would be 2.4-2.5ghz).

I think there are many possible reasons for that and I doubt slashdot
will reveal any of those reasons. The main issue (as I understand it)
is that SMT/SMP is taking off for many applications and manufacturers
want to cater for them while reducing heat output - so they care less
about MHz than about potential real world performance.

> so, what's the solution?

> well.... it's to back to parallel processing techniques, of course.

Yes. Wow! Of course! Whoda thunk it? I mean, parallel processing!
Let's get that right into the kern...oh wait, didn't Alan and a bunch
of others already do that years ago? Then again, we might have missed
all of the stuff which went into 2.2, 2.4 and then 2.6?

> well - intel is pushing "hyperthreading".

Wow! Really? I seem to have missed /all/ of those annoying ads. But
please tell me some more about it!

> and, what is the linux kernel?

> it's a daft, monolithic design that is suitable and faster on
> single-processor systems, and that design is going to look _really_
> outdated, really soon.

Why? I happen to think Microkernels are really sexy in a Computer
Science masturbatory kind of way, but Linux seems to do the job just
fine in real life. Do we need to have this whole
Microkernel/Monolithic conversation simply because you misunderstood
something about the kind of performance now possible in 2.6 kernels as
compared with adding a whole pointless level of message passing
underneath?

Jon.
