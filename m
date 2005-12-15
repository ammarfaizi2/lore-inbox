Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161126AbVLOFkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161126AbVLOFkA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 00:40:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161127AbVLOFj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 00:39:59 -0500
Received: from smtpout.mac.com ([17.250.248.47]:16085 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1161126AbVLOFj7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 00:39:59 -0500
In-Reply-To: <200512150749.29064.a1426z@gawab.com>
References: <200512150013.29549.a1426z@gawab.com> <1134595639.9442.14.camel@laptopd505.fenrus.org> <200512150749.29064.a1426z@gawab.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5CEFAB7F-8029-404E-91FD-18425AB2A970@mac.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Linux in a binary world... a doomsday scenario
Date: Thu, 15 Dec 2005 00:39:38 -0500
To: Al Boldi <a1426z@gawab.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 14, 2005, at 23:49, Al Boldi wrote:
> Arjan van de Ven wrote:
>> There is a price you pay for having such a rigid scheme (it  
>> arguably has advantages too, those are mostly relevant in a closed  
>> source system though) is that it's a lot harder to implement  
>> improvements.
>
> This is a common misconception.  What is true is that a closed  
> system is forced to implement a stable api by nature.  In an  
> OpenSource system you can just hack around, which may seem to speed  
> your development cycle when in fact it inhibits it.

This is _not_ the way Linux works.  We don't have a stable API  
_precisely_ so we don't have to "hack around" our API.  When the API  
is broken, we fix the API, therefore it doesn't get "hacked around"  
nearly as much as a so-called "Stable API" would be.  The development  
cycle is *accelerated* by the fact that an important API changes are  
_OK_.

>> Linux isn't so much designed as evolved, and in evolution, new  
>> dominant things emerge regularly. A stable API would prevent those  
>> from even coming into existing, let alone become dominant and  
>> implemented.
>
> GNU/OpenSource is unguided by nature.  A stable API contributes to  
> a guided development that is scalable.

Wrong again.  "Guided" implies that some overall authority controls  
everything that goes on, which is inherently unscalable.  Look at how  
inefficient all the governments are!  Look at how inefficient Linux  
kernel development was before BK and git!  When Linus had to deal  
with the thousands of patches individually, that was the development  
bottleneck.  As it is now, the merging work that Linus alone used to  
do is now divided up across a combination of Andrew Morton, Greg KH,  
and many valuable others (who can't all be listed without making this  
message overflow the mailing list limits).

Linux development scales _now_ better than any other software (open  
_OR_ closed) on the planet; recent patches from 2.6.X to 2.6.X+1-rc1  
are 25MB in size and constantly growing.  If you can come up with a  
development model that works as well and prove it in production, then  
good for you.  I don't expect, however, to see any closed-source  
project come close to the rate of production of Linux; even  
_Microsoft_ couldn't afford as many man-hours on a single codebase  
for long.

Cheers,
Kyle Moffett

--
Debugging is twice as hard as writing the code in the first place.   
Therefore, if you write the code as cleverly as possible, you are, by  
definition, not smart enough to debug it.
   -- Brian Kernighan


