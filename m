Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161117AbVLOFYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161117AbVLOFYt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 00:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161115AbVLOFYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 00:24:49 -0500
Received: from smtp014.mail.yahoo.com ([216.136.173.58]:36988 "HELO
	smtp014.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1161117AbVLOFYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 00:24:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=BcfHt1y+dXLr5DJcjO8jPwEq1//CeLeGF0aMqqHTrpnH9TIbPcCShqKrP/YFUw0yWCjWLDjil7isgVxM9y61MNmYcWfVXJtsZSKjxrkAClJ7aYaojM3Sen2Bk1jFb1mXnBSofxMK1o/oDVcpgDfuror+5gcWiqOg997m/dRnk30=  ;
Message-ID: <43A0FE13.8010303@yahoo.com.au>
Date: Thu, 15 Dec 2005 16:24:35 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Al Boldi <a1426z@gawab.com>
CC: Arjan van de Ven <arjan@infradead.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux in a binary world... a doomsday scenario
References: <200512150013.29549.a1426z@gawab.com> <1134595639.9442.14.camel@laptopd505.fenrus.org> <200512150749.29064.a1426z@gawab.com>
In-Reply-To: <200512150749.29064.a1426z@gawab.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Boldi wrote:
> Arjan van de Ven wrote:
> 
>>
>>a stable api/abi for the linux kernel would take at least 2 years to
>>develop. The current API is not designed for stable-ness, a stable API
>>needs stricter separation between the layers and more opaque pointers
>>etc etc.
> 
> 
> True.  But it would be time well spent.
> 

Who's time would be well spent?

Not mine because I don't want a stable API. Not mine because I
don't use binary drivers and I don't care to encourage them.
[that is, unless you manage to convince me below ;)]

Anyone else is free to fork the kernel and develop their own
stable API for it. I don't think I would go so far as to call
that time well spent, however.

> 
>>There is a price you pay for having such a rigid scheme (it arguably has
>>advantages too, those are mostly relevant in a closed source system tho)
>>is that it's a lot harder to implement improvements.
> 
> 
> This is a common misconception.  What is true is that a closed system is 
> forced to implement a stable api by nature.  In an OpenSource system you can 
> just hack around, which may seem to speed your development cycle when in 
> fact it inhibits it.
> 

How? I'm quite willing to listen, but throwing around words like 'guided
development' and 'scalability' doesn't do anything. How does the lack of a
stable API inhibit my kernel development work, exactly?

> 
>>Linux isn't so much designed as evolved, and in evolution, new dominant
>>things emerge regularly. A stable API would prevent those from even coming
>>into existing, let alone become dominant and implemented.
> 
> 
> GNU/OpenSource is unguided by nature.

I've got a fairly good idea of what work I'm doing, and what I'm planning
to do, long term goals, projects, etc. What would be the key differences
with "non-GNU/OpenSource" development that would make you say they are not
unguided by nature?

>  A stable API contributes to a guided 
> development that is scalable.  Scalability is what leads you to new heights, 
> or else could you imagine how ugly it would be to send this message using 
> asm?
> 

Let's not bother with bad analogies and stick to facts. Do you know how
many people work on the Linux kernel? And how rapidly the source tree
changes? Estimates of how many bugs we have? Comparitive numbers from
projects with stable APIs? That would be very interesting.

Thanks,
Nick

Send instant messages to your online friends http://au.messenger.yahoo.com 
