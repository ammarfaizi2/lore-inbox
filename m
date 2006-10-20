Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992509AbWJTGfk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992509AbWJTGfk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 02:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992520AbWJTGfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 02:35:40 -0400
Received: from smtpout.mac.com ([17.250.248.183]:11713 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S2992509AbWJTGfj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 02:35:39 -0400
In-Reply-To: <45386C29.7050501@drzeus.cx>
References: <4537EB67.8030208@drzeus.cx> <20061019152503.217a82aa.akpm@osdl.org> <45386C29.7050501@drzeus.cx>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D6DF81E5-B51F-47D2-AA02-9EBD63FD6D6B@mac.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Git training wheels for the pimple faced maintainer
Date: Fri, 20 Oct 2006 02:35:19 -0400
To: Pierre Ossman <drzeus-list@drzeus.cx>
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAA==
X-Brightmail-scanned: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 20, 2006, at 02:26:49, Pierre Ossman wrote:
> Andrew Morton wrote:
>> Just send me the url&branch-name for a tree which you want  
>> included in -mm.
>> I typically pull all the trees once per day.  I usually won't even  
>> look at
>> the contents of what I pulled from you unless it breaks.
>>
>> IOW, -mm is like a tree to which 70-odd people have commit  
>> permissions,
>> except it's 70 separate trees and I independently jam them all  
>> into one
>> tree daily.
>>
>
> So, in other words, you have no issues with a lot of merges in the  
> branch you're pulling from? Do you do a fresh pull each time or do  
> you update an existing copy? If you do the latter, then I assume it  
> is critical that my "for-andrew" branch has a continous history?  
> (Which it won't naturally have as the changes will be replaced by  
> identical changes coming from Linus' tree)

I seem to remember Andrew saying something like (paraphrased) "In the  
event that your tree doesn't have a continuous history for whatever  
reason, I'll just pull a fresh copy and work from there".  Given that  
he maintains -mm as a quilt patchset and only uses GIT for incoming  
pulls, I would guess that either way is probably OK, although the  
continuous history makes merging and fixing rejects mildly nicer.

Cheers,
Kyle Moffett
