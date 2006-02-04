Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932567AbWBDUll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932567AbWBDUll (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 15:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932568AbWBDUll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 15:41:41 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:15623 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932567AbWBDUll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 15:41:41 -0500
Date: Sat, 4 Feb 2006 21:41:39 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Marc Koschewski <marc@osknowledge.org>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>, dtor_core@ameritech.net,
       rlrevell@joe-job.com, 76306.1226@compuserve.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: Wanted: hotfixes for -mm kernels
Message-ID: <20060204204139.GA4528@stusta.de>
References: <200602021502_MC3-1-B772-547@compuserve.com> <1138913633.15691.109.camel@mindpipe> <d120d5000602021345i255bb69eydb67bc1b0a448f8d@mail.gmail.com> <20060203100703.GA5691@stiffy.osknowledge.org> <20060204083752.a5c5b058.mbligh@mbligh.org> <20060204185738.GA5689@stiffy.osknowledge.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060204185738.GA5689@stiffy.osknowledge.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 04, 2006 at 07:57:39PM +0100, Marc Koschewski wrote:
> * Martin J. Bligh <mbligh@mbligh.org> [2006-02-04 08:37:52 -0800]:
> > 
> > > > > I doubt it - mm is an experimental kernel, hotfixes only make sense for
> > > > > production stuff.  It moves too fast.
> > > > >
> > > > > A better question is what does -mm give you that mainline does not, that
> > > > > causes you to want to "stabilize" a specific -mm version?
> > > > >
> > > > 
> > > > Some people just run -mm so the hotfixes/* would help them to get
> > > > their boxes running until the next -mm without having to hunt through
> > > > LKML for bugs already reported/fixed. This will allow better testing
> > > > coverage because most obvious bugs are caught almost immediately and
> > > > then people can continue using -mm to find more stuff.
> > > 
> > > ... that's just why I so often wish to have a -git tree, Andrew. ;)
> > 
> > Why do people always thing a source code control system is magically going
> > to fix all bugs and wipe their ass for them?
> > 
> > You still have to work out which patches are relevant and merge them. If 
> > he's just merging a new set of changes constantly, it won't help you a damn. 
> 
> We talked about hotfixes for -mm. So why not check these into the -mm-git tree
> then? This would make sense and would conform fully to my understanding of what
> the -mm-git tree should be. I don't want to select 23 patches from LKML to make
> the tree compile or work. I want to checkout. Why make it easy when you may get
> it difficult.
>...
> What sense does an -mm tree make when there are people that cannot test it because of
> known bugs that lead to the -mm tree not being bootable or - even worse - destroying
> the system?

That's exactly what Andrew does now implement through the hot-fixes
directory [1].

Git doesn't help for the problem that it's currently empty - it's more 
important that people tell Andrew that this or that patch should be made 
available there.

> git is you friend. Not only for Linus' tree, but as well for Andrew's tree.
> It would just make debugging and testing -mm more convenient and less time
> consuming for the testers. Instead of 1000 people seeking patches Andrew would
> just check in and we all could pull it.
>...

git is the SCM Linus developed to fit his workflow.

Andrew has a completely different workflow, and he has developed the 
tools he needs for his workflow.

As long as they are able to interact (which seems to work without 
problems), there's nothing forcing them to use the same tools.

> Marc

cu
Adrian

[1] ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc1/2.6.16-rc1-mm5/hot-fixes/

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

