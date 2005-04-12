Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261996AbVDLBmK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261996AbVDLBmK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 21:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261999AbVDLBmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 21:42:10 -0400
Received: from w241.dkm.cz ([62.24.88.241]:30093 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261996AbVDLBmF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 21:42:05 -0400
Date: Tue, 12 Apr 2005 03:42:04 +0200
From: Petr Baudis <pasky@ucw.cz>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Re: Re: GIT license (Re: Re: Re: Re: Re: [ANNOUNCE] git-pasky-0.1)
Message-ID: <20050412014204.GB9145@pasky.ji.cz>
References: <200504120120.j3C1KII14991@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504120120.j3C1KII14991@adam.yggdrasil.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Tue, Apr 12, 2005 at 03:20:18AM CEST, I got a letter
where "Adam J. Richter" <adam@yggdrasil.com> told me that...
> >Dear diary, on Mon, Apr 11, 2005 at 05:46:38PM CEST, I got a letter
> >where "Adam J. Richter" <adam@yggdrasil.com> told me that...
> >..snip..
> >> Graydon Hoare.  (By the way, I would prefer that git just punt to
> >> user level programs for diff and merge when all of the versions
> >> involved are different or at least have a very thin interface
> >> for extending the facility, because I would like to do some character
> >> based merge stuff.)
> >..snip..
> 
> >But this is what git already does. I agree it could do it even better,
> >by checking environment variables for the appropriate tools (then you
> >could use that to pass diff e.g. -p etc.).
> 
> This message from Linus seemed to imply that git was going to get
> its own 3-way merge code:
> 
> | Then the bad news: the merge algorithm is going to suck. It's going to be
> | just plain 3-way merge, the same RCS/CVS thing you've seen before. With no
> | understanding of renames etc. I'll try to find the best parent to base the
> | merge off of, although early testers may have to tell the piece of crud
> | what the most recent common parent was.

Well, from what I can read it says "just plain 3-way merge, the same
RCS/CVS thing you've seen before". :-)

Basically, when you look at merge(1) :

SYNOPSIS
       merge [ options ] file1 file2 file3
DESCRIPTION
       merge  incorporates  all  changes that lead from file2 to file3
into file1.

The only big problem is how to guess the best file2 when you give it
file3 and file1.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
98% of the time I am right. Why worry about the other 3%.
