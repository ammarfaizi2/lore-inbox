Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129116AbQKBU7z>; Thu, 2 Nov 2000 15:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129179AbQKBU7q>; Thu, 2 Nov 2000 15:59:46 -0500
Received: from ra.lineo.com ([204.246.147.10]:60067 "EHLO thor.lineo.com")
	by vger.kernel.org with ESMTP id <S129116AbQKBU7k>;
	Thu, 2 Nov 2000 15:59:40 -0500
Message-ID: <3A01D463.9ADEF3AF@Rikers.org>
Date: Thu, 02 Nov 2000 13:53:55 -0700
From: Tim Riker <Tim@Rikers.org>
Organization: Riker Family (http://rikers.org/)
X-Accept-Language: en
MIME-Version: 1.0
To: "Theodore Y. Ts'o" <tytso@MIT.EDU>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: non-gcc linux? (was Re: Where did kgcc go in 2.4.0-test10?)
In-Reply-To: <200011022037.PAA21436@tsx-prime.MIT.EDU>
X-MIMETrack: Serialize by Router on thor/Lineo(Release 5.0.5 |September 22, 2000) at 11/02/2000
 01:59:36 PM,
	Serialize complete at 11/02/2000 01:59:36 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ok, a very valid point. The "C++ kernel code" reference is very telling.
(ouch). ;-)

Obviously the changes to support non-gcc compilers should have the goal
of minimal impact on gcc users lives. I recognize that the mainstream
will still use gcc.

Q: Why should we help you make it possible to use a proprietary C
compiler?

This is right on the money. I hope to show that is is all part of "World
Domination". ;-) I can easily see other paths to get there though, so
why this one?

As is being discussed here, C99 has some replacements to the gcc syntax
the kernel uses. I believe the C99 syntax will win in the near future,
and thus the gcc syntax will have to be removed at some point. In the
interim the kernel will either move towards supporting both, or a
quantum jump to support the new gcc3+ compiler only. I am hoping a
little thought can get put into this such that this change will be less
painful down the road.

I hope that I can lend some time to this project and save the rest of
the community time in the long run. Benefit our projects in the short
term. And impact the rest of the linux-kernel community as little as
possible in the short term.

How does that sound for a way forward?

"Theodore Y. Ts'o" wrote:
> 
>    Date:        Thu, 02 Nov 2000 12:31:51 -0700
>    From: Tim Riker <Tim@Rikers.org>
> 
>    Me or Alan? I did not mean this as a dig. I feel strongly that one
>    should have the choice here. I do not choose to enforce my beliefs on
>    anyone else. I am suggesting only that others should provide the same
>    courtesy. I truly meant "Thank you for you opinion". I feel the
>    community benefits from the differing opinions contained within it.
> 
> Yes, but that argument doesn't hold once you start asking the everyone
> to work on making that choice available.  The question that some part of
> the community may ask is --- why should we help you make it possible to
> use a propietary C compiler?
> 
> Choice also implies a choice not to work on things which help some
> particular person's pet cause, whether that is C++ kernel code, or
> propietary C compilers.  If it makes the code harder to maintain or more
> complex, it impacts everyone, and it's fair to ask the question whether
> or not the feeling "one should have the choice here" is worth the cost
> which you're asking everyone to bear.
> 
>                                         - Ted

-- 
Tim Riker - http://rikers.org/ - short SIGs! <g>
All I need to know I could have learned in Kindergarten
... if I'd just been paying attention.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
