Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130067AbRAEIat>; Fri, 5 Jan 2001 03:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130643AbRAEIaj>; Fri, 5 Jan 2001 03:30:39 -0500
Received: from ns1.megapath.net ([216.200.176.4]:37898 "EHLO megapathdsl.net")
	by vger.kernel.org with ESMTP id <S130067AbRAEIac>;
	Fri, 5 Jan 2001 03:30:32 -0500
Message-ID: <3A5585D1.5090903@megapathdsl.net>
Date: Fri, 05 Jan 2001 00:29:05 -0800
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-test12-pre8 i686; en-US; m18) Gecko/20001231
X-Accept-Language: en
MIME-Version: 1.0
To: "Michael D. Crawford" <crawford@goingware.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Change of policy for future 2.2 driver submissions
In-Reply-To: <3A55447D.995FB159@goingware.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael D. Crawford wrote:

<snip>


> You might think this is great because of all the extra testing the new users
> will do but I assert that it isn't.  The environment for Linux is quite
> different these days than when 2.2 or 2.0 were released.
> 
> A lot of the people who will be using it are not technically savvy people, and
> many of those who do know technology depend on its reliability for the
> profitability of large businesses but may not read Linus' message that indicates
> this is really just for testing.

Alan's comments were addressed to driver developers, not users.
It's driver developers who need to work with Alan to make sure
he doesn't have to now do twice as much work as he used to
(BTW:  I think this is a mental and physical impossibility).

The distros will ship 2.4.0 kernels whenever they want to, which
will probably be when they think there are no major gotchas in it.

If I remember correctly, when 2.2.0 was released, a similar process
took place.  Alan helped get patches into the 2.0 kernel tree for
a while.  When the 2.3.0 tree was opened up, Linus' attention
shifted completely to that new development tree.  That left Alan
to take up the slack by becoming the maintainer of the 2.2 tree.
Very shortly after Alan moved onto the 2.2 tree, he announced that
the vast amount of his work would be focussed there and not on the
2.0 tree.

As far as I know, 2.0 to 2.2 transition went really quite smoothly,
so this process must be working.

I would suggest that if you are writing drivers for the 2.2 tree,
that you just work with Alan and make sure your code is also in
the 2.4 tree.  Alan's doing you a favor by clearly spelling out
what he can reasonably be expected to accomplish.  If he over-
estimated his ability to process code changes, we'd all be in
a world of hurt and disappointment.

As for users, their fate is in the hands of the distribution
developers.  It's the distribution developers' responsibility
to ship good, solid code.  If you are scared that they won't
do a good job of that, I guess you'll want to wait for one
of their later releases.

Best wishes,

	Miles

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
