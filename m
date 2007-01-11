Return-Path: <linux-kernel-owner+w=401wt.eu-S1030252AbXAKKyA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030252AbXAKKyA (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 05:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030268AbXAKKyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 05:54:00 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:4192 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1030252AbXAKKx7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 05:53:59 -0500
Date: Thu, 11 Jan 2007 11:54:02 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jiri Kosina <jikos@jikos.cz>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       John McCutchan <john@johnmccutchan.com>, rml@novell.com,
       Cijoml Cijomlovic Cijomlov <cijoml@volny.cz>
Subject: Re: 2.6.20-rc4: known unfixed regressions (v3)
Message-ID: <20070111105402.GA20027@stusta.de>
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org> <20070111051022.GA21724@stusta.de> <45A5DCAB.6060900@yahoo.com.au> <20070111084554.GF21724@stusta.de> <Pine.LNX.4.64.0701111119180.16747@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701111119180.16747@twin.jikos.cz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 11, 2007 at 11:21:23AM +0100, Jiri Kosina wrote:
> On Thu, 11 Jan 2007, Adrian Bunk wrote:
> 
> > > >Subject    : BUG: at fs/inotify.c:172 set_dentry_child_flags()
> > > >References : http://bugzilla.kernel.org/show_bug.cgi?id=7785
> > > >Submitter  : Cijoml Cijomlovic Cijomlov <cijoml@volny.cz>
> > > >Handled-By : John McCutchan <john@johnmccutchan.com>
> > > >Status     : problem is being debugged
> > > I'm not sure that this is actually a regression for 2.6.20-rc.
> > The submitter says it doesn't occur in 2.6.19.
> 
> Any chance that the submitter could do git bisect? (added to CC). From the 
> bugzilla entry it seems to be well reproducible for him.

That's a possible but time intensive approach for this kind of bug.

I'd expect bisecting such an "at least 1 times a day" bug to take at 
about one month.

And that's not a high number, that's a realistic estimate considering 
that you have to test a dozen kernels and verifying that a kernel is 
good takes 2-3 days.

> Jiri Kosina

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

