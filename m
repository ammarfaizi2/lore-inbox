Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261438AbSIWXIs>; Mon, 23 Sep 2002 19:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261443AbSIWXIs>; Mon, 23 Sep 2002 19:08:48 -0400
Received: from netrealtor.ca ([216.209.85.42]:54790 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S261438AbSIWXIr>;
	Mon, 23 Sep 2002 19:08:47 -0400
Date: Mon, 23 Sep 2002 19:11:32 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Bill Huey <billh@gnuppy.monkey.org>
Cc: Peter W?chtler <pwaechtler@mac.com>, Ingo Molnar <mingo@elte.hu>,
       Larry McVoy <lm@bitmover.com>, Bill Davidsen <davidsen@tmr.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
Message-ID: <20020923191132.D26887@mark.mielke.cc>
References: <Pine.LNX.4.44.0209232233250.2343-100000@localhost.localdomain> <3D8F82E5.90A64E8@mac.com> <20020923184423.B26887@mark.mielke.cc> <20020923230122.GA3642@gnuppy.monkey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020923230122.GA3642@gnuppy.monkey.org>; from billh@gnuppy.monkey.org on Mon, Sep 23, 2002 at 04:01:22PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2002 at 04:01:22PM -0700, Bill Huey wrote:
> On Mon, Sep 23, 2002 at 06:44:23PM -0400, Mark Mielke wrote:
> > Certainly the above descriptions are not fully accurate, or complete,
> > and it is possible that the M:N threading would make a fair compromise
> > between OS thread sand user-space threads, however, if user-space threads
> > requires all this extra work, and M:N threads requires some extra work,
> > some less work, and extra book keeping and system calls, why couldn't
> > OS threads by themselves be more efficient?
> Crazy synchronization by non-web-server like applications. Who knows. I
> personally can't think up really clear example at this time since I don't
> do that kind of programming, but I'm sure concurrency experts can...
> I'm just not one of those people.

I do not find it to be profitable to discourage the people working on
this project. If they fail, nobody loses. If they succeed, they can
re-invent the math behind threading, and Linux ends up on the forefront
of operating systems offering the technology.

As for 'crazy synchronization', solutions such as the FUTEX have no
real negative aspects. It wasn't long ago that the FUTEX did not
exist. Why couldn't innovation make 'crazy synchronization by
non-web-server like applications' more efficient using kernel threads?

Concurrency experts would welcome the change. Concurrent 'experts'
would not welcome the change, as it would force them to have to
re-learn everything they know, effectively obsoleting their 'expert'
status. (note the difference between the unquoted, and the quoted...)

Cheers, and good luck...
mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

