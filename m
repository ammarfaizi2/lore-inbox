Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271609AbRHUIvD>; Tue, 21 Aug 2001 04:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271617AbRHUIuy>; Tue, 21 Aug 2001 04:50:54 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:9959 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S271609AbRHUIuk>;
	Tue, 21 Aug 2001 04:50:40 -0400
Date: Tue, 21 Aug 2001 09:50:52 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: David Schwartz <davids@webmaster.com>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: RE: Entropy from net devices - keyboard & IDE just as 'bad' [was
 Re: [PATCH] let Net Devices feed Entropy, updated (1/2)]
Message-ID: <606175155.998387452@[169.254.45.213]>
In-Reply-To: <NOEJJDACGOHCKNCOGFOMCEDNDFAA.davids@webmaster.com>
In-Reply-To: <NOEJJDACGOHCKNCOGFOMCEDNDFAA.davids@webmaster.com>
X-Mailer: Mulberry/2.1.0b3 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David,
> Alex Bligh wrote:
>
>> Many non-i386 platforms have more finely grained timers than 1 jiffie.
>> The problem is the code doesn't use them. So my point is, it seems
>> illogical to throw stones at (often) theoretical issues with Robert's
>> patch, when people's energy would be better diverted to help fix up
>> hole in the current implementation.
>
> 	I don't understand the connection. Either Robert's patch is good or it's
> bad. If there are other problems, then we can address those too. But to
> say that Robert's patch is bad because it doesn't fix the most important
> problem that you can think of doesn't make any sense. Every problem
> should be fixed, and if Robert has a patch to fix one of them, then
> that's one less.
>
> 	You can certainly advise people to work on the most serious problems. But
> you most certainly can't say that someone shouldn't work on X because Y is
> more important.

For clarity, I'm saying Robert's patch is GOOD, and those who are trying
to point out what I consider to be extremely theoretical weakness it
introduces into /dev/random (and then, only when config'd on), should
instead spend their attention looking at miuch more serious issues
in the algorithm elsewhere if they are that worried, rather than
attacking something which is useful.

To make an analogy, Robert is suggesting changing the 9 cylinder
lock on the back door of a house to a 7 cylinder lock, which is much
easier to operate, but perhaps slightly less secure. (well,
to be precise, he's advocating giving the house own the
OPTION to do this). However, the front door is wide open, swinging
in the wind, with no lock on at all. And people are worried about
Robert's patch. Doesn't make much sense...

--
Alex Bligh
