Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264679AbSLRQkw>; Wed, 18 Dec 2002 11:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264688AbSLRQkv>; Wed, 18 Dec 2002 11:40:51 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:46092 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264679AbSLRQkv>; Wed, 18 Dec 2002 11:40:51 -0500
Date: Wed, 18 Dec 2002 08:49:37 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Dave Jones <davej@codemonkey.org.uk>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>, <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@redhat.com>, Andrew Morton <akpm@digeo.com>
Subject: Freezing.. (was Re: Intel P6 vs P7 system call performance)
In-Reply-To: <20021218164119.GC27695@suse.de>
Message-ID: <Pine.LNX.4.44.0212180844550.29852-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 Dec 2002, Dave Jones wrote:
> On Wed, Dec 18, 2002 at 10:40:24AM -0300, Horst von Brand wrote:
>  > [Extremely interesting new syscall mechanism tread elided]
>  >
>  > What happened to "feature freeze"?
>
> *bites lip* it's fairly low impact *duck*.

However, it's a fair question.

I've been wondering how to formalize patch acceptance at code freeze, but
it might be a good idea to start talking about some way to maybe put
brakes on patches earlier, ie some kind of "required approval process".

I think the system call thing is very localized and thus not a big issue,
but in general we do need to have something in place.

I just don't know what that "something" should be. Any ideas? I thought
about the code freeze require buy-in from three of four people (me, Alan,
Dave and Andrew come to mind) for a patch to go in, but that's probably
too draconian for now. Or is it (maybe start with "needs approval by two"
and switch it to three when going into code freeze)?

			Linus

