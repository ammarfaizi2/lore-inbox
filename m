Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285327AbRL2TTJ>; Sat, 29 Dec 2001 14:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285316AbRL2TTA>; Sat, 29 Dec 2001 14:19:00 -0500
Received: from waste.org ([209.173.204.2]:39121 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S285269AbRL2TSw>;
	Sat, 29 Dec 2001 14:18:52 -0500
Date: Sat, 29 Dec 2001 13:18:46 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Christer Weinigel <wingel@hog.ctrl-c.liu.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: The direction linux is taking
In-Reply-To: <20011229190600.2556C36DE6@hog.ctrl-c.liu.se>
Message-ID: <Pine.LNX.4.43.0112291313160.18183-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Dec 2001, Christer Weinigel wrote:

> In article <Pine.LNX.4.43.0112291136350.18183-100000@waste.org> you write:
> >If my understanding of the new kbuild and configure system is correct,
> >make clean and dep should be largely unnecessary and it should be possible
> >to build a patchbot that checks for incremental compilability:
> >
> >for the current kernel release:
> >  unpack tree
> >  build the tree with default options (unprivileged user, obviously)
>
> One thing that should not be forgotten is the risk of trojan horses
> here, in practice the Makefile is a shell script, so to apply any
> patch and the compile with it would be a bit dangerous.  It might be
> possible to limit the patchbot to only accept code changes, but
> that might remove most of the benefits.  Also, I don't know how much
> magic one might do with a properly crafted #include statement, such
> as "#include /etc/passwd" and then the error message will contain
> the encypted password for root (shadow passwords fix this specific
> problem, but you get the idea :-)

I think we can devise a suitably secure jail environment, possibly using
UML.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

