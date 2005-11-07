Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965426AbVKGReg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965426AbVKGReg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 12:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965318AbVKGR3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 12:29:19 -0500
Received: from smtp.osdl.org ([65.172.181.4]:64179 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965248AbVKGR3L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 12:29:11 -0500
Date: Mon, 7 Nov 2005 09:28:35 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Christopher Friesen <cfriesen@nortel.com>
cc: Krzysztof Halasa <khc@pm.waw.pl>, Eric Sandall <eric@sandall.us>,
       Willy Tarreau <willy@w.ods.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Tony Luck <tony.luck@gmail.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: New (now current development process)
In-Reply-To: <Pine.LNX.4.64.0511070915350.3193@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0511070922370.3193@g5.osdl.org>
References: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com>
 <12c511ca0510291157u5557b6b1x85a47311f0e16436@mail.gmail.com>
 <20051029195115.GD14039@flint.arm.linux.org.uk> <Pine.LNX.4.64.0510291314100.3348@g5.osdl.org>
 <20051031064109.GO22601@alpha.home.local> <Pine.LNX.4.63.0511062052590.24477@cerberus>
 <m3k6fkxwqe.fsf@defiant.localdomain> <436F8ABE.9020605@nortel.com>
 <Pine.LNX.4.64.0511070915350.3193@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 7 Nov 2005, Linus Torvalds wrote:
> 
> So repeat after me: "Most people never test -rc kernels". 

Btw, the ones that _do_ test -rc kernels usually don't test all of them. 
The current model is set up in a way where there is _one_ special -rc 
kernel that we should try to get people to test: the first one.

That hopefully encourages people to try an -rc kernel who might otherwise 
decide that there's too many -rc kernels to bother with. If they know that 
all of the real development happened before -rc1, they also are thus aware 
that it doesn't really matter which -rc kernel they test, so just testing 
_one_ is very good indeed.

The first -rc kernel is also special in another way: it's the one we 
"wait" for. It's the one that happens after two weeks, and has a deadline. 
The others happen more frequently, and are really objectively less 
important than the first one.

(In contrast, some other projects try to make the _last_ -rc be the 
important one. That's totally the wrong way around, because if there are 
more people testing the last one, the testing happens at _exactly_ the 
wrong point in time from a "let's fix the problems" standpoint)

So the call to people who can be bothered to test at all: if you 
only test one -rc kernel, please test the first one. That way we get a 
heads-up on problems earlier.

(And if you like testing -rc kernels, please test all of them. Or even the 
nightly snapshots. Or track the git tree several times a day. The more, 
the merrier, but if you only want to boot one kernel a month, make it be 
the -rc1 kernel).

			Linus
