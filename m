Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262074AbTCLWUh>; Wed, 12 Mar 2003 17:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262079AbTCLWUg>; Wed, 12 Mar 2003 17:20:36 -0500
Received: from bitmover.com ([192.132.92.2]:24500 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S262074AbTCLWTb>;
	Wed, 12 Mar 2003 17:19:31 -0500
Date: Wed, 12 Mar 2003 14:30:13 -0800
From: Larry McVoy <lm@bitmover.com>
To: David Lang <david.lang@digitalinsight.com>
Cc: Larry McVoy <lm@bitmover.com>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
Message-ID: <20030312223013.GH7275@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	David Lang <david.lang@digitalinsight.com>,
	Larry McVoy <lm@bitmover.com>,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	linux-kernel@vger.kernel.org
References: <20030312220156.GE30788@work.bitmover.com> <Pine.LNX.4.44.0303121409300.11045-100000@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303121409300.11045-100000@dlang.diginsite.com>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 12, 2003 at 02:21:49PM -0800, David Lang wrote:
> and if you did real-time updates but once a month or so redid the
> 'longest-path' thing that would change the CVS version info, correct?

Exactly.  So if we redo it then anyone who has active CVS workspaces will
get the wrong thing when they update if the revs have moved around and
they will.

I suspect the right answer is that we do the real time updates, see how it
goes, if it starts to suck we'll periodically toss the CVS tree and start
over.  
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
