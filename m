Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129257AbQLNX3e>; Thu, 14 Dec 2000 18:29:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129260AbQLNX3Y>; Thu, 14 Dec 2000 18:29:24 -0500
Received: from wg.redhat.de ([193.103.254.4]:30576 "HELO mail.redhat.de")
	by vger.kernel.org with SMTP id <S129257AbQLNX3L>;
	Thu, 14 Dec 2000 18:29:11 -0500
Date: Thu, 14 Dec 2000 23:58:44 +0100 (CET)
From: Bernhard Rosenkraenzer <bero@redhat.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: Signal 11
In-Reply-To: <Pine.LNX.4.10.10012141434320.12451-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.30.0012142351520.19104-100000@bochum.redhat.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Dec 2000, Linus Torvalds wrote:

> If you ask any gcc folks, the main reason they think this was a really
> stupid thing to do was exactly that the 2.96 thing is incompatible BOTH
> with the 2.95.x release _and_ the upcoming 3.0 release.

The same thing is true of *any* gcc release.
For example, C++-ABI wise, 2.95.x is incompatible BOTH with egcs 1.1.x
_and_ the upcoming 3.0 release.

> > Like what - gcc 2.5.8 ? The problem is not in general that the snapshot is any
> > buggier than before, but that the bugs are in different places. egcs and gcc295
> > both caused X compile problems too.
>
> gcc-2.95.2 is at least a real release, from a branch that is actively
> maintained

Not very actively.
Please take the time to compare the activity in gcc_2_95_branch with the
patches in the current "2.96" version in rawhide.

> - so a 2.95.3 is likely to happen reasonably soon, fixing as
> many problems as possible _without_ being incompatible like the snapshots
> are.

It will be incompatible with any non-2.95.x-version, and I don't think
2.96-68 is any more buggy than the current 2.95 branch.
The initial 2.96 "release" did have some odd bugs; all the known ones have
been fixed.

> Or just stay at 2.91.66 (egcs).

This may be good for the kernel, but it's not acceptable for C++.
Also, there's no support for some of the platforms we have to work with,
such as ia64 and S/390 - using different compilers for different
architectures isn't a real solution either.

> As to X compile problems - neither egcs nor 2.95.2 appears to have any
> trouble with the CVS tree.

Neither does 2.96-68.

LLaP
bero


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
