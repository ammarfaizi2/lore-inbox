Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285161AbSA3BAn>; Tue, 29 Jan 2002 20:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287633AbSA3BAe>; Tue, 29 Jan 2002 20:00:34 -0500
Received: from mail1.amc.com.au ([203.15.175.2]:261 "HELO mail1.amc.com.au")
	by vger.kernel.org with SMTP id <S285161AbSA3BAY>;
	Tue, 29 Jan 2002 20:00:24 -0500
Message-Id: <5.1.0.14.0.20020130113958.00a04390@mail.amc.localnet>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 30 Jan 2002 12:00:11 +1100
To: linux-kernel@vger.kernel.org
From: Stuart Young <sgy@amc.com.au>
Subject: Re: A modest proposal -- We need a patch penguin
Cc: Olaf Dietsche <olaf.dietsche--list.linux-kernel@exmail.de>,
        John Weber <weber@nyc.rr.com>
In-Reply-To: <87n0yxqa6e.fsf@tigram.bogus.local>
In-Reply-To: <3C5600A6.3080605@nyc.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 07:33 PM 29/01/02 +0100, Olaf Dietsche wrote:

>How about extracting patches from lkml with procmail?
>
>---cut here-->8---
>:0 :
>* ^sender: linux-kernel-owner@vger.kernel.org
>* ^subject:.*patch
>{
>         :0 Bc:
>         * ^--- .*/
>         * ^+++ .*/
>         linux-kernel-patches
>}
>---8<--cut here---
>
>This recipe has its limits, but it's a start.

Actually I was sort of thinking that maybe part of the problem with our 
current system is the noise-to-signal ratio of lkml itself.

Perhaps it's time we set up a specific lkml-patch mailing list, and leave 
lkml for discussions about the problems. Have a script that posts general 
details about patches on lkml when there is a post to lkml-patch if you 
like, so people know and can go and take a look if they want. If you get 
complex, it can vet the patches to see if they apply, before pushing them 
to the list. It also goes well with some sort of patch tracking system (who 
says we can't use a mailing list as a distribution mechanism), if that gets 
the go ahead, while not requiring it.

Another possibility (or could even be combined) is that perhaps we need to 
start separating the mailing list at the code tree level.

eg: The "development" tree (lkml-dev which would currently contain 2.5.x) 
from the "stable" tree (lkml-stable which would currently contain 2.4.x) 
from the "older" trees (lkml-old which would currently contain 
2.2.x/2.0.x), at the mailing list level.

That way, people can concentrate on a specific tree (eg: Linus could 
concentrate on 2.5.x), without getting inundated with all the other stuff. 
This progresses easily when the next "stable" branch hits, so that the 
"dev" list can keep talking about what they plan to do while waiting for 
the stable to fork into the new development tree, and the previous stable 
joins the ranks of the "old" kernels, where it might possibly still get the 
occasional fix.

By reducing the noise (and hey, there is a reason people black-list certain 
subjects on lkml apart from personal/flame war issues), people can 
concentrate on the facts. The less noise (the less traffic?) the more 
likely every message will be read, patches will be checked, etc. Especially 
when you have other "duties" apart from maintaining kernel code, it's not 
always easy keeping up with lkml.


Stuart Young - sgy@amc.com.au
(aka Cefiar) - cefiar1@optushome.com.au

[All opinions expressed in the above message are my]
[own and not necessarily the views of my employer..]

