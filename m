Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964962AbWALBfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964962AbWALBfo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 20:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964961AbWALBfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 20:35:43 -0500
Received: from mail07.syd.optusnet.com.au ([211.29.132.188]:51889 "EHLO
	mail07.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S964958AbWALBfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 20:35:42 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: -mm seems significanty slower than mainline on kernbench
Date: Thu, 12 Jan 2006 12:36:07 +1100
User-Agent: KMail/1.8.3
Cc: "Martin J. Bligh" <mbligh@google.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
References: <43C45BDC.1050402@google.com> <200601121218.47744.kernel@kolivas.org> <43C5B0F6.5090500@bigpond.net.au>
In-Reply-To: <43C5B0F6.5090500@bigpond.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601121236.07522.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jan 2006 12:29 pm, Peter Williams wrote:
> Con Kolivas wrote:
> > This is a shot in the dark. We haven't confirmed 1. there is a problem 2.
> > that this is the problem nor 3. that this patch will fix the problem.
>
> I disagree.  I think that there is a clear mistake in my original patch
> that this patch fixes.

I agree with you on that. The real concern is that we were just about to push 
it upstream. So where does this leave us? I propose we delay merging the 
"improved smp nice handling" patch into mainline pending your further 
changes.

Cheers,
Con
