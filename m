Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264536AbRFTSJe>; Wed, 20 Jun 2001 14:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264532AbRFTSJO>; Wed, 20 Jun 2001 14:09:14 -0400
Received: from sdsl-208-184-147-195.dsl.sjc.megapath.net ([208.184.147.195]:25108
	"EHLO bitmover.com") by vger.kernel.org with ESMTP
	id <S264531AbRFTSJF>; Wed, 20 Jun 2001 14:09:05 -0400
Date: Wed, 20 Jun 2001 11:08:49 -0700
From: Larry McVoy <lm@bitmover.com>
To: john slee <indigoid@higherplane.net>
Cc: Michael Rothwell <rothwell@holly-springs.nc.us>,
        linux-kernel@vger.kernel.org
Subject: Re: Alan Cox quote? (was: Re: accounting for threads)
Message-ID: <20010620110849.V3089@work.bitmover.com>
Mail-Followup-To: john slee <indigoid@higherplane.net>,
	Michael Rothwell <rothwell@holly-springs.nc.us>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010619200442.E30785@work.bitmover.com> <20010620202130.H30872@higherplane.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010620202130.H30872@higherplane.net>; from indigoid@higherplane.net on Wed, Jun 20, 2001 at 08:21:30PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2001 at 08:21:30PM +1000, john slee wrote:
> On Tue, Jun 19, 2001 at 08:04:42PM -0700, Larry McVoy wrote:
> > I asked Linus for this a long time ago and he pointed out that you couldn't
> > make it work over NFS, at least not nicely.  It does seem like that could
> > be worked around by having a "poll daemon" which knew about all the things
> > being waited on and checked them.  Or something.
> 
> could sgi's imon+fam work help a little here (with the "poll daemon" part)?
> am i on the wrong train ? :-]

I was never a fan of that tool though SGI people loved it.  I think that 
someone needs to grab this area and think it through.  There ought to be
some way to do this that isn't gross.  But it will take some thinking.  
If you could convince one of the file system guys to think about this for
a week I suspect you'd get something nice.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
