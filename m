Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262330AbVBXMUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262330AbVBXMUT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 07:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262311AbVBXMUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 07:20:18 -0500
Received: from mx1.elte.hu ([157.181.1.137]:47289 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262312AbVBXMRF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 07:17:05 -0500
Date: Thu, 24 Feb 2005 13:16:57 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/13] remove aggressive idle balancing
Message-ID: <20050224121657.GA16183@elte.hu>
References: <1109229491.5177.71.camel@npiggin-nld.site> <1109229542.5177.73.camel@npiggin-nld.site> <1109229650.5177.78.camel@npiggin-nld.site> <1109229700.5177.79.camel@npiggin-nld.site> <1109229760.5177.81.camel@npiggin-nld.site> <1109229867.5177.84.camel@npiggin-nld.site> <1109229935.5177.85.camel@npiggin-nld.site> <1109230031.5177.87.camel@npiggin-nld.site> <20050224084118.GB10023@elte.hu> <421DC4DA.7000102@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <421DC4DA.7000102@yahoo.com.au>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> Ingo Molnar wrote:
> >* Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> >
> >
> >>[PATCH 6/13] no aggressive idle balancing
> >>
> >>[PATCH 8/13] generalised CPU load averaging
> >>[PATCH 9/13] less affine wakups
> >>[PATCH 10/13] remove aggressive idle balancing
> >
> >
> >they look fine, but these are the really scary ones :-) Maybe we could
> >do #8 and #9 first, then #6+#10. But it's probably pointless to look at
> >these in isolation.
> >
> 
> Oh yes, they are very scary and I guarantee they'll cause
> problems :P

:-|

> I didn't have any plans to get these in for 2.6.12 (2.6.13 at the very
> earliest). But it will be nice if Andrew can pick these up early so we
> try to get as much regression testing as possible.
> 
> I pretty much agree with your ealier breakdown of the patches (ie.
> some are fixes, others fairly straightfoward improvements that may get
> into 2.6.12, of course). Thanks very much for the review.
> 
> I expect to rework the patches, and things will get tuned and changed
> around a bit... Any problem with you taking these now though Andrew?

sure, fine with me.

	Ingo
