Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131639AbRAERdT>; Fri, 5 Jan 2001 12:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132457AbRAERdJ>; Fri, 5 Jan 2001 12:33:09 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:36362 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132440AbRAERdC>; Fri, 5 Jan 2001 12:33:02 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Change of policy for future 2.2 driver submissions
Date: 5 Jan 2001 09:31:27 -0800
Organization: Transmeta Corporation
Message-ID: <9350df$2md$1@penguin.transmeta.com>
In-Reply-To: <3A55447D.995FB159@goingware.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3A55447D.995FB159@goingware.com>,
Michael D. Crawford <crawford@goingware.com> wrote:
>
>I understand Linus' desire to have more widespread testing done on the kernel,
>and certainly he can accomplish that by labeling some random build as the new
>stable version.  But I think a better choice would have been to advocate testing
>more widely - don't just announce it to the linux-kernel list, get on National
>Public Radio, the Linux Journal and Slashdot and stuff.  

You don't understand people, I think. 

No amount of publicity will matter all that much in the end: yes, it
will result in many people who are not afraid of a compiler to try it
out. And we've had that for over six months now, realistically.

But that's very different from having somebody like RedHat, SuSE or
Debian make such a kernel part of their standard package. No, I don't
expect that they'll switch over completely immediately: that would show
a lack of good judgement. The prudent approach has always been to have
both a 2.2.19 and a 2.4.0 kernel on there, and ask the user if he wants
to test the new kernel first.

That way you get a completely different kind of user that tests it.

The other thing is that even if something like 2.4.0-test8 gets rave
reviews, that doesn't _matter_ to people who crave stability. The fact
is that 2.4.0 has been getting quite a lot of testing: people haven't
even seen how the big vendors have all done testing in their labs etc.

And to the people who really want to have stability, none of that
matters.  They will basically "start fresh" at the 2.4.0 release, and
give it a few months just to follow the kernel list etc to see what the
problems will be.  They'll have people starting to ramp up 2.4.0 kernels
in their own internal test environment, moving it first to machines they
feel more comfortable with etc etc. 

None of which would happen if you just try to make the beta testing
cycle much bigger. 

Which is why to _me_ the most important thing is that I'm happy with the
core infrastructure - because once you've tested it to a certain degree,
it's not going to improve without a real public release.

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
