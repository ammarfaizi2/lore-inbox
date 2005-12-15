Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422637AbVLOJ03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422637AbVLOJ03 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 04:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422646AbVLOJZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 04:25:16 -0500
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:31078 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1422637AbVLOJYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 04:24:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=CZe+cCst19qRf4PsuxUtMg0xF2EcOWgW2Q/ydfds+gWd7EOCGC90krOvFAIgbd/xa0X2Fop9S8xUe3VQYIHZNlm6Z87drmJli1qb1qXQ17RfkqDqjD5ozrANhToN5fQEFmCcQWW/TdY0CxkjFBeI83Bq5DYRGSiZi03TLaCUABw=  ;
Message-ID: <43A13645.8020902@yahoo.com.au>
Date: Thu, 15 Dec 2005 20:24:21 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Al Boldi <a1426z@gawab.com>
CC: Arjan van de Ven <arjan@infradead.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux in a binary world... a doomsday scenario
References: <200512150013.29549.a1426z@gawab.com> <200512150749.29064.a1426z@gawab.com> <43A0FE13.8010303@yahoo.com.au> <200512151131.39216.a1426z@gawab.com>
In-Reply-To: <200512151131.39216.a1426z@gawab.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Boldi wrote:
> Nick Piggin wrote:
> 
>>Al Boldi wrote:
>>
>>>
>>>True.  But it would be time well spent.
>>
>>Who's time would be well spent?
>>
>>Not mine because I don't want a stable API. Not mine because I
>>don't use binary drivers and I don't care to encourage them.
>>[that is, unless you manage to convince me below ;)]
> 
> 
> The fact that somebody may take advantage of a stable API should not lead us 
> to reject the idea per se.
> 

Of course not, but the fact that they do nothing to help us means
that it doesn't carry a lot of weight (IMO, of course).

So: who's time well spent?

> 
>>Anyone else is free to fork the kernel and develop their own
>>stable API for it.
> 
> 
> That would be sad.
> 
> The objective of a stable API would be to aid the collective effort and not 
> to divide it.
> 

As Arjan said, this is how kernel development works. I was using it
to highlight the fact that nobody has done so yet, which gives some
indication that it is not time well spent.

>>>This is a common misconception.  What is true is that a closed system is
>>>forced to implement a stable api by nature.  In an OpenSource system you
>>>can just hack around, which may seem to speed your development cycle
>>>when in fact it inhibits it.
>>
>>How? I'm quite willing to listen, but throwing around words like 'guided
>>development' and 'scalability' doesn't do anything. How does the lack of a
>>stable API inhibit my kernel development work, exactly?
> 
> 
> If you are working alone a stable API would be overkill.  But GNU/Linux is a 
> collective effort, where stability is paramount to aid scalability.
> 
> I hope the concepts here are clear.
> 

No, they're not. I see no reason why your conjecture would be true and
you have failed to provide even any theories as to why it might be.
What's more, I'm not even clear what you mean by the scalability of a
development process. So, please elaborate -- this is not a rhetorical
question because I'm interested as to why you think this is the case, and
I have not had much experience with closed software development.

>>>GNU/OpenSource is unguided by nature.
>>
>>I've got a fairly good idea of what work I'm doing, and what I'm planning
>>to do, long term goals, projects, etc. What would be the key differences
>>with "non-GNU/OpenSource" development that would make you say they are not
>>unguided by nature?
> 
> 
> The same goes for OpenSource in general, but GNU/OpenSource has a larger 
> community and therefore is in greater need of a stable API.
> 

Yes, the same goes for OpenSource in general, fine. But what I'm asking
is: how is non-OpenSource different? What can we do better? How can we
learn from them?


>>Let's not bother with bad analogies and stick to facts. Do you know how
>>many people work on the Linux kernel? And how rapidly the source tree
>>changes? Estimates of how many bugs we have? Comparitive numbers from
>>projects with stable APIs? That would be very interesting.
> 
> 
> You got me here!  It's really common sense as in:
> stability breeds scalability, and instability breeds chaos.
> 

But you might not be far wrong in saying that Linux has one of the most
chaotic and scalable development processes in the world.

We have unstable APIs, but IMO we have a great and stable software.

> Arjan van de Ven wrote:
> 
>>I think Linux proves you wrong (and a bit of a troll to be honest ;)
> 
> 
> No troll! Just being IMHO. I hope that's OK?
> 

That's fine, but Linux and the development process is a personal
achievement and creation of many here, so you have to try to be
respectful :)

> Of course, if your aim is not to be scalable then please ignore this message 
> as it will not have any meaning.
> 

I think most believe what I do: that our development model is scalable
(scalability seems to be the least of its worries), and that unstable
APIs are not a bad thing.

Everybody is also open to try to improve, however "stability breeds
scalability, and instability breeds chaos" is simply not "common sense",
so please explain and justify it before going further.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
