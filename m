Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315634AbSEZEFk>; Sun, 26 May 2002 00:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315693AbSEZEFj>; Sun, 26 May 2002 00:05:39 -0400
Received: from bitmover.com ([192.132.92.2]:21717 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S315634AbSEZEFi>;
	Sun, 26 May 2002 00:05:38 -0400
Date: Sat, 25 May 2002 21:05:38 -0700
From: Larry McVoy <lm@bitmover.com>
To: Wolfgang Denk <wd@denx.de>
Cc: Larry McVoy <lm@bitmover.com>, "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        rtai@rtai.org
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
Message-ID: <20020525210538.E19792@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Wolfgang Denk <wd@denx.de>, Larry McVoy <lm@bitmover.com>,
	"Albert D. Cahalan" <acahalan@cs.uml.edu>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, rtai@rtai.org
In-Reply-To: <20020525161034.L28795@work.bitmover.com> <20020525235442.CFB3511972@denx.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 26, 2002 at 01:54:37AM +0200, Wolfgang Denk wrote:
> > there is some GPL stuff in here, but we're releasing under the LGPL"
> 
> You can release some stuff onder one license,  other  stuff  under  a
> second  license,  and  yet other stuff onder a third license. Is that
> too difficult for you to understand?

That's all fine, but the RTAI COPYING file looks to me like a delibrate
attempt to mislead.  I'm pretty sure that a court of law would see it the
same way.  Add to that the the RTAI system is based in the RTL system,
which was obtained under the GPL, and that there are files which are
obviously derivative works with a LGPL license on them, and I think
you'd be squirming in front of judge with nowhere to run.

> Just for the record: you claimed  there  was  "substantial  parts  of
> RT/Linux  in  the  RTAI source"; when challenged to provide examples,
> you tried to evade several times; finally, you fell back to the  "but
> it's derived from RTL", which nobody ever denied.

No, I suggested you go look for yourself, just as I did.  It's called 
giving you a chance to back down gracefully.  You don't seem to want that
chance, OK, that's your call.  Let's explain the facts of life.  If you
start with a GPLed file and you enhance, bug fix, whatever, and the 
resulting work is what is known as a "derived work", it's still *all*
GPLed.  That's how the law works.  That was the whole point of how the
GPL was written, it was designed to not let people like you change the
rules without the permission of all the people who had copyrights on
that work.

I don't have to show entire files being identical to make the point,
all I have to show is that the files are derived from GPLed versions
of the same code.  Anyone with a brain would do what I did, go walk
the header files, find the common definitions, go look at the code that
implements those definitions, and know immediately it was derived work.
That's all it takes.  That's enough.  The law needs no more than that.

If you want to wiggle out from under the rules, you're going to need
what is known is a "clean room" reimplementation, wherein nobody who is
doing the work has ever seen the other code.  Otherwise it is virtually
impossible to avoid the derived work problem, and the burden is on you,
the person trying to change the rules, that it is not a derived work.
The court would presume, in a case like this, that it was.  You can 
try and push that back on me all you want, but I'm not the one you need
to convince.  You need to convince prospective customers that you have
clear rights to use what you are giving them, and in this case, that
looks virtually impossible.  I know about this stuff, I run a software
business, I personally negotiate the contracts, and no company with
any legal staff whatsoever would enter into contract with a vendor that
is not willing to state and prove that they have rights to what they
are selling.  That's contracts-101.

I get the feeling you want me to back down and go away.  Go Google around
and you'll find that I just don't, not until you prove that I'm wrong.
In this case, the more I dig into it, the more convinced I am that the
RTAI crowd is trying to rewrite history and that does nothing but make me
more motivated to stick around and make sure people look at this closely.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
