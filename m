Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S160212AbQG1X6M>; Fri, 28 Jul 2000 19:58:12 -0400
Received: by vger.rutgers.edu id <S157671AbQG1X4D>; Fri, 28 Jul 2000 19:56:03 -0400
Received: from [168.143.241.209] ([168.143.241.209]:1478 "EHLO clubneon.com") by vger.rutgers.edu with ESMTP id <S157685AbQG1XyR>; Fri, 28 Jul 2000 19:54:17 -0400
Date: Fri, 28 Jul 2000 16:13:22 -0400 (EDT)
From: clubneon <clubneon@clubneon.com>
To: sl@fireplug.net
Cc: linux-kernel@vger.rutgers.edu
Subject: Re: RLIM_INFINITY inconsistency between archs
In-Reply-To: <8lss28$v2e$1@whiskey.fireplug.net>
Message-ID: <Pine.LNX.4.21.0007281602580.3697-100000@clubneon.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

On 28 Jul 2000, Stuart Lynne wrote:

> In article <Pine.LNX.4.21.0007280808460.73-100000@rc.priv.hereintown.net>,
> Chris Meadors <clubneon@hereintown.net> wrote:
> >
> >But the FHS also says you can't have things like /usr/apache.  But I find
> >that most useful, as deleting one directory removes all traces of the
> >program.  Large packages that would normally end up all over the place can
> >be contained (like X, which FHS does allow to have its own place under
> >/usr).
> 
> You can do that in /opt or /usr/local if you like. 

Just because so many (2 or 3) people have mentioned this to me I'll reply
to it shortly.

The problem I have with /opt is I'm not used to it yet.  I'd have to put
it on it's own partition just like /usr, /home, and /var.  I don't have
any feeling for how big /opt should be and I usually totally just forget
about it.

I'm building a new system now, I'm going to attempt to make use of /opt
for larger, self-contained packages.  BUT /opt is going to be a symlink to
/usr/local (take that FHS).  At least now I'll get a little more used to
using /opt.

Boy, I can't think of one thing to say that'll make this relevent to the
kernel.

Chris Meadors (at home)


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
