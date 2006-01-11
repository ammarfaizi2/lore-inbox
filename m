Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161089AbWAKByM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161089AbWAKByM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 20:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161092AbWAKByM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 20:54:12 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:56588 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161089AbWAKByL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 20:54:11 -0500
Date: Wed, 11 Jan 2006 02:54:09 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Sean <seanlkml@sympatico.ca>
Cc: Ian McDonald <imcdnzl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       trivial@kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Revised [PATCH] Documentation: Update to SubmittingPatches
Message-ID: <20060111015409.GE29663@stusta.de>
References: <cbec11ac0512201343q79de6e13h6fccf1259445076@mail.gmail.com> <20060111005721.GA29663@stusta.de> <46118.10.10.10.28.1136943503.squirrel@linux1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46118.10.10.10.28.1136943503.squirrel@linux1>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2006 at 08:38:23PM -0500, Sean wrote:
> On Tue, January 10, 2006 7:57 pm, Adrian Bunk said:
> 
> >> -Use "diff -up" or "diff -uprN" to create patches.
> >> +You can use git-diff(1) or git-format-patch(1) which makes your life
> >> easy. If
> >> +you want it to be more difficult then carry on reading.
> >>...
> >
> > IMHO, this doesn't make much sense:
> >
> > The average patch submitter does _not_ use git in any way - and there's
> > no reason why he should.
> >
> 
> Git is an efficient and convenient way to track the mainline kernel.   The
> number of submitters using it is significant enough to mention it as an
> option for creating patches.


<--  snip  -->

--------------------------------------------
SECTION 1 - CREATING AND SENDING YOUR CHANGE
--------------------------------------------

1) Creating a diff file
-----------------------

You can use git-diff(1) or git-format-patch(1) which makes your life easy. If
you want it to be more difficult then carry on reading.

<--  snip  -->


The first mentionings of the string "git" in the document are in this 
line.

SubmittingPatches should teach newbies how to create good patches with 
GNU diff, and random references to git programs don't help anyone.

If a submitter is using a git-based workflow he most likely has a 
comletely different wotkflow than the one described in SubmittingPatches -
and git-specific documents should cover what he should do.


> Sean

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

