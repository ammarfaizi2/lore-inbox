Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315926AbSEGSF4>; Tue, 7 May 2002 14:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315927AbSEGSFz>; Tue, 7 May 2002 14:05:55 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:8209 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315926AbSEGSFx>; Tue, 7 May 2002 14:05:53 -0400
Date: Tue, 7 May 2002 11:05:14 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: benh@kernel.crashing.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Padraig Brady <padraig@antefacto.com>,
        Anton Altaparmakov <aia21@cantab.net>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 56
In-Reply-To: <200205071743.g47HhZd30932@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.LNX.4.44.0205071103040.975-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 7 May 2002, Richard Gooch wrote:
>
> Actually, I've always said that I think devfs should care about both
> views.

And I think you're completely wrong.

The fact is, they are two completely different and orthogonal things, and
they have _nothing_ in common except for a very weak linkage of actual
"physical device" (which does not always exist).

The set of people that cares about one view is almost 100% different from
the set of people that care about the other view.

> Fugly. What's wrong with readlink(2) as this "magic syscall"?

Ehh - like the fact that it doesn't work on device files?

		Linus

