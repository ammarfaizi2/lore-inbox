Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750909AbWIUTqN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbWIUTqN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 15:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbWIUTqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 15:46:13 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:50952 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750909AbWIUTqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 15:46:12 -0400
Date: Thu, 21 Sep 2006 21:46:04 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jeff Garzik <jeff@garzik.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19 -mm merge plans
Message-ID: <20060921194604.GQ31906@stusta.de>
References: <20060920135438.d7dd362b.akpm@osdl.org> <45121382.1090403@garzik.org> <20060920220744.0427539d.akpm@osdl.org> <1158830206.11109.84.camel@localhost.localdomain> <Pine.LNX.4.64.0609210819170.4388@g5.osdl.org> <20060921105959.a55efb5f.akpm@osdl.org> <Pine.LNX.4.64.0609211106391.4388@g5.osdl.org> <4512DB05.2090604@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4512DB05.2090604@garzik.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2006 at 02:33:41PM -0400, Jeff Garzik wrote:
> Linus Torvalds wrote:
> >One of the things that I think the current model has excelled at is how it 
> >really changed peoples behaviour, simply because they knew and understood 
> >the rules.
> >
> >I think the "big merges in the first two weeks, and a -rc1 after, and no 
> >new code after that" rule has been working because it brought everybody in 
> >on the same page. 
> 
> 
> I definitely agree with all that.
> 
> I simply argue that, the more time that passes between releases, the 
> MORE BUGS that appear in the next release.
> 
> After -rc1, you reach a point of diminishing returns where users don't 
> re-test Release Candidates, developers move on to new code rather than 
> fix bugs, and we all move into a limbo where 2.6.X-rcY doesn't see much 
> activity, but the huge "merge snowball" in -mm builds and builds and builds.

This "there is not enough testing by users" is simply not true:

Even the kernel Bugzilla that contains only a small subset of all bug 
reports contains 78 (sic) open bugs reported against 2.6.18-rc kernels [1].

Not all of them are regressions, but this shows that users are testing 
-rc kernels and reporting bugs.

> As an aside, if a release is getting held up by some key bugs or 
> regressions, I think it's more than fair for Andrew to loudly shame said 
> developers into action.  "The following nincompoops are holding up the 
> release:  Jeff Garzik [bug #1222, #3391], Greg KH [bug #9987, #4418], ..."
> 
> 	Jeff

cu
Adrian

[1] including bugs reported against 2.6.18-rc?-mm? and 2.6.18-rc?-git*

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

