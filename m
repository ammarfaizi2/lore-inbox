Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313767AbSDWE5h>; Tue, 23 Apr 2002 00:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313792AbSDWE5g>; Tue, 23 Apr 2002 00:57:36 -0400
Received: from c17736.belrs2.nsw.optusnet.com.au ([211.28.31.90]:23494 "EHLO
	bozar") by vger.kernel.org with ESMTP id <S313767AbSDWE5e>;
	Tue, 23 Apr 2002 00:57:34 -0400
Date: Tue, 23 Apr 2002 14:57:03 +1000
From: Andre Pang <ozone@algorithm.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: BK, deltas, snapshots and fate of -pre...
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020422131011.D6638@havoc.gtf.org> <5.1.0.14.2.20020422184538.03ce36e0@pop.cus.cam.ac.uk> <E16zLsy-0001Is-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Message-Id: <1019537823.310634.29598.nullmailer@bozar.algorithm.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 21, 2002 at 08:16:28PM +0200, Daniel Phillips wrote:

> Please don't assign me membership in any anti-bitkeeper crew.  I am not
> anti-BitKeeper.  If you must have an epithet, try "anti-advertising-in-the-tree"
> crew.

As Larry has said, if you are anti-advertising-in-the-tree, then
start submitting patches regarding reiserfs, because of the large
amount of advertising to Namesys and their sponsors.

After reading the thread in its entirety (boy, that was fun),
here's a summary of points that you're trying to make, all of
which are independent issues:

    1. BK is not GPL; it is commercial software

    2. Having the BK doc in Documentation/ is advertising in the tree
    
    3. Having the BK doc in Documentation/ is advertising for
       commercial software

    4. Commercial software should be used as little as possible
       in such a large-scale GPL project like the Linux kernel

    5. Existence of BK doc will promote BK-style patches instead
       of the more traditional diff-style patches

    6. BK enables less discussion of patches because Linus can
       pull them from other BK trees

    7. From point 6, BK therefore makes it easier to have less
       public review (i.e. mails to LKML with "[RFC]") on patches

    8. Because of point 7, there is in fact less public review on
       patches

    9. Less public review on patches is bad

    10. Non-BK users feel left out because they feel that many
        patches are getting into the tree without their knowledge
        and/or less public review

    11. Pulling BK doc in the tree would make less users aware of
	BK and thus solve most of these problems

As Andrew Morton has said, some of these problems are simply
unsolvable, like BK being commercial software.  Your ideology vs
Jeff's is probably not reconcilable.

So, what are the problems that can be solved?  Perhaps adding
some lines to the BitKeeper doc saying "Unless your patch is
trivial, please post it to linux-kernel for peer review, because
this is one of the great strengths of open-source software" would
be a good idea.

Supply a shell script in the BK docs which generates a diff-style
patch and send that off to LKML if you update a BK tree.

Add that patch which was floating around earlier in the thread
saying that BK is non-free, and that it is only one alternative
for doing things.

Or maybe set up another separate mailing list (e.g.
linux-bk-updates), run by a bot which emails that list whenever
a patch to a BK tree is submitted.  People who don't use BK, such
as yourself, can subscribe to the list and initiate discussion on
such patches by bringing the mail to linux-kernel.

BK is here to stay; no doubt about that.  Doing something
completely controversial like removing the docs for it is not the
way to go if you want to solve the problems that it has created.
I think it's good that you vocalised the problems with using BK,
but you're going about fixing the symptoms in the wrong way.

I'm sure people (Jeff and Larry, in particular) would be much
more happy if you addressed those issues by adding things to the
BK docs highlighting the problems that it causes, and include
ways of fixing them.  You say that you're not anti-BK, and
I believe you're not, but your actions are indicating otherwise.

BK is not the problem: BK is a new way of working with Linus,
which is causing problems for people who are used to the non-BK
way of working with him.  Fix that problem, not BK itself.


-- 
#ozone/algorithm <ozone@algorithm.com.au>          - trust.in.love.to.save
