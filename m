Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262024AbTCLVAF>; Wed, 12 Mar 2003 16:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261777AbTCLU7b>; Wed, 12 Mar 2003 15:59:31 -0500
Received: from modemcable166.48-200-24.mtl.mc.videotron.ca ([24.200.48.166]:31881
	"EHLO xanadu.home") by vger.kernel.org with ESMTP
	id <S262024AbTCLU5i>; Wed, 12 Mar 2003 15:57:38 -0500
Date: Wed, 12 Mar 2003 16:08:15 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: Larry McVoy <lm@bitmover.com>
cc: Sam Ravnborg <sam@ravnborg.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
In-Reply-To: <20030312205859.GG7275@work.bitmover.com>
Message-ID: <Pine.LNX.4.44.0303121605360.14172-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Mar 2003, Larry McVoy wrote:

> On Wed, Mar 12, 2003 at 03:46:58PM -0500, Nicolas Pitre wrote:
> > It seems that some things that should have been attributed to me (or others)
> > are listed as from torvalds too.
> > 
> > Example: drivers/char/tty_io.c
> > 
> > revision 1.59
> > date: 2003/03/04 02:13:05;  author: torvalds;  state: Exp;  lines: +4 -6
> > small tty irq race fix
> > 
> > (Logical change 1.8144)
> 
> Yeah, I'm almost there, I'm pretty sure that what is happening is that 
> the user name is being picked up from the changeset which is current in
> the path.  We extract the user name and put it in the comments but I 
> don't see where we set $LOGNAME before doing the ci.
> 
> So here's a question.  Suppose we have a series of deltas being clumped
> together in a file.  All made by different people.  Whose name wins?
> My gut is to sort them, run them through uniq -c, and take the top one.
> The other idea is to count up lines inserted/deleted over each delta
> and take the user who has done the most work.
> 
> Thoughts?

And/or add them all into the CVS log comment, with their full names when
available.

If such information can't be made into CVS directly then adding those to the 
log comment is certainly the best thing to do.


Nicolas

