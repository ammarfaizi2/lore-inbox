Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262417AbTCIEWC>; Sat, 8 Mar 2003 23:22:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262428AbTCIEWC>; Sat, 8 Mar 2003 23:22:02 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:50445 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262417AbTCIEV7>; Sat, 8 Mar 2003 23:21:59 -0500
Date: Sun, 9 Mar 2003 05:32:26 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Linus Torvalds <torvalds@transmeta.com>
cc: Zack Brown <zbrown@tumblerings.org>, Larry McVoy <lm@work.bitmover.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: BitBucket: GPL-ed KitBeeper clone
In-Reply-To: <Pine.LNX.4.44.0303081936400.27974-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0303090504140.32518-100000@serv>
References: <Pine.LNX.4.44.0303081936400.27974-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 8 Mar 2003, Linus Torvalds wrote:

> None of these are issues for broken systems like CVS or SVN, since they
> have a central repository, so there _cannot_ be multiple concurrent
> renames that have to be merged much later.

It is possible, you only have to remember that the file foo.c doesn't have 
to be called foo.c,v in the repository. SVN should be able to handle this, 
it's just lacking important merging mechanisms.
This is actually a key feature I want to see in a SCM system - the ability 
to keep multiple developments within the same repository. I want to pull 
other source tress into a branch and compare them with other branches and 
merge them into new branches.

> Sepoarate repostitories and SCCS file formats have nothing to do with the 
> real problem. Distribution is key, not the repository format.

I agree, what I was trying to say is that the SCCS format makes a few 
things more complex than they had to be.

bye, Roman

