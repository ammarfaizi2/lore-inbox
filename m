Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290966AbSAaGHl>; Thu, 31 Jan 2002 01:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290965AbSAaGHb>; Thu, 31 Jan 2002 01:07:31 -0500
Received: from bitmover.com ([192.132.92.2]:63150 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S290967AbSAaGHV>;
	Thu, 31 Jan 2002 01:07:21 -0500
Date: Wed, 30 Jan 2002 22:07:20 -0800
From: Larry McVoy <lm@bitmover.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: Larry McVoy <lm@bitmover.com>, Rob Landley <landley@trommello.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020130220720.I18381@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Keith Owens <kaos@ocs.com.au>, Larry McVoy <lm@bitmover.com>,
	Rob Landley <landley@trommello.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020130215523.G18381@work.bitmover.com> <9787.1012456991@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <9787.1012456991@kao2.melbourne.sgi.com>; from kaos@ocs.com.au on Thu, Jan 31, 2002 at 05:03:11PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 05:03:11PM +1100, Keith Owens wrote:
> On Wed, 30 Jan 2002 21:55:23 -0800, 
> Larry McVoy <lm@bitmover.com> wrote:
> >On Thu, Jan 31, 2002 at 04:46:43PM +1100, Keith Owens wrote:
> >> When I release a patch I pick a start
> >> point (base 2.4.17, patch set 17.1) and an end point (kdb v2.1 2.4.17
> >> common-2, patchset 17.37) and prcs diff -r 17.1 -r 17.37.  
> >
> >bk export -tpatch -r17.1,17.37
> >
> >Does exactly the same thing.
> 
> Now you've confused me :).  Does that replicate the history or not?

Nope.

> I know that bk can generate a patch which is fine for people not using
> bk, but one of the selling points of bk is the ability to replicate
> history entries.  

Yup.

> My point is that full replication of history may be
> too much detail for anybody except the original developer.  If bk can
> consolidate a series of patchsets into one big patchset (not patch)
> which becomes the unit of distribution then the problem of too much
> history can be solved.

If all you mean is that you don't want to have to tell it what to send,
yes, it does that automatically.  If you start with 100 changes, 
I clone your tree, you add 200 more, all I do to get them is say

	bk pull

it will send them all, quickly (works very nicely over a modem or 
a long latency link like a satellite).
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
