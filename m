Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261331AbTCOQlm>; Sat, 15 Mar 2003 11:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261332AbTCOQlm>; Sat, 15 Mar 2003 11:41:42 -0500
Received: from bitmover.com ([192.132.92.2]:19642 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S261331AbTCOQll>;
	Sat, 15 Mar 2003 11:41:41 -0500
Date: Sat, 15 Mar 2003 08:52:29 -0800
From: Larry McVoy <lm@bitmover.com>
To: David Lang <david.lang@digitalinsight.com>, Larry McVoy <lm@bitmover.com>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
Message-ID: <20030315165229.GA23205@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	David Lang <david.lang@digitalinsight.com>,
	Larry McVoy <lm@bitmover.com>,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	linux-kernel@vger.kernel.org
References: <20030312220156.GE30788@work.bitmover.com> <Pine.LNX.4.44.0303121409300.11045-100000@dlang.diginsite.com> <20030312223013.GH7275@work.bitmover.com> <20030312161813.S12806@schatzie.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030312161813.S12806@schatzie.adilger.int>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I suspect the right answer is that we do the real time updates, see how it
> > goes, if it starts to suck we'll periodically toss the CVS tree and start
> > over.  
> 
> What you could do is have a CVS "realtime" branch which is forked from the
> trunk, say once a week, or whenever Linux makes a point release.  

I'm not sure it is worth it.  If you are using BK, run revtool and look at
the recent history in 2.5.  I just updated the CVS tree on kernel.bkbits.net
and looked carefully at the collapsing it did.  It collapsed a pile of Greg's
stuff into one cset, but that's actually OK as far as I can tell, it's all
related.  And there was more work on the other path.

We've done several updates to the 2.5 tree and so far the number of changesets
we would have gotten if we had done it all in one pass and the number that 
we actually got is identical.  So maybe the reality of the incremental updates
is better than we expected.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
