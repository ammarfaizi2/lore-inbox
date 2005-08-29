Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751310AbVH2Vwm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbVH2Vwm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 17:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbVH2Vwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 17:52:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21934 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751310AbVH2Vwl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 17:52:41 -0400
Date: Mon, 29 Aug 2005 14:52:38 -0700
From: Chris Wright <chrisw@osdl.org>
To: Peter =?iso-8859-1?Q?M=FCnster?= <pmlists@free.fr>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: kernel freezes with 2.6.12.5 and 2.6.13
Message-ID: <20050829215238.GF7762@shell0.pdx.osdl.net>
References: <Pine.LNX.4.58.0508292050180.28621@gaston.free.fr> <20050829191754.GW7991@shell0.pdx.osdl.net> <Pine.LNX.4.58.0508292253590.32579@gaston.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0508292253590.32579@gaston.free.fr>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Münster (pmlists@free.fr) wrote:
> On Mon, 29 Aug 2005, Chris Wright wrote:
> 
> > * Peter Münster (pmlists@free.fr) wrote:
> > > with 2.6.12.4 no problem. But with a newer version, I get a black screen
> > > and no more network access, when trying to print (lpr some-file.ps).
> > > Everything else seems to work ok.
> > > Printer is a network-printer managed by cups.
> > > I suppose, it's a smp-problem, so here is my /proc/cpuinfo:
> > 
> > Is this 100% reproducible?  Do you get any kernel oops messages on
> > the console?  There are very few patches between 2.6.12.4 and 2.6.12.5,
> > so if the problem is reproducible can you narrow to the specific patch?
> 
> Yes, it's 100% reproducible. But I do not get any message. Display is
> shutting down, and no more access with ssh. Ctrl-Alt-Del does not work
> neither. Nothing in /var/log/messages.

Are you running X?  Can you reproduce running lpr from console command line?

> Of course, I can try to narrow down to the specific patch, if you send me
> the different patches. I only have the diff between 2.6.12.4 and 2.6.12.5
> and I don't know how to extract the patches.

They're here in git:

http://kernel.org/git/?p=linux/kernel/git/chrisw/stable-queue.git;a=tree;h=5c84e7f0112b3961f7a346b4d0161048482b2b6b;hb=717a323d8a8523fc5972158c5cef8ba914f36671;f=2.6.12.5
