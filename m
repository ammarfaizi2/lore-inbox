Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130768AbQLOSkA>; Fri, 15 Dec 2000 13:40:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130701AbQLOSju>; Fri, 15 Dec 2000 13:39:50 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:53764 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130768AbQLOSjo>; Fri, 15 Dec 2000 13:39:44 -0500
Date: Fri, 15 Dec 2000 10:08:27 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Tom Rini <trini@kernel.crashing.org>, linux-kernel@vger.kernel.org
Subject: Re: test13-pre1 changelog
In-Reply-To: <E146zDX-0001ae-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10012151005330.2255-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 15 Dec 2000, Alan Cox wrote:
> > Sparc is already sync'ed in my tree, and I'd love for other architectures
> > to synch up too (but if it takes a while it's not a major disaster - I
> > actually much prefer bugs that cause build failures over other kinds of
> > bugs ;).
> 
> So you want drivers/gsc again ? I assumed you dropped it as you didnt want
> more port code.

I really dropped it because I was getting too many patches, and I don't
realistically think it's a 2.4.0 issue (neither do you, I bet), so I
decided that it's not worth it.

By "I'd love for other architectures to synch up" I really only meant the
Makefile issue - but the hppa thing is pretty much moot as not all of the
code has made it into the kernel yet, so even if the Makefiles were
updated it still wouldn't be "ready".

(Looking at the parisc makefiles the changes to update them to new-style
looks rather small. Not a big issue).

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
