Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262960AbVCJScS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbVCJScS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 13:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262956AbVCJSbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 13:31:35 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:25046 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262921AbVCJSZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 13:25:22 -0500
Subject: Re: [RFC] -stable, how it's going to work.
From: Lee Revell <rlrevell@joe-job.com>
To: Greg KH <greg@kroah.com>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@osdl.org>, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050310173144.GA17206@kroah.com>
References: <20050309072833.GA18878@kroah.com>
	 <16944.6867.858907.990990@cse.unsw.edu.au>
	 <20050310164312.GC16126@kroah.com> <1110475644.12805.43.camel@mindpipe>
	 <20050310173144.GA17206@kroah.com>
Content-Type: text/plain
Date: Thu, 10 Mar 2005 13:25:19 -0500
Message-Id: <1110479120.12805.82.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-10 at 09:31 -0800, Greg KH wrote:
> On Thu, Mar 10, 2005 at 12:27:23PM -0500, Lee Revell wrote:
> > On Thu, 2005-03-10 at 08:43 -0800, Greg KH wrote:
> > > That, and a zillion other specific wordings that people suggested fall
> > > under the:
> > > 	or some "oh, that's not good" issue
> > > rule.
> > 
> > So just to be 100% clear, no sound with 2.6.N where the sound worked
> > with 2.6.N-1 absolutely does qualify.  Right?
> 
> Hm, do you think that is a "good" thing to have happen?...

OK, so it sounds like scheduling latency regressions also qualify.  This
could make a system that worked on 2.6.N-1 unusable on 2.6.N, and the
fixes here (usually restoring a lockbreak) are almost always small and
obvious.  And users do report this, usualy in the form of "JACK was
usable under foo kernel but I get xruns with the same config under bar
kernel".

Lee

