Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261176AbVDJBnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbVDJBnF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 21:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261191AbVDJBnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 21:43:05 -0400
Received: from w241.dkm.cz ([62.24.88.241]:44495 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261176AbVDJBnB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 21:43:01 -0400
Date: Sun, 10 Apr 2005 03:42:59 +0200
From: Petr Baudis <pasky@ucw.cz>
To: Phillip Lougher <phil.lougher@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>, ross@jose.lug.udel.edu,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Re: Re: Kernel SCM saga..
Message-ID: <20050410014259.GC9052@pasky.ji.cz>
Mail-Followup-To: Phillip Lougher <phil.lougher@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>, ross@jose.lug.udel.edu,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org> <20050408041341.GA8720@taniwha.stupidest.org> <Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org> <20050408071720.GA23128@jose.lug.udel.edu> <Pine.LNX.4.58.0504080758420.28951@ppc970.osdl.org> <20050409025357.GA9052@pasky.ji.cz> <cce9e37e05040918012ef0f7ab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cce9e37e05040918012ef0f7ab@mail.gmail.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Sun, Apr 10, 2005 at 03:01:12AM CEST, I got a letter
where Phillip Lougher <phil.lougher@gmail.com> told me that...
> On Apr 9, 2005 3:53 AM, Petr Baudis <pasky@ucw.cz> wrote:
> 
> >   FWIW, I made few small fixes (to prevent some trivial usage errors to
> > cause cache corruption) and added scripts gitcommit.sh, gitadd.sh and
> > gitlog.sh - heavily inspired by what already went through the mailing
> > list. Everything is available at http://pasky.or.cz/~pasky/dev/git/
> > (including .dircache, even though it isn't shown in the index), the
> > cumulative patch can be found below. The scripts aim to provide some
> > (obviously very interim) more high-level interface for git.
> 
> I did a bit of playing about with the changelog generate script,
> trying to produce a faster version.  The attached version uses a
> couple of improvements to be a lot faster (e.g. no recursion in the
> common case of one parent).
> 
> FWIW it is 7x faster than makechlog.sh (4.342 secs vs 34.129 secs) and
> 28x faster than gitlog.sh (4.342 secs vs 2 mins 4 secs) on my
> hardware.  You mileage may of course vary.

Wow, really impressive! Great work, I've merged it (if you don't object,
of course).

Wondering why I wasn't in the Cc list, BTW.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
98% of the time I am right. Why worry about the other 3%.
