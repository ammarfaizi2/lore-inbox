Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313551AbSDQLOt>; Wed, 17 Apr 2002 07:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313554AbSDQLOs>; Wed, 17 Apr 2002 07:14:48 -0400
Received: from [195.63.194.11] ([195.63.194.11]:28677 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313551AbSDQLOr>; Wed, 17 Apr 2002 07:14:47 -0400
Message-ID: <3CBD4A7C.9010807@evision-ventures.com>
Date: Wed, 17 Apr 2002 12:12:12 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Mark Mielke <mark@mark.mielke.cc>, Robert Love <rml@tech9.net>,
        davidm@hpl.hp.com, Davide Libenzi <davidel@xmailserver.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Why HZ on i386 is 100 ?
In-Reply-To: <Pine.LNX.4.33.0204162227530.15675-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Wed, 17 Apr 2002, Mark Mielke wrote:
> 
>>On Tue, Apr 16, 2002 at 08:57:09PM -0400, Robert Love wrote:
>>
>>>Because that is what Alpha does?  It seems to me there is no reason for
>>>a power-of-two timer value, and using 1024 vs 1000 just makes the math
>>>and rounding more difficult.
>>
>>Only from the perspective of time displayed to a user... :-)
> 
> 
> No, it also makes it much easier to convert to/from the standard UNIX time
> formats (ie "struct timeval" and "struct timespec") without any surprises,
> because a jiffy is exactly representable in both if you have a HZ value
> of 100 or 100, but not if your HZ is 1024.

And infally 100HZ is (by accident) quite right on the perceptive
threshold of a human, which is about 0.15 of a second :).

