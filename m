Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131425AbQKARAn>; Wed, 1 Nov 2000 12:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131536AbQKARAZ>; Wed, 1 Nov 2000 12:00:25 -0500
Received: from c90610-a.alton1.il.home.com ([24.11.42.157]:22035 "EHLO
	www.linuxnet") by vger.kernel.org with ESMTP id <S131425AbQKARAS>;
	Wed, 1 Nov 2000 12:00:18 -0500
Date: Wed, 1 Nov 2000 10:59:47 -0600 (CST)
From: matthew <matthew@mattshouse.com>
To: Jonathan George <Jonathan.George@trcinc.com>
cc: "'Rik van Riel'" <riel@conectiva.com.br>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: 2.4.0-test10 Sluggish After Load
In-Reply-To: <790BC7A85246D41195770000D11C56F21C847C@trc-tpaexc01.trcinc.com>
Message-ID: <Pine.LNX.4.21.0011011054150.7127-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>Rik van Riel said:
>> The problem may well be that Oracle wants to clean up
>> all memory at once, accessing much more memory than
>> it did while under stress with more tricky access
>> patterns.
>> <SNIP>
>> If this looks bad to you, compare the points where 2.2
>> starts thrashing and where 2.4 starts thrashing. You'll
>> most likely (there must be a few corner cases where 2.2
>> does better ;)) see that 2.4 still runs fine where 2.2
>> performance has already "degraded heavily" and that 2.2
>> has "hit the wall" before 2.4 does so ... the difference
>> just is that 2.4 hits the wall more suddenly ;)
>>
>Jonathan George said: 
> It sounded to me as if his machine never actually recovered from thrashing.
> Futhermore, even a thrashing case on a machine like that shouldn't last for
> more than about 10 minutes.  It would be interesting to contrast FreeBSD's
> behavior if "simple" cleanup was the problem.  BTW, I think that everyone is
> happy with the direction of the new VM.  I'm looking forward to your
> upcoming enhancements which I hope will make it in to a later 2.4 release.


The "thrashing" has been going on for roughly 10 hours now.  Is there a
point at which I can expect it to stop?  The load average is at 441 (down 
from > 700 last night), and the stress program was killed at 1:00AM CST
last night.  This (obviously) isn't an important machine so if you want me
to ride it out I will.

Matthew


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
