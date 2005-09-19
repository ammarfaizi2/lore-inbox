Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932603AbVISTyZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932603AbVISTyZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 15:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932611AbVISTyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 15:54:25 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:46856 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S932603AbVISTyY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 15:54:24 -0400
Message-ID: <432F18DF.6020903@tmr.com>
Date: Mon, 19 Sep 2005 16:00:31 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Denis Vlasenko <vda@ilport.com.ua>
CC: Christoph Hellwig <hch@infradead.org>, Hans Reiser <reiser@namesys.com>,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
References: <432AFB44.9060707@namesys.com> <200509171415.50454.vda@ilport.com.ua> <200509180934.50789.chriswhite@gentoo.org> <200509181321.23211.vda@ilport.com.ua>
In-Reply-To: <200509181321.23211.vda@ilport.com.ua>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> On Sunday 18 September 2005 03:34, Chris White wrote:
> 
>>CC-List trimmed
>>
>>On Saturday 17 September 2005 20:15, Denis Vlasenko wrote:
>>
>>>>At least reiser4 is smaller. IIRC xfs is older than reiser4 and had more
>>>>time to optimize code size, but:
>>>>
>>>>reiser4        2557872 bytes
>>>>xfs            3306782 bytes
>>>
>>>And modules sizes:
>>>
>>>reiser4.ko        442012 bytes
>>>xfs.ko            494337 bytes
>>
>>All this is fine and dandy, but saying "My code is better than yours!!" still 
>>doesn't solve the issue this thread hopes to achieve, that being "I'd like to 
>>get reiser4 into the kernel".  There seems to be a lot of (historical?) 
>>tension present here, but all that seems to be doing is making things worse.  
>>PLEASE keep this thing a tad on par.  Keeping this up is hurting everyone 
>>more than helping.  I wish I could say something as simple as "let's just be 
>>friends", but that's saying a lot.  I can say this though: this is open 
>>source, and that means that our source is open, and we should be too.
> 
> 
> I am trying to say that I think that Hans is being treated a bit unfairly.
> His fs is new and has fairly complex on-disk structure and complex journalling
> machinery, yet his source and object code is smaller than xfs which already
> is accepted. This is no easy feat I guess.
> 
> Maybe xfs shouldn't be accepted too, this may be an answer.

That argument is specious, and raises the chance that someone will 
suggest that we learn from our mistakes.
> 
> Let's look at the code. Hans' code is not _that_ awful. Yet people
> (not all of them, but some) do not point to specific things which they
> want to be fixed/improved. I see blanket arguments like "your code is hard
> to read". Well. Maybe spend a minute on what exactly is hard to read,
> or do we require Hans to be able to read minds from the distance?

Was this code first written in some language which compiles into C, like 
the original C++ compiler? It just "feels funny," which clearly is not 
an objective or quantitative thing, just an impression. Your comment 
"not _that_ awful" is a perfect example of "damned by faint praise." 
However, unless someone is willing to make the argument that the code is 
too weird to maintain, style isn't an issue, is it?

Christoph has made some clear technical points, those should be 
addressed, whether you like the code style or not.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
