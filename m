Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262522AbTCIPYk>; Sun, 9 Mar 2003 10:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262521AbTCIPYk>; Sun, 9 Mar 2003 10:24:40 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:57105 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262522AbTCIPYj>; Sun, 9 Mar 2003 10:24:39 -0500
Date: Sun, 9 Mar 2003 16:35:11 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Zack Brown <zbrown@tumblerings.org>, Larry McVoy <lm@work.bitmover.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: BitBucket: GPL-ed KitBeeper clone
In-Reply-To: <m14r6ck6jd.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.44.0303091609440.5042-100000@serv>
References: <Pine.LNX.4.44.0303081936400.27974-100000@home.transmeta.com>
 <Pine.LNX.4.44.0303090504140.32518-100000@serv> <m14r6ck6jd.fsf@frodo.biederman.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9 Mar 2003, Eric W. Biederman wrote:

> > This is actually a key feature I want to see in a SCM system - the ability 
> > to keep multiple developments within the same repository. I want to pull 
> > other source tress into a branch and compare them with other branches and 
> > merge them into new branches.
> 
> In a distributed system everything happens on a branch.

That's true, but with bk you have to use separate directories for that, 
which makes cross references between branches more difficult.

> > I agree, what I was trying to say is that the SCCS format makes a few 
> > things more complex than they had to be.
> 
> I don't know, if the problem really changes that much.  How do
> you pick a globally unique inode number for a file?  And then
> how do you reconcile this when people on 2 different branches create
> the same file and want to merge their versions together?

Unique identifier are needed for change sets anyway and if you decide 
during merge, that two files are identical, at least one branch has to 
carry the information that these identifiers point to the same file.

> So as a very rough approximation.
> - Distribution is the problem.

I would rather say, that it's only one (although very important) problem.

bye, Roman

