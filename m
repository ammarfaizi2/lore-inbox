Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280506AbRJaVCL>; Wed, 31 Oct 2001 16:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280507AbRJaVCB>; Wed, 31 Oct 2001 16:02:01 -0500
Received: from dsl-213-023-038-229.arcor-ip.net ([213.23.38.229]:44804 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S280506AbRJaVBw>;
	Wed, 31 Oct 2001 16:01:52 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: Google's mm problem - not reproduced on 2.4.13
Date: Wed, 31 Oct 2001 22:03:31 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, Rik van Riel <riel@conectiva.com.br>,
        Ben Smith <ben@google.com>
In-Reply-To: <E15yzlQ-00021P-00@starship.berlin> <E15z28m-0000vb-00@starship.berlin> <20011031214540.D1291@athlon.random>
In-Reply-To: <20011031214540.D1291@athlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E15z2WJ-0000wc-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On October 31, 2001 09:45 pm, Andrea Arcangeli wrote:
> On Wed, Oct 31, 2001 at 09:39:12PM +0100, Daniel Phillips wrote:
> > On October 31, 2001 07:06 pm, Daniel Phillips wrote:
> > > I just tried your test program with 2.4.13, 2 Gig, and it ran without 
> > > problems.  Could you try that over there and see if you get the same result?
> > > If it does run, the next move would be to check with 3.5 Gig.
> > 
> > Ben reports that his test with 2 Gig memory runs fine, as it does for me, but 
> > that it locks up tight with 3.5 Gig, requiring power cycle.  Since I only 
> > have 2 Gig here I can't reproduce that (yet).
> 
> are you sure it isn't an oom condition. can you reproduce on
> 2.4.14pre5aa1? mainline (at least before pre6) could deadlock with too
> much mlocked memory.

I don't know, I can't reproduce it here, I don't have enough memory.  Ben?

--
Daniel
