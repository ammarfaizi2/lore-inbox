Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290784AbSBLF7F>; Tue, 12 Feb 2002 00:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290785AbSBLF6J>; Tue, 12 Feb 2002 00:58:09 -0500
Received: from THANK.THUNK.ORG ([216.175.175.163]:22954 "EHLO thunk.org")
	by vger.kernel.org with ESMTP id <S290784AbSBLF6B>;
	Tue, 12 Feb 2002 00:58:01 -0500
Date: Mon, 11 Feb 2002 22:59:35 -0500
From: Theodore Tso <tytso@mit.edu>
To: Tom Lord <lord@regexps.com>
Cc: lm@bitmover.com, jmacd@CS.Berkeley.EDU, jaharkes@cs.cmu.edu,
        linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
Message-ID: <20020211225935.B5514@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>, Tom Lord <lord@regexps.com>,
	lm@bitmover.com, jmacd@CS.Berkeley.EDU, jaharkes@cs.cmu.edu,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0202052328470.32146-100000@ash.penguinppc.org> <20020207165035.GA28384@ravel.coda.cs.cmu.edu> <200202072306.PAA08272@morrowfield.home> <20020207132558.D27932@work.bitmover.com> <20020211002057.A17539@helen.CS.Berkeley.EDU> <20020211070009.S28640@work.bitmover.com> <20020211141404.A21336@work.bitmover.com> <200202120517.VAA21821@morrowfield.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <200202120517.VAA21821@morrowfield.home>; from lord@regexps.com on Mon, Feb 11, 2002 at 09:17:43PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2002 at 09:17:43PM -0800, Tom Lord wrote:
> 
> It may be theoretically interesting to minimize the space taken up by
> revisions, but I think it is more economically sensible to screw that
> and and instead, maximize convenience and interactive speed with
> features like revision libraries (as in arch).  This ain't the early
> 90's any more.

For What It's Worth, on a laptop environment (where I work quite a
bit) and for something the size of the Linux kernel, and where things
change at the speed of the Linux kernel, in fact space efficiency
matters a lot.

In fact, the one thing for which I was quite unhappy with BK until
Larry implemented bk lclone (aka bk clone -l) was the amount of space
having multiple copies of the same repository took up, since BK really
requires multiple sandboxes for parallel development.  It's not a big
deal with something the size of e2fsprogs, but for something the size
of the BK linux tree, Size Really Matters.

						- Ted
