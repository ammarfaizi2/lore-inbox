Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751056AbWINTP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbWINTP6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 15:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751058AbWINTP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 15:15:58 -0400
Received: from chain.digitalkingdom.org ([64.81.49.134]:19432 "EHLO
	chain.digitalkingdom.org") by vger.kernel.org with ESMTP
	id S1751054AbWINTP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 15:15:57 -0400
Date: Thu, 14 Sep 2006 12:15:55 -0700
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Same MCE on 4 working machines (was Re: Early boot hang on recent 2.6 kernels (> 2.6.3), on x86-64 with 16gb of RAM)
Message-ID: <20060914191555.GJ4610@chain.digitalkingdom.org>
References: <20060912223258.GM4612@chain.digitalkingdom.org> <20060914190548.GI4610@chain.digitalkingdom.org> <1158261249.7948.111.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158261249.7948.111.camel@mindpipe>
User-Agent: Mutt/1.5.12-2006-07-14
From: Robin Lee Powell <rlpowell@digitalkingdom.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2006 at 03:14:08PM -0400, Lee Revell wrote:
> On Thu, 2006-09-14 at 12:05 -0700, Robin Lee Powell wrote:
> > This isn't just me.  All the Debian kernels hang too.  I've tried
> > all of the following:
> > 
> > Linux version 2.6.8-12-amd64-generic (buildd@bester) (gcc version
> > 3.4.4 20050314 (prerelease) (Debian 3.4.3-13)) #1 Mon Jul 17 01:12:05
> > UTC 2006
> > 
> > Linux version 2.6.8-12-amd64-k8 (buildd@bester) (gcc version 3.4.4
> > 20050314 (prerelease) (Debian 3.4.3-13)) #1 Mon Jul 17 01:39:03 UTC
> > 2006
> > 
> > Linux version 2.6.8-12-amd64-k8-smp (buildd@bester) (gcc version 3.4.4
> > 20050314 (prerelease) (Debian 3.4.3-13)) #1 SMP Mon Jul 17 00:17:20
> > UTC 2006 
> 
> Have you tried a *recent* 2.6 kernel like 2.6.17 or 2.6.18-rc*?
> 
> 2.6.8 is way too old to debug.

Yes; that's what my previous post was about.  See
http://lkml.org/lkml/2006/9/12/300

I was doing 2.6.17.11, which was kernel.org's latest stable at the
time I started all this.

I tried the Debian kernels just to show that it wasn't just me
screwing up my kernel configs.

These machines will not boot an any kernel > 2.6.3 that I have
tried, and I've tried about 8 different ones at this point.

I noted in the release notes for 2.6.4 that the mce code was
entirely replaced; I'm suspecting that's the problem, but I have no
idea how to debug it.  Whether the problem is the kernel or the
motherboard is also certainly open to debate.

-Robin

-- 
http://www.digitalkingdom.org/~rlpowell/ *** http://www.lojban.org/
Reason #237 To Learn Lojban: "Homonyms: Their Grate!"
Proud Supporter of the Singularity Institute - http://singinst.org/
