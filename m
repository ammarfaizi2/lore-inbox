Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277028AbRJCXzu>; Wed, 3 Oct 2001 19:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277029AbRJCXzk>; Wed, 3 Oct 2001 19:55:40 -0400
Received: from femail25.sdc1.sfba.home.com ([24.254.60.15]:64927 "EHLO
	femail25.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S277028AbRJCXz2>; Wed, 3 Oct 2001 19:55:28 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
Organization: Boundaries Unlimited
To: Alexander Viro <viro@math.psu.edu>, Christoph Hellwig <hch@ns.caldera.de>
Subject: Whining about 2.5 (was Re: [PATCH] Re: bug? in using generic read/write functions to read/write block devices in 2.4.11-pre2)
Date: Wed, 3 Oct 2001 15:55:11 -0400
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <Pine.GSO.4.21.0110031841180.23558-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0110031841180.23558-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Message-Id: <01100315551100.00728@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 October 2001 18:51, Alexander Viro wrote:
> On Wed, 3 Oct 2001, Christoph Hellwig wrote:
> > How about starting 2.5 with that patch ones 2.4.11 is done?  Linus?
>
> I don't think that it's a good idea.  Such patch is trivial - it can be
> done at any point in 2.5.  Moreover, while it does clean some of the
> mess up, I don't see a lot of other stuff that would depend on it.

I think he's just trolling for anything that might bud off 2.5 at this point. 
 Can you blame him?  (Yes, al, you may flame me now. :)

Out of morbid curiosity, when 2.5 does finally fork off (a purely academic 
question, I know), which VM will it use?  I'm guessing Alan will still 
inherit the "stable" codebase, but the -ac and -linus trees are breaking new 
ground on divergence here.  Which tree becomes 2.4 once Alan inherits it?  
(Is this part of what's holding up 2.5?)

Are we waiting for andrea's shiny new VM to get into Alan's tree first?  I 
think Alan said something about somewhere freezing over, but don't quite 
recall.  Is someone else (Andrea?) likely to become 2.4 maintainer?

What exactly still needs to happen before 2.4 can be locked down, encased in 
lucite, and put into bugfix-only mode?  (Anybody who's tried to use 3D 
acceleration with Red Hat 7.1 and >= 2.4.9 is unlikely to be covinced that 
it's currently in bugfix-only mode.  The DRI part, anyway.)

On a technical level, 2.4.10's vm is working fine for me on my laptop.  (And 
I've seen "not working".  ANYTHING would have been an improvement over 
~2.4.5-2.4.7 or so.  I often went for a soda while it swapped trying to open 
its twentieth Konqueror window.  (Yeah, I know, bad habit I picked up years 
ago under OS/2...)  At least THAT problem is now history.  Then again I did 
buy 256 megabytes of ram for my laptop, so it might not have been the new 
kernel that fixed it. :)

What's else is left?  I'm curious.

Rob

(Oh, and what's the deal with "classzones"?  Linus told Andrea classzones 
were a dumb idea, and we'd regret it when we tried to inflict NUMA 
architecture on 2.5, but then went with Andrea's VM anyway, which I thought 
was based on classzones...  Was that ever resolved?  What the problem 
avoided?  What IS a classzone, anyway?  I'd be happy to RTFM, if anybody 
could tell me where TF the M is hiding...)

Gotta go, Star Trek: The Previous Generation is about to come on...
