Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262660AbVCKKTp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262660AbVCKKTp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 05:19:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263244AbVCKKTp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 05:19:45 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:53993 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262660AbVCKKTj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 05:19:39 -0500
Date: Fri, 11 Mar 2005 11:13:49 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Greg KH <greg@kroah.com>, Neil Brown <neilb@cse.unsw.edu.au>,
       linux-kernel@vger.kernel.org, Chris Wright <chrisw@osdl.org>,
       torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] -stable, how it's going to work.
Message-ID: <20050311101349.GA30252@elf.ucw.cz>
References: <20050309072833.GA18878@kroah.com> <16944.6867.858907.990990@cse.unsw.edu.au> <20050310164312.GC16126@kroah.com> <1110475644.12805.43.camel@mindpipe> <20050310173144.GA17206@kroah.com> <1110479120.12805.82.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1110479120.12805.82.camel@mindpipe>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Čt 10-03-05 13:25:19, Lee Revell wrote:
> On Thu, 2005-03-10 at 09:31 -0800, Greg KH wrote:
> > On Thu, Mar 10, 2005 at 12:27:23PM -0500, Lee Revell wrote:
> > > On Thu, 2005-03-10 at 08:43 -0800, Greg KH wrote:
> > > > That, and a zillion other specific wordings that people suggested fall
> > > > under the:
> > > > 	or some "oh, that's not good" issue
> > > > rule.
> > > 
> > > So just to be 100% clear, no sound with 2.6.N where the sound worked
> > > with 2.6.N-1 absolutely does qualify.  Right?
> > 
> > Hm, do you think that is a "good" thing to have happen?...
> 
> OK, so it sounds like scheduling latency regressions also qualify.  This
> could make a system that worked on 2.6.N-1 unusable on 2.6.N, and the
> fixes here (usually restoring a lockbreak) are almost always small and
> obvious.  And users do report this, usualy in the form of "JACK was
> usable under foo kernel but I get xruns with the same config under bar
> kernel".

No, I do not think we want to extend it that far. Latency regression
is more of "oh, who cares" issue ;-).
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
