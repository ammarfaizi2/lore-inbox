Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129933AbQLVTtg>; Fri, 22 Dec 2000 14:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129652AbQLVTt1>; Fri, 22 Dec 2000 14:49:27 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:26373 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130073AbQLVTtS>; Fri, 22 Dec 2000 14:49:18 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: recommended gcc compiler version
Date: 22 Dec 2000 11:17:58 -0800
Organization: Transmeta Corporation
Message-ID: <9209d6$7nt$1@penguin.transmeta.com>
In-Reply-To: <0012212320430F.02217@comptechnews> <001901c06bdf$1d6c74e0$3b42b0d1@pittscomp.com> <20001221230819.A1678@scutter.internal.splhi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20001221230819.A1678@scutter.internal.splhi.com>,
Tim Wright  <timw@splhi.com> wrote:
>
>So....
>egcs-1.1.2 is good for either, 2.7.2 is OK for 2.2, bad for 2.4. 2.95.2 and
>later are risky. RedHat just released a bugfixed "2.96" which is an unknown
>quantity AFAIK. Anybody brave enough to try it should probably post their
>results.

Note that despite my public comments about it beign a bad idea to ship
extremely untested compilers in a major release, I actually think that
it would be wonderful to have people who are ready to face the
consequences to try the new 2.96. 

It's not been all that widely tested, but if you kno a bit about what
you're doing (or want to learn), gcc-2.96 _does_ potentially create
better code, and if nobody is willing to test it, any potential bugs (be
they in the kernel sources and triggered by a smarter compiler, or in
the compiler itself) won't be found. 

So please do try it out, but please mention the fact if you end up
having to report a bug (it won't make your bug-report be ignored, don't
ever worry about something like that. But i would be good to have an
older compiler handy to correlate the bug with the compiler for sure).

In fact, I'd love to hear about experiences even with the CVS snapshots.
I just don't like them showing up in distributions ;)

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
