Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310447AbSCKR0B>; Mon, 11 Mar 2002 12:26:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310452AbSCKRZv>; Mon, 11 Mar 2002 12:25:51 -0500
Received: from bitmover.com ([192.132.92.2]:21677 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S310301AbSCKRZj>;
	Mon, 11 Mar 2002 12:25:39 -0500
Date: Mon, 11 Mar 2002 09:25:38 -0800
From: Larry McVoy <lm@bitmover.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Larry McVoy <lm@bitmover.com>, Rik van Riel <riel@conectiva.com.br>,
        "Jonathan A. George" <JGeorge@greshamstorage.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Kernel SCM: When does CVS fall down where it REALLY matters?
Message-ID: <20020311092538.U26447@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"Randy.Dunlap" <rddunlap@osdl.org>, Larry McVoy <lm@bitmover.com>,
	Rik van Riel <riel@conectiva.com.br>,
	"Jonathan A. George" <JGeorge@greshamstorage.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020311090512.N26447@work.bitmover.com> <Pine.LNX.4.33L2.0203110911530.3326-100000@dragon.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33L2.0203110911530.3326-100000@dragon.pdx.osdl.net>; from rddunlap@osdl.org on Mon, Mar 11, 2002 at 09:12:31AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2002 at 09:12:31AM -0800, Randy.Dunlap wrote:
> On Mon, 11 Mar 2002, Larry McVoy wrote:
> 
> | On Thu, Mar 07, 2002 at 08:59:47PM -0300, Rik van Riel wrote:
> | > 3) graphical 2-way merging tool like bitkeeper has
> | >    (this might not seem essential to people who have
> | >    never used it, but it has saved me many many hours)
> |
> | I haven't verified this, but I suspect what Rik is using is the 3-way
> | file merge.  If it looks like
> |
> | 	http://www.bitkeeper.com/newmerge.gif
> |
> | that's a 3 way file merge, the 2 big side by side windows are showing
> | you 3 diffs, the diff from the ancestor to the local version in the left
> | window, the diff from the ancestor to the remote version in the right
> | window, and then side by side diffs in that they are lined up.
> |
> | If Rik is using the 2 way file merge and likes that, he's in for a quantum
> | leap in productivity, commercial customers have reported as much as an
> | 18:1 productivity increase from the 3 way file merge.
> 
> Just curious, how is this productivity increase measured?

They redid the same really nasty merge with the old tools, with Sun's
file merge, and the new filemerge.  It was a bit more than 18x faster
with the new file merge.

This same customer site, which hacks the kernel by the way, claims that 
well over 90% of their BK usage is spent merging, so the productivity 
gains in merging are translated almost 1:1 into wall clock gains.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
