Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285424AbRL2UFN>; Sat, 29 Dec 2001 15:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285398AbRL2UFE>; Sat, 29 Dec 2001 15:05:04 -0500
Received: from bitmover.com ([192.132.92.2]:57767 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S285408AbRL2UEw>;
	Sat, 29 Dec 2001 15:04:52 -0500
Date: Sat, 29 Dec 2001 12:04:51 -0800
From: Larry McVoy <lm@bitmover.com>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: Larry McVoy <lm@bitmover.com>,
        Christer Weinigel <wingel@hog.ctrl-c.liu.se>,
        linux-kernel@vger.kernel.org
Subject: Re: The direction linux is taking
Message-ID: <20011229120451.E19306@work.bitmover.com>
Mail-Followup-To: Oliver Xymoron <oxymoron@waste.org>,
	Larry McVoy <lm@bitmover.com>,
	Christer Weinigel <wingel@hog.ctrl-c.liu.se>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011229113749.D19306@work.bitmover.com> <Pine.LNX.4.43.0112291341360.18183-100000@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.43.0112291341360.18183-100000@waste.org>; from oxymoron@waste.org on Sat, Dec 29, 2001 at 01:58:21PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 29, 2001 at 01:58:21PM -0600, Oliver Xymoron wrote:
> On Sat, 29 Dec 2001, Larry McVoy wrote:
> 
> > [patchbot stuff]
> 
> > If you have N people trying to patch the same file, you'll require N
> > releases and some poor shlep is going to have to resubmit their patch
> > N-1 times before it gets in.
> 
> The point is to have N patches queued against rev x that apply cleanly 

And my point is that your N is likely to be quite small out of a possible
set that is quite large.  If I'm right, then the patchbot idea is pointless
because all the interesting work is happening in the part of the set that
the patchbot can't handle.

I make no claims as to where the partition is in Linux, only the maintainers
can tell us that.  I do claim that in the commercial world, the set of patches
which apply clean is much much smaller than the set which require merging.

You might want to think about the _fact_ that getting patches to apply 
cleanly serializes all work on the area being patched.  If you can live
with that, fine.  If you can't, the patchbot doesn't help.  It solves the
easy part of the problem, which didn't need to be solved, and punts on
the hard part.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
