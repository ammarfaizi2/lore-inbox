Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291480AbSBABF1>; Thu, 31 Jan 2002 20:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291478AbSBABFN>; Thu, 31 Jan 2002 20:05:13 -0500
Received: from bitmover.com ([192.132.92.2]:19385 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S291480AbSBABE3>;
	Thu, 31 Jan 2002 20:04:29 -0500
Date: Thu, 31 Jan 2002 17:04:28 -0800
From: Larry McVoy <lm@bitmover.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: Larry McVoy <lm@bitmover.com>, Troy Benjegerdes <hozer@drgw.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020131170428.V1519@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Keith Owens <kaos@ocs.com.au>, Larry McVoy <lm@bitmover.com>,
	Troy Benjegerdes <hozer@drgw.net>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020131091914.L1519@work.bitmover.com> <21196.1012523398@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <21196.1012523398@kao2.melbourne.sgi.com>; from kaos@ocs.com.au on Fri, Feb 01, 2002 at 11:29:58AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2002 at 11:29:58AM +1100, Keith Owens wrote:
> That sounds almost like what I was looking for, with two differences.
> 
> (1) Implement the collapsed set so bk records that it is equivalent to
>     the individual patchsets.  Only record that information in my tree.
>     I need the detailed history of what changes went into the collapsed
>     set, nobody else does.
> 
> (2) Somebody else creates a change against the collapsed set and I pull
>     that change.  bk notices that the change is again a collapsed set
>     for which I have local detail.  The external change becomes a
>     branch off the last detailed patch in the collapsed set.

This is certainly possible to do.  However, unless you are willing to fund
this development, we aren't going to do it.  We will pick up the costs of
making changes that you want if and only if we have commercial customers
who want (or are likely to want) the same thing.  Nothing personal, it's
a business and we make tradeoffs like that all the time.

Collapsing is relatively easy, it's tracking the same content in two
different sets of deltas which is hard to get exactly correct.  Certainly
possible but I can visualize what it would take and it would be messy and
disruptive to the source base for an obscure feature that is unlikely to
be used.

Why don't you actually use BK for a while and see if you really think
you need this feature.  The fact that our customers aren't clamoring for
it should tell you something.  They do work as hard and on as much code
(in many cases on the same code) as you do.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
