Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262500AbRE0WJO>; Sun, 27 May 2001 18:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262498AbRE0WJE>; Sun, 27 May 2001 18:09:04 -0400
Received: from ncc1701.cistron.net ([195.64.68.38]:28688 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S262489AbRE0WI5>; Sun, 27 May 2001 18:08:57 -0400
From: miquels@cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: IDE Performance lack !
Date: Sun, 27 May 2001 22:08:55 +0000 (UTC)
Organization: Cistron Internet Services B.V.
Message-ID: <9erttn$cak$1@ncc1701.cistron.net>
In-Reply-To: <01052622193100.01317@linux.zuhause.de> <00a101c0e642$4f0791a0$52a6b3d0@Toshiba> <20010527224045.B3556@metastasis.f00f.org> <00c701c0e6d8$2b28ea40$4aa6b3d0@Toshiba>
X-Trace: ncc1701.cistron.net 991001335 12628 195.64.65.67 (27 May 2001 22:08:55 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test75 (Feb 13, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <00c701c0e6d8$2b28ea40$4aa6b3d0@Toshiba>,
Jaswinder Singh <jaswinder.singh@3disystems.com> wrote:
>I am not able to understand why Linux read and/or write harddisk after some
>time (after few hours ) , harddisk read/write leds keep on glowing for few
>minutes , even though nobody working on it and machine is in idle state.

Are you sure it is idle. It might be running something from cron-
say 'updatedb' or similar. That will cause a lot of disk i/o,
and _ofcourse_ performance will be bad then - the machine is
doing a lot of other things.

It might also be that you don't have enough memory and the
machine is swapping itself to death. Running netscape or
mozilla perhaps? These are known to blow themselves up to
50-100 MB (!). That will cause the exact symptoms you're seeing.

>>Have you tried 2.2.x ?
>>
>
>yes i am taking about 2.2.12 .

2.2.12 is old. In my experience, 2.2.19 is the first really
good 2.2 kernel. Especially in low-memory situations like
you might be experiencing..

>And in my 2.4.2 :-

2.4.2 isn't all that good either.. 2.4.x doesn't have VM sorted
out just yet

>and when my machine becomes normal i got :-
>9.07 MB/sec

Sounds about right for a non-UDMA disk.

>But my problem is why linux boxes do not response for few seconds
>(sometimes) and especially during telnet/ssh it looks more worst and looks
>similar to Microsoft Windows :(
>there is problem in scheduling or what ?

Try 2.2.19

Mike.

