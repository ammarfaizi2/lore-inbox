Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbTLBLeN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 06:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbTLBLeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 06:34:12 -0500
Received: from intra.cyclades.com ([64.186.161.6]:6057 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S261868AbTLBLeF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 06:34:05 -0500
Date: Tue, 2 Dec 2003 09:22:48 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Nathan Scott <nathans@sgi.com>
Cc: Larry McVoy <lm@work.bitmover.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       <linux-kernel@vger.kernel.org>, <linux-xfs@oss.sgi.com>
Subject: Re: XFS for 2.4
In-Reply-To: <20031202002347.GD621@frodo>
Message-ID: <Pine.LNX.4.44.0312020919410.13692-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 2 Dec 2003, Nathan Scott wrote:

> Hello Larry,
> 
> On Mon, Dec 01, 2003 at 02:20:25PM -0800, Larry McVoy wrote:
> > 
> > I have no idea if XFS should or should not go in, I'm not commenting on that.
> > 
> > However, having a bunch of XFS users say "put it in" when the maintainer
> > said no, DaveM said no, and no other file system people seem to be
> > stepping up to the bat with a review and a nod seems wrong.  
> 
> I must have missed that mail from Dave - or perhaps its still
> in flight to me.  If you're refering to his "super-maintainence
> mode" comment, I don't believe there was any specific comments
> relating to XFS there (and XFS on 2.4 is in maintenance mode,
> has been for a long time).
> 
> I also have mail from Marcelo saying he would look at merging XFS
> in 2.4.24-pre (back when we last sent it, in 2.4.23-pre) ... so,
> obviously I'm a little confused by this turn of events.

Nathan, 

Yes, I indeed told you "resent me for 2.4.24-pre". I have changed my mind. 

Sorry for the trouble that caused you.

> That level of discussion with other kernel coders, and extensive
> review _has_ happened, in many cases _years_ ago now - this stuff
> has all been merged in 2.5 for ages.  I wouldn't expect discussion
> from other filesystem people at this stage - it is all old news to
> them.
> 
> > ... the people who maintain those interfaces which
> > are generic should make that decision.  Don't you agree?
> 
> Of course, and they have agreed that these are the way the changes
> should be made - if you look at 2.6 you will see these changes all
> merged there, a long time ago.  As I said, there is nothing new or
> surprising here, and the changes are small and such that the other
> filesystems are unaffected.

A development tree is much different from a stable tree. You cant just
simply backport generic VFS changes just because everybody agreed with
them on the development tree.

My whole point is "2.6 is almost out of the door and its so much better".  
Its much faster, much cleaner. 


