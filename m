Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262950AbUJ1XX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262950AbUJ1XX2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 19:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263086AbUJ1XXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 19:23:19 -0400
Received: from mo.optusnet.com.au ([203.10.68.101]:61920 "EHLO
	mo.optusnet.com.au") by vger.kernel.org with ESMTP id S262950AbUJ1XTx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 19:19:53 -0400
To: John Richard Moser <nigelenki@comcast.net>
Cc: michael@optusnet.com.au,
       "Marcos D. Marado Torres" <marado@student.dei.uc.pt>,
       Ed Tomlinson <edt@aei.ca>, Massimo Cetra <mcetra@navynet.it>,
       "'Chuck Ebbert'" <76306.1226@compuserve.com>,
       "'Bill Davidsen'" <davidsen@tmr.com>,
       "'William Lee Irwin III'" <wli@holomorphy.com>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: My thoughts on the "new development model"
References: <00c201c4bb4c$56d1b8b0$e60a0a0a@guendalin>
	<200410261719.56474.edt@aei.ca>
	<Pine.LNX.4.61.0410270402340.20284@student.dei.uc.pt>
	<417F315A.9060906@comcast.net> <m1sm7znxul.fsf@mo.optusnet.com.au>
	<41811AF2.2000503@comcast.net>
From: michael@optusnet.com.au
Date: 29 Oct 2004 09:19:05 +1000
In-Reply-To: <41811AF2.2000503@comcast.net>
Message-ID: <m1oeimo2hi.fsf@mo.optusnet.com.au>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Richard Moser <nigelenki@comcast.net> writes:
> michael@optusnet.com.au wrote:
[...]
> | There seems to be a lot of strange notions on this concept of 'stable'.
> | The only thing that makes a kernel 'stable' is time. Not endless
> | bugfixes. Just time. The idea of stable software is software that not
> | going to give you any suprises, software that you can trust.
> |
> 
> Right.  Bugfixing the "Stable" branch ONLY will make sure it does not
> surprise you with sudden new features (which may surprise you by. . .
> breaking your own patches!).

You've missed the point. 'Bugfixing' introduces code changes, and new
bugs. Having made 'bugfix', you now need to go back and re-do much,
if not all of your testing to ensure that you haven't introduced a brand
new bug. At a simple level, to 'bugfix' means to remove 1 known bug
and introduce a random number of unknown bugs. (Could be zero with reasonable
probability; could be 50 with low probabilty. The point is that you don't
know).

This isn't helping to reduce your 'suprise' rate.

[...] 
> | Now you've got a kernel that tests clean with your app. DON'T
> | CHANGE IT!!
> |
> | Ta-Dah! You've got a stable kernel.
> |
> 
> That if I keep my realtime patches or my security enhancements or my new
> drivers or my new filesystems on and don't continuously upgrade will
> cause me to stagnate and be left behind and ignored.

Ahh. Now I get it. You don't want a stable kernel at all. You
just want to pick and chose which new features you get.

In what way is 'security enchancements', or 'new drivers', or 'new
filesystems' not the very feature enchancements you're complaining
about in 2.6?

Michael.
