Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbVEFOSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbVEFOSu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 10:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261235AbVEFOQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 10:16:29 -0400
Received: from [85.8.12.41] ([85.8.12.41]:40613 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S261229AbVEFOPc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 10:15:32 -0400
Message-ID: <427B7BEA.5050808@drzeus.cx>
Date: Fri, 06 May 2005 16:15:06 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linus Torvalds <torvalds@osdl.org>, Ian Molton <spyro@f2s.com>,
       Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [PATCH][MMC] Secure Digital (SD) support
References: <422701A0.8030408@drzeus.cx> <20050305113730.B26541@flint.arm.linux.org.uk> <4229A4B4.1000208@drzeus.cx> <20050305124420.A342@flint.arm.linux.org.uk> <4229B847.5050301@drzeus.cx>
In-Reply-To: <4229B847.5050301@drzeus.cx>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Ossman wrote:
> Russell King wrote:
> 
>> We'll also need to run this by Linus first, explaining why you believe
>> it's now ok to merge this.  (Added Linus...)
>>
> 
> It was also pointed out in the previous thread by myself, Alan Cox and
> Ian Molton that SD specs have been publically available from different
> companies for quite some time. As such it is difficult for anyone to
> claim that these are secret and can be regulated by a NDA. The only part
> that hasn't been found in the wild is the spec for the 'secure' parts of
> the cards. But that also means that it isn't included in this patch so
> it shouldn't pose a problem.
> 

This issue doesn't seem to reach any kind of resolution so I figured I'd
take a poke at the people responsible. :)

Just to back up the claim that the specs are in the open here are some
links:

http://www.google.com/search?hl=en&q=%22Secure+Digital+Card%22+%22Product+Manual%22+site%3Asandisk.com&btnG=Google+Search

Which gives you several PDF:s with enough information to implement a SD
host. The one I've been using is:

http://www.sandisk.com/download/Product%20Manuals/Product%20ManualSDCardv1.7.pdf


Rgds
Pierre
