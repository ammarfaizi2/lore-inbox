Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264992AbTCCXyw>; Mon, 3 Mar 2003 18:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265154AbTCCXyw>; Mon, 3 Mar 2003 18:54:52 -0500
Received: from bitmover.com ([192.132.92.2]:9090 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S264992AbTCCXyv>;
	Mon, 3 Mar 2003 18:54:51 -0500
Date: Mon, 3 Mar 2003 16:05:11 -0800
From: Larry McVoy <lm@bitmover.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: David Lang <david.lang@digitalinsight.com>,
       Andrea Arcangeli <andrea@suse.de>, Larry McVoy <lm@bitmover.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Arador <diegocg@teleline.es>,
       "Adam J. Richter" <adam@yggdrasil.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       pavel@janik.cz, pavel@ucw.cz
Subject: Re: BitBucket: GPL-ed *notrademarkhere* clone
Message-ID: <20030304000511.GC21701@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Jeff Garzik <jgarzik@pobox.com>,
	David Lang <david.lang@digitalinsight.com>,
	Andrea Arcangeli <andrea@suse.de>, Larry McVoy <lm@bitmover.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Arador <diegocg@teleline.es>,
	"Adam J. Richter" <adam@yggdrasil.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	pavel@janik.cz, pavel@ucw.cz
References: <Pine.LNX.4.44.0303031554230.29949-100000@dlang.diginsite.com> <3E63ED14.5090809@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E63ED14.5090809@pobox.com>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 03, 2003 at 07:02:28PM -0500, Jeff Garzik wrote:
> David Lang wrote:
> >On Mon, 3 Mar 2003, Andrea Arcangeli wrote:
> >
> >
> >>Just curious, this also means that at least around the 80% of merges
> >>in Linus's tree is submitted via a bitkeeper pull, right?
> >>
> >>Andrea
> >
> >
> >remember how Linus works, all normal patches get copied into a single
> >large patch file as he reads his mail then he runs patch to apply them to
> >the tree. I think this would make the entire batch of messages look like
> >one cset.
> 
> 
> Not correct.  His commits properly separate the patches out into 
> individual csets.

And we've written code which finds the longest path through the graph
to get the finest granularity; when run on his tree we get 8138 nodes.
That is 43% of the 18837 nodes possible.  The trunk only includes
1068 nodes.  So we can a very good job exporting to CVS.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
