Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267910AbRGRQhH>; Wed, 18 Jul 2001 12:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267497AbRGRQg5>; Wed, 18 Jul 2001 12:36:57 -0400
Received: from arleno1.dsl.sirius.com ([207.44.242.45]:31245 "EHLO
	altair.dhs.org") by vger.kernel.org with ESMTP id <S267904AbRGRQgq>;
	Wed, 18 Jul 2001 12:36:46 -0400
Message-Id: <200107181636.JAA24824@altair.dhs.org>
Content-Type: text/plain; charset=US-ASCII
From: Charles Samuels <charles@kde.org>
Organization: K Desktop Environment
To: linux-kernel@vger.kernel.org
Subject: Re: LDP / KDP?
Date: Wed, 18 Jul 2001 09:36:48 -0700
X-Mailer: KMail [version 1.2.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well, upon reading the output produced from a make htmldoc in the kernel
source, I've been rather (read: very) discouraged.

I'm not sure there'd be much of a "market" for this, seeing as how much more
complete the inline-kerneldocs will be.

_still_, I like my format more, it seems like it'd be much easier to search,
and I think the format is much more ideal than docbook (which I have worked
with)

e.g., an example data file: http://derkarl.org/kerneldoc/data/init_timer.kd

And of course, I'm making no effort in preventing others from "syndicating"
these data files.  With which it should be simple enough to generate a
printed form, and other formats from.  In other words: it's a really easy
parse.

But the main problem is, it will be easier for the actual writers of the code
to maintain their docs inline, which will severely slow the acceptance of
this.  So, it's a choice between inline docs and this.  If there's any
approval of this ("officially"?), then I'de be open to discuss moving this to
something LDP-sanctioned, but of course, I wouldn't want to remove the
versatility that I have so far.

However, the main reason I didn't use docbook at first was _because_ I wanted
the versatility, and I didn't want something that behaved like a book.

e.g. 
 http://developer.kde.org/documentation/library/2.0-api/classref/kdecore/

This documentation _is_ inline to the code (in the headers), generated via a
perl script "kdoc".

On Wednesday 18 July 2001 08:50 am, you wrote:
> Charles Samuels (charles@kde.org) wrote:
> (I'm only quoting your whole message because I'm
> cc'ing it to discuss@linuxdoc.org.)
>
> Have you considered writing this as an LDP Guide?
>
> Advantages:
> * Harness the incredible power of a virtual army of
> LDP volunteers. (Well, a virtual platoon...)
> * The docs become print-ready as well.
> * DocBook is a standard! Yay standards!
> * Use the already-present distribution network the LDP
> has in place.
>
> Disadvantages:
> * Your formatting looks spiffier than the LDP
> stylesheets.
> * You'd have to rewrite what you have.
> * DocBook is not tailored to your purposes.
> * Multiple versions will exist throughout the world.
>
> I believe it's an alternative worth considering. I'd
> be willing to convert what you already have to
> DocBook.

-------------------------------------------------------
