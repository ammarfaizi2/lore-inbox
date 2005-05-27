Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262598AbVE0VNp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbVE0VNp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 17:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262596AbVE0VNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 17:13:45 -0400
Received: from mail.dif.dk ([193.138.115.101]:37338 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S262595AbVE0VNi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 17:13:38 -0400
Date: Fri, 27 May 2005 23:18:12 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, perex@suse.cz,
       linux-kernel@vger.kernel.org, git@vger.kernel.org
Subject: Re: ALSA official git repository
In-Reply-To: <20050527135124.0d98c33e.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0505272313450.2400@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.58.0505271741490.1757@pnote.perex-int.cz>
 <Pine.LNX.4.58.0505270903230.17402@ppc970.osdl.org>
 <Pine.LNX.4.58.0505271941250.1757@pnote.perex-int.cz>
 <Pine.LNX.4.58.0505271113410.17402@ppc970.osdl.org> <20050527135124.0d98c33e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 May 2005, Andrew Morton wrote:

> Linus Torvalds <torvalds@osdl.org> wrote:
> >
> > 
> > 
> > On Fri, 27 May 2005, Jaroslav Kysela wrote:
> > > 
> > > Okay, sorry for this small bug. I'll recreate the ALSA git tree with
> > > proper comments again. Also, the author is not correct (should be taken
> > > from the first Signed-off-by:).
> > 
> > Hmm.. That's not always true in general, since Sign-off does allow to sign
> > off on other peoples patches (see the "(b)" clause in DCO), but maybe in
> > the ALSA tree it is.
> 
> Yes, I'll occasionally do patches which were written by "A" as:
> 
> From: A
> ...
> Signed-off-by: B
> 
> And that comes through email as:
> 
> 
> ...
> From: <akpm@osdl.org>
> ...
> From: A
> ...
> Signed-off-by: B
> 
> 
> which means that the algorithm for identifying the author is "the final
> From:".
> 
> I guess the bug here is the use of From: to identify the primary author,
> because transporting the patch via email adds ambiguity.
> 
> Maybe we should introduce "^Author:"?
> 

That might be good.  I honestly don't know what would be the best 
solution, but what happens often at the moment is that patches get passed 
on as "From" whatever maintainer (or random resender) happened to pass it 
on to Andrew/Linus and that person then effectively gets labeled as the 
author of the patch in the changelogs/git/whatever. That's not perfect...

Author: might solve it.. worth a shot if you ask me.. 


-- 
Jesper Juhl


