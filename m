Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964885AbWIVUWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964885AbWIVUWz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 16:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964891AbWIVUWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 16:22:55 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:1485 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964885AbWIVUWz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 16:22:55 -0400
Message-ID: <45144613.2080306@garzik.org>
Date: Fri, 22 Sep 2006 16:22:43 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Roland Dreier <rdreier@cisco.com>
CC: Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       David Miller <davem@davemloft.net>, davidsen@tmr.com,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19 -mm merge plans
References: <Pine.LNX.4.64.0609211106391.4388@g5.osdl.org>	<45130533.2010209@tmr.com> <45130527.1000302@garzik.org>	<20060921.145208.26283973.davem@davemloft.net>	<20060921220539.GL26683@redhat.com>	<20060922083542.GA4246@flint.arm.linux.org.uk>	<20060922154816.GA15032@redhat.com>	<Pine.LNX.4.64.0609220901040.4388@g5.osdl.org> <aday7sbfyuy.fsf@cisco.com>
In-Reply-To: <aday7sbfyuy.fsf@cisco.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
> My way of handling this has been to wait until you've acted on my
> first merge request before sending another one.  I also don't touch my
> published "for-linus" branch in git until you've pulled it.  I just
> batch up pending changes in my "for-2.6.19" branch until my next merge
> (and I also encourage people interested in Infiniband to run my
> for-2.6.19 branch)


That's pretty much what I do.  I run a
	git branch upstream-linus upstream

and then submit a pull request for the upstream-linus branch.  That way, 
I can keep working and committing stuff, and don't have to wait for 
Linus to pull.

Then, after the pull, I delete the branch
	git branch -D upstream-linus

locally, and repeat the process next time a bunch of changes are queued up.

	Jeff


