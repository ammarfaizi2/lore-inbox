Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263491AbREYCiu>; Thu, 24 May 2001 22:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263492AbREYCik>; Thu, 24 May 2001 22:38:40 -0400
Received: from csl.Stanford.EDU ([171.64.66.149]:64733 "EHLO csl.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S263491AbREYCiV>;
	Thu, 24 May 2001 22:38:21 -0400
From: Dawson Engler <engler@csl.Stanford.EDU>
Message-Id: <200105250238.TAA00788@csl.Stanford.EDU>
Subject: Re: [CHECKER] error path memory leaks in 2.4.4 and 2.4.4-ac8
To: dwmw2@infradead.org (David Woodhouse)
Date: Thu, 24 May 2001 19:38:14 -0700 (PDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <10347.990741765@redhat.com> from "David Woodhouse" at May 24, 2001 11:02:45 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> These are all now either fixed or obsoleted in my tree, and I will send a 
> patch to Linus shortly. Thankyou. 

Good deal.  Thanks for letting us know!

> Do you find it useful to get a response such as this? Are you keeping track
> of the bugs you find? (Or is it simply reassuring to confirm that someone's
> paying attention? :)

It's definitely useful, since it lets us keep tabs on what types of bugs
people actually fix ;-)  The tool keeps track of the bugs/false positives we
find, so that it can say when we find something new.

> I believe we can make that a short. Arjan?

Is the general way to fix these too-large stack vars to heap allocate
them?  Or is it preferable to put a "static" in front of them, if the
routine is non-reentrant?

Dawson
