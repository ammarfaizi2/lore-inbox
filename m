Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261692AbTCQOfB>; Mon, 17 Mar 2003 09:35:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261694AbTCQOfB>; Mon, 17 Mar 2003 09:35:01 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:21521 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S261692AbTCQOfA>; Mon, 17 Mar 2003 09:35:00 -0500
Date: Mon, 17 Mar 2003 15:45:54 +0100
From: Pavel Machek <pavel@suse.cz>
To: Wayne Scott <wscott@bitmover.com>
Cc: lm@bitmover.com, linux-kernel@vger.kernel.org, ockman@penguincomputing.com,
       dev@bitmover.com
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
Message-ID: <20030317144553.GA27626@atrey.karlin.mff.cuni.cz>
References: <20030312034330.GA9324@work.bitmover.com> <20030316134558.GH8057@zaurus.ucw.cz> <20030317.091838.74743468.wscott@bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030317.091838.74743468.wscott@bitmover.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > As far as I can see, linux-2.5 repository has over 17000 ChangeSets,
> > that means half the granularity.
> 
> I assume this has already been answered since this is Monday morning
> and I haven't finished my mountain of email (I try not to read it on
> weekends), but I will answer this anyway.
> 
> The ChangeSet file has many csets and we only capture around 1/2 of
> them in CVS ChangeSet file.  The extra ChangeSets are grouped together
> with the merge cset where they were added to the path we are
> recording.  That is correct, but it is not the whole story.
> 
> What happens is that most csets modifiy a non overlapping set of
> files.  So while we didn't get every delta to the ChangeSet file, we
> did capture >90% of the actual changes to the source files in the
> tree.

Oh, so there's extra magic.

Question, through: why is it impossible / infeasible to use CVS
branches to capture *full* information? Merge would then say
"(changeset 1.2345, merge from 1.23.4.5)" or similar...

								Pavel

-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
