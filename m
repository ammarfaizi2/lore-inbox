Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315709AbSEZEN3>; Sun, 26 May 2002 00:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315711AbSEZEN2>; Sun, 26 May 2002 00:13:28 -0400
Received: from bitmover.com ([192.132.92.2]:26069 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S315709AbSEZEN0>;
	Sun, 26 May 2002 00:13:26 -0400
Date: Sat, 25 May 2002 21:13:28 -0700
From: Larry McVoy <lm@bitmover.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Larry McVoy <lm@bitmover.com>, David Schleef <ds@schleef.org>,
        Karim Yaghmour <karim@opersys.com>, Wolfgang Denk <wd@denx.de>,
        linux-kernel@vger.kernel.org
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
Message-ID: <20020525211328.B20253@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Alexander Viro <viro@math.psu.edu>, Larry McVoy <lm@bitmover.com>,
	David Schleef <ds@schleef.org>, Karim Yaghmour <karim@opersys.com>,
	Wolfgang Denk <wd@denx.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20020525201749.A19792@work.bitmover.com> <Pine.GSO.4.21.0205252320550.15165-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 25, 2002 at 11:58:14PM -0400, Alexander Viro wrote:
> > Good luck making that stick in court.  First of all, the RTAI guys have
> > admitted over and over that RTAI is a fork of the RTLinux source base.
> > Your claims that that isn't true are countered by principles from both
> > parties in question.  Second of all, both source bases have evolved 
> > since the fork.  Whether your script catches the common heritage or 
> > not has no meaning, the fact remains that one is derived from the
> > other, and as such has to be GPLed.
> 
> Larry, can it.  4.4BSD was derived from v6->v7->32V - nobody had ever
> denied that.  So was USG "codebase"<spit>.  Didn't change the outcome
> of lawsuit.

That's because of 2 reasons:

    a) AT&T was apparently unfamilier with diff(1)
    b) Bill Jolitz choose to keep his mouth shut so that 4BSD would get
       freed up.  And got publicly humilated for it and still held his
       tongue.

Here's a clue: go diff bmap() in 4.x BSD and in 32V.  Word for word, bit
for bit, comment for comment, identical when I did it.  And I think anyone
can verify that, both versions of the code are out there now.  And I also
think that you, Al, would agree that bmap() is a pretty profound part of
the file system.  That AT&T let that one slip is mind boggling.

> If somebody chooses to use these "free for GPLed works" patents - fine,
> but at least have a decency to admit that it's a bit more complex than
> "if you want to make money on my work I want a part of it".

Huh?  You lost me.  For the record, I do think it's that simple.  And in
personal conversations with Victor, he's indicated that it is that simple.
What else do you think is there?  I'm missing some subtlety here, bang me
on the head with it.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
