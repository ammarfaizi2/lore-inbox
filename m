Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261657AbVBOJFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261657AbVBOJFa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 04:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbVBOJFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 04:05:30 -0500
Received: from smtp.andrew.cmu.edu ([128.2.10.81]:49112 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S261657AbVBOJEd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 04:04:33 -0500
Message-ID: <4211BB15.9020100@andrew.cmu.edu>
Date: Tue, 15 Feb 2005 04:04:21 -0500
From: James Bruce <bruce@andrew.cmu.edu>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Felker <tfelker2@uiuc.edu>
CC: lm@bitmover.com, Matthew Jacob <lydianconcepts@gmail.com>,
       Jeff Sipek <jeffpc@optonline.net>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [BK] upgrade will be needed
References: <20050214020802.GA3047@bitmover.com> <7579f7fb0502141017f5738d1@mail.gmail.com> <20050214185624.GA16029@bitmover.com> <200502141530.47019.tfelker2@uiuc.edu>
In-Reply-To: <200502141530.47019.tfelker2@uiuc.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I agree with this 100%, and this is exactly the same conclusion we came 
to in our research lab.

Tom Felker wrote:
> I really think the fewer restrictions you put on BK's use, the less likely it 
> will be copied.  When the open source community copies something, it's not out 
> of a desire to screw somebody over.  It's because they had an itch, a 
> software need that couldn't easily be fulfilled otherwise, a demand.
> 
> Apparently there is a demand for good SCM, and BK can satisfy this, and you've 
> done the very admirable thing of letting the open source community use BK at 
> no cost.  But by putting such a heavy restriction on its use, you create a 
> large portion of the community who won't or can't use it, and who therefore 
> need a "copy" of it, which is exactly what you are trying to prevent.
> ...
> Better for you would be to just not create this segment in the first place, by 
> making the license as unrestrictive as you can while still making money.  If 
> you take the non-compete clause out and leave it at "open repository and 
> logs," then BT would be good enough for most everybody, and you wouldn't have 
> to worry about a copy until after we're all using the Hurd.

One person (out of 20 or so), refused to use BK   because he 
occasionally worked on a binary tree-diff in his spare time.  He was, of 
course, properly following the BK-free license, but it meant the 
projects he worked on never got switched from CVS, while everything else 
went BK.  It also kept us looking for replacements to make everyone 
happy.  We consider every possible alternative, even though by most 
measures they are inferior (There isn't an SCM that I've heard of that 
someone in our lab hasn't tried using).  The peer pressure, if you will, 
also made the holdout *more* involved in SCM development, which is 
almost surely *not* a help for BitMover.  New projects are not being put 
in BK anymore, either.

Maybe this is an overly long and excessively detailed account, but my 
interpretation of it is the following:  Without the no-compete (1) We'd 
all be using BK happily, (2) The holdout would not be working on an SCM 
anymore, and (3) Other SCM projects would not get the user testing they 
now enjoy from us.  I cannot speak for anyone else, but this is the 
effect on our lab, and for us, the clause has hurt BitMover's stated 
intention, not helped it.

  - Jim Bruce

P.S. According to what is now legend, one of the things that drove RMS 
to the FSF philosophy was a person at CMU who wouldn't share printer 
driver source code with him.
(http://www.catb.org/~esr/writings/rms-bio.html)
