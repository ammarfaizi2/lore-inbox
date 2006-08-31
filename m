Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbWHaCmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbWHaCmi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 22:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbWHaCmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 22:42:38 -0400
Received: from mse2fe2.mse2.exchange.ms ([66.232.26.194]:27264 "EHLO
	mse2fe2.mse2.exchange.ms") by vger.kernel.org with ESMTP
	id S1751155AbWHaCmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 22:42:37 -0400
Subject: How about an enumerated list of issues with the existing kgdb
	patches?
From: Piet Delaney <piet@bluelane.com>
Reply-To: piet@bluelane.com
To: Andrew Morton <akpm@osdl.org>
Cc: Piet Delaney <piet@bluelane.com>, vgoyal@in.ibm.com,
       George Anzinger <george@wildturkeyranch.net>,
       Discussion
	 "list for crash utility usage, maintenance and development" 
	<crash-utility@redhat.com>,
       kgdb-bugreport@lists.sourceforge.net,
       Subhachandra Chandra <schandra@bluelane.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060830155710.5865faa0.akpm@osdl.org>
References: <44EC8CA5.789286A@redhat.com>
	 <20060824111259.GB22145@in.ibm.com> <44EDA676.37F12263@redhat.com>
	 <1156966522.29300.67.camel@piet2.bluelane.com>
	 <20060830204032.GD30392@in.ibm.com>
	 <1156974093.29300.103.camel@piet2.bluelane.com>
	 <20060830144822.3b8ffb9a.akpm@osdl.org>
	 <20060830155710.5865faa0.akpm@osdl.org>
Content-Type: text/plain
Organization: BlueLane Tech,
Date: Wed, 30 Aug 2006 19:42:32 -0700
Message-Id: <1156992153.24314.24.camel@piet2.bluelane.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4-3mdk 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Aug 2006 02:42:36.0641 (UTC) FILETIME=[1E4A0510:01C6CCA7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-30 at 15:57 -0700, Andrew Morton wrote:
> On Wed, 30 Aug 2006 14:48:22 -0700
> Andrew Morton <akpm@osdl.org> wrote:
> 
> >  Plus: I'd want to see a maintainance person or team who
> > respond promptly to email and who remain reasonably engaged with what's
> > going on in the mainline kernel.  Because if problems crop up (and they
> > will), I don't want to have to be the bunny who has to worry about them...
> 
> umm, clarification needed here.
> 
> No criticism of the present maintainers intended!  Last time I grabbed the
> kgdb patches from sf.net they applied nicely, worked quite reliably (much
> better than the old ones I'd been trying to sustain) and had been
> tremendously cleaned up.

So why did you stop including them in the mm patch?

I recall your quality issue and Tom was all in favor
of resolving them. Was it too much work cleaning up the 
patches to meet your needs that lead to the patch being
dropped from the mm series?

kgdb over ethernet is working great, and it looks like there
is plenty of support on the SF mailing list.  

> 
> But if we're to move this work from sf.net to kernel.org, the kgdb
> maintainers' workload, email load, turnaround time requirements,
> bug-difficulty and everything else will go up quite a lot, at least short-term.
> If they don't want to volunteer take that on (perfectly legit and sane) then
> things should stay as they are.

I've only read a positive point of view on resolving the issues on the
mailing list.

> 
> (otoh, a merge would decrease their patch-maintenance load, and would
> increase the number of people who fix things for them, and might attract new
> maintainers).

I agree, it would likely attract many more maintainers and be easier 
to maintain with git than patches.

> 
> It's a big step.

How about a concrete list of patch quality issues that the group
can address to allow your weekly addition to the mm patch as a 
set toward eventually integration.

Wouldn't getting kgdb back into the mm patch series be a reasonable
first step eventual maintenance in kernel.org? I hadn't even noticed
that it had been dropped until today's discussion in the crash mailing
list.

-piet

-- 
Piet Delaney
BlueLane Teck
W: (408) 200-5256; piet@bluelane.com
H: (408) 243-8872; piet@piet.net


