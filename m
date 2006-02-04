Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751541AbWBDS5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751541AbWBDS5m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 13:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751546AbWBDS5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 13:57:42 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:16016 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP
	id S1751530AbWBDS5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 13:57:42 -0500
Date: Sat, 4 Feb 2006 19:57:39 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Marc Koschewski <marc@osknowledge.org>, dtor_core@ameritech.net,
       rlrevell@joe-job.com, 76306.1226@compuserve.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: Wanted: hotfixes for -mm kernels
Message-ID: <20060204185738.GA5689@stiffy.osknowledge.org>
References: <200602021502_MC3-1-B772-547@compuserve.com> <1138913633.15691.109.camel@mindpipe> <d120d5000602021345i255bb69eydb67bc1b0a448f8d@mail.gmail.com> <20060203100703.GA5691@stiffy.osknowledge.org> <20060204083752.a5c5b058.mbligh@mbligh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060204083752.a5c5b058.mbligh@mbligh.org>
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.16-rc2-marc-g53ea68ec
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Martin J. Bligh <mbligh@mbligh.org> [2006-02-04 08:37:52 -0800]:

> 
> > > > I doubt it - mm is an experimental kernel, hotfixes only make sense for
> > > > production stuff.  It moves too fast.
> > > >
> > > > A better question is what does -mm give you that mainline does not, that
> > > > causes you to want to "stabilize" a specific -mm version?
> > > >
> > > 
> > > Some people just run -mm so the hotfixes/* would help them to get
> > > their boxes running until the next -mm without having to hunt through
> > > LKML for bugs already reported/fixed. This will allow better testing
> > > coverage because most obvious bugs are caught almost immediately and
> > > then people can continue using -mm to find more stuff.
> > 
> > ... that's just why I so often wish to have a -git tree, Andrew. ;)
> 
> Why do people always thing a source code control system is magically going
> to fix all bugs and wipe their ass for them?
> 
> You still have to work out which patches are relevant and merge them. If 
> he's just merging a new set of changes constantly, it won't help you a damn. 

We talked about hotfixes for -mm. So why not check these into the -mm-git tree
then? This would make sense and would conform fully to my understanding of what
the -mm-git tree should be. I don't want to select 23 patches from LKML to make
the tree compile or work. I want to checkout. Why make it easy when you may get
it difficult.

Besides testing the stuff we would get more far by being able to test stuff faster
(because a patch is applied to -mm and we do a checkout) instead of waiting a
week for this mega-patch to be applied.

What sense does an -mm tree make when there are people that cannot test it because of
known bugs that lead to the -mm tree not being bootable or - even worse - destroying
the system?

git is you friend. Not only for Linus' tree, but as well for Andrew's tree.
It would just make debugging and testing -mm more convenient and less time
consuming for the testers. Instead of 1000 people seeking patches Andrew would
just check in and we all could pull it.

If you agree with me or not - that's what I think.

Marc
