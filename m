Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282368AbRKXGUT>; Sat, 24 Nov 2001 01:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282369AbRKXGUJ>; Sat, 24 Nov 2001 01:20:09 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:39176 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S282368AbRKXGUC>; Sat, 24 Nov 2001 01:20:02 -0500
Message-ID: <3BFF3BE5.EECBB5D0@zip.com.au>
Date: Fri, 23 Nov 2001 22:19:17 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Petrusevich <casus@mail.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: threads & /proc
In-Reply-To: <20011123233857.A25084@casus.tx>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Petrusevich wrote:
> 
> Hi Guys,
> 
> Well, I'm a bit surprised that nobody asked it yet. Do we have sound
> thread support? I am able to put my linux-2.4.15-pre{1,7} --
> definitely, and if I remember right, 2.4.14-pre{7,8} too in some strange
> state, when any program like top, killall or ps that wanna get some
> information from /proc (even midnight commander if you are trying to
> look at state of any process) blocks indefinitely. It goes to unclean
> shutdown, for example. kill doesn block, but do nothing. (I tried to
> kill processes from ls /proc list). And I see it only after several
> [unsuccessful] runs of my multithreaded program. Well, I can't say
> it's a correctly written program, I am still looking for bugs there.
> I don't have 100% way to get into this state, but I suspect some locking
> issues with /proc.

I've seen this once, on a semi-production machine which, unfortunately,
wasn't set up for diagnostic work.  Uniprocessor.

If you can send out some code which demonstrates the bug then
that will be invaluable - it will be fixed quickly.

-
