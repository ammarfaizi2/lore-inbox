Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315711AbSETC3w>; Sun, 19 May 2002 22:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315717AbSETC3v>; Sun, 19 May 2002 22:29:51 -0400
Received: from sydney1.au.ibm.com ([202.135.142.193]:5637 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S315711AbSETC3t>; Sun, 19 May 2002 22:29:49 -0400
Date: Mon, 20 May 2002 12:32:27 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: torvalds@transmeta.com, davej@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] move jiffies from sched.h to it's own jiffies.h
Message-Id: <20020520123227.5318d357.rusty@rustcorp.com.au>
In-Reply-To: <Pine.LNX.4.33.0205181407370.21904-100000@gans.physik3.uni-rostock.de>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 May 2002 14:28:27 +0200 (CEST)
Tim Schmielau <tim@physik3.uni-rostock.de> wrote:

> On Sat, 18 May 2002, Dave Jones wrote:
> 
> > The 'dump everything into sched.h and friends' things really
> > needs splitting up some more, but it's a lot of work, and I don't
> > think kbuild2.5 alone is going to make that much difference
> > in this regard. Pulling out the component parts of the bigger
> > includes is probably the only way around this.
> > 
> > A driver that needs 'jiffies' defined should not be
> > inadvertantly pulling in a hundred include files.
> 
> Yep.
> As a start I made a patch that moves 'jiffies' from sched.h to their
> own header.

<plug>
Want to send them to trivial at rustcorp.com.au?
</plug>

Thanks,
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
