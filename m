Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751272AbWBEI4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbWBEI4v (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 03:56:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbWBEI4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 03:56:51 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:23513 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP
	id S1751272AbWBEI4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 03:56:50 -0500
Date: Sun, 5 Feb 2006 09:56:49 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Marc Koschewski <marc@osknowledge.org>, dtor_core@ameritech.net,
       rlrevell@joe-job.com, 76306.1226@compuserve.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: Wanted: hotfixes for -mm kernels
Message-ID: <20060205085648.GA5663@stiffy.osknowledge.org>
References: <200602021502_MC3-1-B772-547@compuserve.com> <1138913633.15691.109.camel@mindpipe> <d120d5000602021345i255bb69eydb67bc1b0a448f8d@mail.gmail.com> <20060203100703.GA5691@stiffy.osknowledge.org> <20060204083752.a5c5b058.mbligh@mbligh.org> <20060204185738.GA5689@stiffy.osknowledge.org> <43E4FF13.2050206@mbligh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E4FF13.2050206@mbligh.org>
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.16-rc2-marc-g5b7b644c
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Martin J. Bligh <mbligh@mbligh.org> [2006-02-04 11:22:59 -0800]:

> 
> >We talked about hotfixes for -mm. So why not check these into the -mm-git 
> >tree
> >then? This would make sense and would conform fully to my understanding of 
> >what
> >the -mm-git tree should be. I don't want to select 23 patches from LKML to 
> >make
> >the tree compile or work. I want to checkout. Why make it easy when you 
> >may get
> >it difficult.
> >
> >Besides testing the stuff we would get more far by being able to test 
> >stuff faster
> >(because a patch is applied to -mm and we do a checkout) instead of 
> >waiting a
> >week for this mega-patch to be applied.
> >
> >What sense does an -mm tree make when there are people that cannot test it 
> >because of
> >known bugs that lead to the -mm tree not being bootable or - even worse - 
> >destroying
> >the system?
> >
> >git is you friend. Not only for Linus' tree, but as well for Andrew's tree.
> >It would just make debugging and testing -mm more convenient and less time
> >consuming for the testers. Instead of 1000 people seeking patches Andrew 
> >would
> >just check in and we all could pull it.
> >
> >If you agree with me or not - that's what I think.
> 
> SCMs don't fix anything. The real work is in selecting patches and 
> merging them. Frankly,  I test a lot of stuff myself, and the tarballs 
> are  a damned sight easier to work with, and have a simple chronological 
> timeline to work from.

To me it would be easier if I could use a repository that get's updated every
day (or several times a day) than wait a week for the patch to be available.

Moreover, a repository in fact _is_ easyier when it comes to debugging than is a
tarball or such. What if one says 'Gimme that driver 6 weeks ago'? See ... with
a repository I could just get it whereas with patches I have to read lots of
mails to get a clue when stuff got applied (in the tree and over here on my hard
disk).

I didn't mean to start a discussion here. I was just telling you what is easier
for me. Anyone has it's own style of coding. Someone likes patches, others
just live with them. My boss doesn't like vi either. So I may not use it? Puh!

Marc
