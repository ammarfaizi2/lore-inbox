Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932370AbWBBWqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbWBBWqr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 17:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932416AbWBBWqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 17:46:47 -0500
Received: from smtp.osdl.org ([65.172.181.4]:36005 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932370AbWBBWqq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 17:46:46 -0500
Date: Thu, 2 Feb 2006 14:48:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: pavel@ucw.cz, nigel@suspend2.net, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, Dave Jones <davej@codemonkey.org.uk>
Subject: Re: [ 00/10] [Suspend2] Modules support.
Message-Id: <20060202144841.19b3bbb6.akpm@osdl.org>
In-Reply-To: <1138919381.15691.162.camel@mindpipe>
References: <20060201113710.6320.68289.stgit@localhost.localdomain>
	<200602022131.59928.nigel@suspend2.net>
	<20060202115907.GH1884@elf.ucw.cz>
	<200602022214.52752.nigel@suspend2.net>
	<20060202152316.GC8944@ucw.cz>
	<20060202132708.62881af6.akpm@osdl.org>
	<1138916079.15691.130.camel@mindpipe>
	<20060202142323.088a585c.akpm@osdl.org>
	<1138919381.15691.162.camel@mindpipe>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> wrote:
>
> On Thu, 2006-02-02 at 14:23 -0800, Andrew Morton wrote:
> > Lee Revell <rlrevell@joe-job.com> wrote:
> > >
> > > On Thu, 2006-02-02 at 13:27 -0800, Andrew Morton wrote:
> > > > And having them separate like this weakens both in the area where
> > > >   the real problems are: drivers. 
> > > 
> > > Which are the worst offenders, keeping in mind that ALSA was recently
> > > fixed?
> > > 
> > 
> > I don't have that info, sorry - that was vague handwaving.
> > 
> > We seem to get a lot of reports of PATA drivers failing to resume correctly.
> > 
> > And video hardware not coming back in a sane state (lack of documentation).
> > 
> 
> OK.
> 
> Follow up - do we have a rough idea how bad the suspend problem is, like
> approximately what % of laptops don't DTRT and just suspend when you
> close the lid?
> 

I do recall someone had some numbers on that, but I forget who it was. 
David might have a feel for it?
