Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932297AbVLSKxZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbVLSKxZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 05:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932724AbVLSKxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 05:53:24 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:21665 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S932297AbVLSKxY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 05:53:24 -0500
Message-ID: <43A6920A.2080409@aitel.hist.no>
Date: Mon, 19 Dec 2005 11:57:14 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Al Boldi <a1426z@gawab.com>
CC: Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux in a binary world... a doomsday scenario
References: <200512150013.29549.a1426z@gawab.com> <200512151131.39216.a1426z@gawab.com> <43A1501F.5070803@aitel.hist.no> <200512152129.01861.a1426z@gawab.com>
In-Reply-To: <200512152129.01861.a1426z@gawab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Boldi wrote:

>>Disadvantages of a stable API:
>>* It encourages binary-only drivers, while we prefer source drivers.
>>   Changing the API often and without warning is one way of
>>   hampering binary-only driver development without harming
>>   open-source drivers.
>>    
>>
>
>You are really shooting yourself in the foot here.
>  
>
Only if supporting binary-only drivers is somehow considered 
important/useful.
I don't believe so - so I don't shoot my foot here.  :-)

>>Do a stable API save us work?  No, because whoever changes the API
>>also fixes all in-kernel users of said API. 
>>    
>>
>
>That's very inefficient.
>  
>
Wrong.  It means that whoever want to change an API don't do so too lightly,
because there certainly is some work involved.  Even if it often only is
a big "grep" followed up by some trivial editing.  So, API change only
when there is a win offsetting this work. 

Such a process may seem inefficient if one were to schedule that work
among a limited workforce.  They had better not waste their time as that
block further options for profit. But only _companies_ work that way.
The kernel is different.  There are lots and lots of people, each working
on their favourite part. (Which is one reason why development scales so 
well.)

If someone does a time-consuming api change, then they aren't free to
do other work.  But if they don't do that api change - you can't schedule
other work for them anyway because they aren't employees.  They are
volunteers, their work don't cost any but it is also only for themselves
to decide what they work on. 

So the usual rules or common sense about work management
in a company do not apply.  Each patch is a gift you can't trade
for something else.

>>how is non-OpenSource different? What can we do better? How can we
>>learn from them?
>>    
>>
>
>Pretty much nothing, except for taking advantage of their precooked 
>interconnectivity api's, in which they excel in abstracting them pretty 
>well.
>
>  
>
[...]

>Don't mistake scalability for manageability/mantainability or flexibility.  
>  
>
Well, if we have manageability, maintainability and flexibility
then we are very well off, even if it doesn't fit your definition
of scalability.

>Scalability is more, much more.  It's about extendability and reusability 
>built on a solid foundation that may be stacked.  
>
Again: Code reuse is nice, or even necessary, with a limited and
expensive workforce.  It is not a concern with an unlimited free
workforce though.  If some volunteer makes an improvement by
doing a big rewrite - well, the job gets done and nobody have to
pay him.  This works.  And you can't
get they guy to do something you find more useful "instead".  Maintainers
can refuse patches of course - this usually cause people to work less
on linux rather than working more efficiently on linux.  So even
a "lot of work for only a little gain" type patch is taken, if it is
technically sound.  Because the time couldn't be better spent anyway,
so it wasn't wasted.

>Layers upon layers, the 
>sky is the limit.  Stability is the key to unlock this scalability.
>  
>
I consider too many stacked layers inefficient.  Keep it simple . . .

Helge Hafting
