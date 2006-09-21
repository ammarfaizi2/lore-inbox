Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751432AbWIUSUI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbWIUSUI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 14:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWIUSUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 14:20:07 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:24737 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751432AbWIUSUG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 14:20:06 -0400
Message-ID: <4512D7D0.8030501@garzik.org>
Date: Thu, 21 Sep 2006 14:20:00 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linus Torvalds <torvalds@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.19 -mm merge plans
References: <20060920135438.d7dd362b.akpm@osdl.org>	<45121382.1090403@garzik.org>	<20060920220744.0427539d.akpm@osdl.org>	<1158830206.11109.84.camel@localhost.localdomain>	<Pine.LNX.4.64.0609210819170.4388@g5.osdl.org> <20060921105959.a55efb5f.akpm@osdl.org>
In-Reply-To: <20060921105959.a55efb5f.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Jeff: "I want faster release cycles because <no reason given>"

All the standard goodness that "release early, release often" provides.

* Avoiding the achingly long wait where huge amounts of changes pile up, 
then go in.  It should be OBVIOUS that
	merge 10,000 changes.  global test.  repeat
is worse than
	merge 1,000 changes.  global test.  repeat.

I think it's patently unfair to complain about bugs and regressions, 
then limit developers to 3-4 test points [mainline releases] per year.

* Faster release cycles means code doesn't spend a quarter of the year 
in limbo before users test it and give good feedback.

* Code stands a better chance of getting more review.

* Regressions are perceived to be fixed more quickly, if the fix 
requires more than just 1-2 lines going to stable@kernel.org.

* Submitters don't have to wait for a quarter of a year in order for 
their submissions to hit a mainline release.

With this last release, I just didn't see the value at all to going all 
the way to -rc7.  There weren't huge numbers of testers screaming about 
-rc1 and -rc2.  It just seemed like we delayed for no good reason other 
than a blind hope that the passage of time would fix bugs.

	Jeff


