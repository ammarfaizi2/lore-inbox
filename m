Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751362AbWIUSdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbWIUSdo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 14:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbWIUSdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 14:33:44 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:56737 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751362AbWIUSdo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 14:33:44 -0400
Message-ID: <4512DB05.2090604@garzik.org>
Date: Thu, 21 Sep 2006 14:33:41 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19 -mm merge plans
References: <20060920135438.d7dd362b.akpm@osdl.org> <45121382.1090403@garzik.org> <20060920220744.0427539d.akpm@osdl.org> <1158830206.11109.84.camel@localhost.localdomain> <Pine.LNX.4.64.0609210819170.4388@g5.osdl.org> <20060921105959.a55efb5f.akpm@osdl.org> <Pine.LNX.4.64.0609211106391.4388@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609211106391.4388@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> One of the things that I think the current model has excelled at is how it 
> really changed peoples behaviour, simply because they knew and understood 
> the rules.
> 
> I think the "big merges in the first two weeks, and a -rc1 after, and no 
> new code after that" rule has been working because it brought everybody in 
> on the same page. 


I definitely agree with all that.

I simply argue that, the more time that passes between releases, the 
MORE BUGS that appear in the next release.

After -rc1, you reach a point of diminishing returns where users don't 
re-test Release Candidates, developers move on to new code rather than 
fix bugs, and we all move into a limbo where 2.6.X-rcY doesn't see much 
activity, but the huge "merge snowball" in -mm builds and builds and builds.

As an aside, if a release is getting held up by some key bugs or 
regressions, I think it's more than fair for Andrew to loudly shame said 
developers into action.  "The following nincompoops are holding up the 
release:  Jeff Garzik [bug #1222, #3391], Greg KH [bug #9987, #4418], ..."

	Jeff


