Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266203AbSLSUQh>; Thu, 19 Dec 2002 15:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266210AbSLSUQh>; Thu, 19 Dec 2002 15:16:37 -0500
Received: from zeke.inet.com ([199.171.211.198]:12204 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id <S266203AbSLSUQd>;
	Thu, 19 Dec 2002 15:16:33 -0500
Message-ID: <3E022B01.2030205@inet.com>
Date: Thu, 19 Dec 2002 14:24:33 -0600
From: Eli Carter <eli.carter@inet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Bradford <john@grabjohn.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Dedicated kernel bug database
References: <200212192012.gBJKCGsV002580@darkstar.example.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford wrote:
> [CC list trimmed]
> 
> 
>>> > >It could warn the user if they attach an un-decoded oops that their
>>> > >bug report isn't as useful as it could be, and if they mention a
>>> > >distribution kernel version, that it's not a tree that the developers
>>> > >will necessarily be familiar with
>>> > Perhaps a more generalized hook into bugzilla for 'validating' a bug 
>>> > report, then code specific validators for kernel work?
>>>
>>>Its a nice idea, but I think it's a lot of effort to get it right,
>>>when a human can look at the dump, realise its not decoded, and
>>>send a request back in hardly any time at all.
>>>I also don't trust things like this where if something goes wrong,
>>>we could lose the bug report. People are also more likely to ping-pong
>>>,argue or "how do I..." with a human than they are with an automated robot.
>>
>>Either way, it isn't kernel specific.... which is what I was trying to 
>>address.  If it is valuable (which as you demonstrate is debatable,) 
>>then it is valuable in bugzilla baseline, not just kernel-bugzilla.
> 
> 
> What!?  Parsing an oops isn't kernel specific?

No, no, you mis-understand.  A bug report going through some sort of 
validation filter is applicable to any project.  A validation script 
that checks for a very close match to existing bugs for instance, and 
asks the submitter about it, would be widely applicable.

Parsing an oops would be a kernel-specific validation filter.

 >  Version tracking over
> multiple separate trees as diverse as 2.4 and 2.5 isn't pretty kernel
> specific? 

No, it isn't.  There are a lot of projects out there that use a 
'development' and 'stable' tree, and some that use more.  bugzilla 
itself does this.  Trolltech's Qt has several version branches.
We do have more development branches than most, but we are not unique.
My point is that this is functionality that makes sense for the base 
version of the bug tracking software, not just for the kernel version.

 > In any case, people could take the kernel bug database, and
> genericify it, much more easily than somebody could tailor an existing
> bug tracking application to the needs of the kernel, (which is
> demonstrated by the fact that the developers are not getting Bugzilla
> reports).

Perhaps, but I'm not convinced that it would be easier to write a kernel 
bug database from scratch than it would be to improve an existing 
project to address the kernel's needs.  And _that_ is what we were 
discussing.

Eli
--------------------. "If it ain't broke now,
Eli Carter           \                  it will be soon." -- crypto-gram
eli.carter(a)inet.com `-------------------------------------------------

