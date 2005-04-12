Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262112AbVDLUlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262112AbVDLUlF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 16:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262586AbVDLUlC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 16:41:02 -0400
Received: from w241.dkm.cz ([62.24.88.241]:39837 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262195AbVDLT30 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 15:29:26 -0400
Date: Tue, 12 Apr 2005 21:29:24 +0200
From: Petr Baudis <pasky@ucw.cz>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, torvalds@osdl.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Re: Re: Re: Re: GIT license (Re: Re: Re: Re: Re: [ANNOUNCE] git-pasky-0.1)
Message-ID: <20050412192924.GA26542@pasky.ji.cz>
References: <200504120120.j3C1KII14991@adam.yggdrasil.com> <20050412014204.GB9145@pasky.ji.cz> <Pine.LNX.4.62.0504121037590.10150@numbat.sonytel.be> <20050412095048.GB22614@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050412095048.GB22614@pasky.ji.cz>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Tue, Apr 12, 2005 at 11:50:48AM CEST, I got a letter
where Petr Baudis <pasky@ucw.cz> told me that...
> Dear diary, on Tue, Apr 12, 2005 at 10:39:40AM CEST, I got a letter
> where Geert Uytterhoeven <geert@linux-m68k.org> told me that...
> > On Tue, 12 Apr 2005, Petr Baudis wrote:
> ..snip..
> > > Basically, when you look at merge(1) :
> > > 
> > > SYNOPSIS
> > >        merge [ options ] file1 file2 file3
> > > DESCRIPTION
> > >        merge  incorporates  all  changes that lead from file2 to file3
> > > into file1.
> > > 
> > > The only big problem is how to guess the best file2 when you give it
> > > file3 and file1.
> > 
> > That's either the point just before you started modifying the file, or your
> > last merge point. Sounds simple, but if your SCM system doesn't track merges,
> > your SOL...
> 
> Well, yes, but the last merge point search may not be so simple:
> 
> A --1---2----6---7
> B    \   `-4-.  /
> C     `-3-----5'
> 
> Now, when at 7, your last merge point is not 1, but 2.

...and this is obviously wrong, sorry. You would lose 3 this way.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
98% of the time I am right. Why worry about the other 3%.
