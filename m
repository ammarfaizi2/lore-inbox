Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314067AbSDQFYV>; Wed, 17 Apr 2002 01:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314068AbSDQFYU>; Wed, 17 Apr 2002 01:24:20 -0400
Received: from mark.mielke.cc ([216.209.85.42]:18445 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S314067AbSDQFYU>;
	Wed, 17 Apr 2002 01:24:20 -0400
Date: Wed, 17 Apr 2002 01:18:42 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Robert Love <rml@tech9.net>
Cc: davidm@hpl.hp.com, Davide Libenzi <davidel@xmailserver.org>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Why HZ on i386 is 100 ?
Message-ID: <20020417011842.A12455@mark.mielke.cc>
In-Reply-To: <15548.22093.57788.557129@napali.hpl.hp.com> <Pine.LNX.4.44.0204161013050.1460-100000@blue1.dev.mcafeelabs.com> <15548.50859.169392.857907@napali.hpl.hp.com> <1019005044.1670.16.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2002 at 08:57:09PM -0400, Robert Love wrote:
> On Tue, 2002-04-16 at 20:49, David Mosberger wrote:
> > But since it's popular, I did measure it quickly on a relatively
> > slow (old) Itanium box: with 100Hz, the kernel compile was about
> > 0.6% faster than with 1024Hz (2.4.18 UP kernel).
> One question I have always had is why 1024 and not 1000 ?
> 
> Because that is what Alpha does?  It seems to me there is no reason for
> a power-of-two timer value, and using 1024 vs 1000 just makes the math
> and rounding more difficult.

Only from the perspective of time displayed to a user... :-)

Of course, that may be one of the only factors...

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

