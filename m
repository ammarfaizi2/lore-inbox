Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964989AbWALC2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964989AbWALC2N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 21:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932676AbWALC2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 21:28:12 -0500
Received: from mail27.syd.optusnet.com.au ([211.29.133.168]:55757 "EHLO
	mail27.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932678AbWALC2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 21:28:11 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: -mm seems significanty slower than mainline on kernbench
Date: Thu, 12 Jan 2006 13:27:48 +1100
User-Agent: KMail/1.8.3
Cc: "Martin J. Bligh" <mbligh@google.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
References: <43C45BDC.1050402@google.com> <200601121236.07522.kernel@kolivas.org> <43C5BD8F.3000307@bigpond.net.au>
In-Reply-To: <43C5BD8F.3000307@bigpond.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601121327.48640.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jan 2006 01:23 pm, Peter Williams wrote:
> Con Kolivas wrote:
> > On Thu, 12 Jan 2006 12:29 pm, Peter Williams wrote:
> >>Con Kolivas wrote:
> >>>This is a shot in the dark. We haven't confirmed 1. there is a problem
> >>> 2. that this is the problem nor 3. that this patch will fix the
> >>> problem.
> >>
> >>I disagree.  I think that there is a clear mistake in my original patch
> >>that this patch fixes.
> >
> > I agree with you on that. The real concern is that we were just about to
> > push it upstream. So where does this leave us?  I propose we delay
> > merging the "improved smp nice handling" patch into mainline pending your
> > further changes.
>
> I think that they're already in 2.6.15 minus my "move load not tasks"
> modification which I was expecting to go into 2.6.16.  Is that what you
> meant?

Yes, akpm included your patch under the name of something like "improved smp 
nice handling". My smp nice patches went into mainline 2.6.15 and were 
extensively tested for performance regressions. This is about your move load 
not tasks modification which is the patch in question that might be affecting 
performance.

Con

> If so I think this is a small and obvious fix that shouldn't delay the
> merging of "move load not tasks" into the mainline.  But it's not my call.
>
> Peter
