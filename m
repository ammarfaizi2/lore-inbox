Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269996AbRHQJEv>; Fri, 17 Aug 2001 05:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270001AbRHQJEl>; Fri, 17 Aug 2001 05:04:41 -0400
Received: from 64-42-29-14.atgi.net ([64.42.29.14]:51204 "HELO
	mail.clouddancer.com") by vger.kernel.org with SMTP
	id <S269996AbRHQJE0>; Fri, 17 Aug 2001 05:04:26 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: "VM watchdog"? [was Re: VM nuisance]
In-Reply-To: <9li6sf$h5$1@ns1.clouddancer.com>
In-Reply-To: <3B748AA8.4010105@blue-labs.org>    <20010814140011.B38@toy.ucw.cz> <20010817002420.C30521@unthought.net> <3B7C72CE.60601@blue-labs.org> <9li6sf$h5$1@ns1.clouddancer.com>
Reply-To: klink@clouddancer.com
Message-Id: <20010817090440.4A63B783F6@mail.clouddancer.com>
Date: Fri, 17 Aug 2001 02:04:40 -0700 (PDT)
From: klink@clouddancer.com (Colonel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In clouddancer.list.kernel, David wrote:

>>Didn't everyone pretty much agree that if we could turn off overcommit
>>completely and reliably, that would be the preferred solution ?   Simply sig11
>>the app that's unlucky enough to want more memory than there's in the system
>>(or, horror, have malloc() fail)
>>
>>Now, I don't remember the entire thread, but IIRC it was difficult to kill
>>overcommit completely.
>>
>
>The kernel allocates memory within itself.  We will still reach OOM 
>conditions.  It can't be avoided.

That doesn't sound good.

What bugs me about this statement was that until 2.4, I never had
lockups.  I sometimes had a LOT of swapping and slow response, but I
also knew that running a complex numeric simulation when RAM <
'program needs' does that.  I accepted it and tended to arrange such
runs in my absence.  Now I find that I get some process nuked (or
worse - partially nuked) even after increasing to 4x swap and
eliminating lazy habits that would leave some idle process up for a
few days in case I needed it again (worked fine in 2.0.36).  There are
_alot_ of good things in 2.4, but sometimes....


Does your statement imply that a machine left "alone" must eventually
OOM given enough runtime??  It seems that it must.


-- 
2.4 VM: "I'm sorry Dave ...  I'm afraid I can't do that."

