Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752196AbWAEULs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752196AbWAEULs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 15:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752199AbWAEULs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 15:11:48 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:64195 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1752194AbWAEULr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 15:11:47 -0500
Subject: Re: [OT] ALSA userspace API complexity
From: Lee Revell <rlrevell@joe-job.com>
To: patrizio.bassi@gmail.com
Cc: Jaroslav Kysela <perex@suse.cz>, "Kernel," <linux-kernel@vger.kernel.org>
In-Reply-To: <43BD7C5D.4090506@gmail.com>
References: <4uzow-1g5-13@gated-at.bofh.it> <5r0aY-2If-41@gated-at.bofh.it>
	 <5r3Ca-88G-81@gated-at.bofh.it> <5reGV-6YD-23@gated-at.bofh.it>
	 <5reGV-6YD-21@gated-at.bofh.it> <5rf9X-7yf-25@gated-at.bofh.it>
	 <43BBB7DC.2060303@gmail.com> <1136487557.31583.37.camel@mindpipe>
	 <43BD7C5D.4090506@gmail.com>
Content-Type: text/plain
Date: Thu, 05 Jan 2006 15:11:42 -0500
Message-Id: <1136491903.847.7.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-05 at 21:06 +0100, Patrizio Bassi wrote:
> Lee Revell ha scritto:
> 
> >On Wed, 2006-01-04 at 12:56 +0100, Patrizio Bassi wrote:
> >  
> >
> >>that's a big problem. Needs a radical solution. Considering aoss works
> >>in 50% of cases i suggest aoss improvement and not OSS keeping in
> >>kernel.
> >>
> >>    
> >>
> >
> >Please rephrase your statement in the form of a USEFUL BUG REPORT.
> >
> >Lee
> >
> >
> >  
> >
> i opened an aoss/skype bug, that got closed without a complete fix..
> because other problems were found...but actually that's not a complete
> solution
> 
> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1224
> 
> 

Please see bug #1228.  I closed #1224 as it had diverged wildly from the
original bug report (which was someone asking "why ALSA doesn't do
software mixing like artsd", which it does of course).

The status is we need more information on this bug.  Some people report
that Skype works perfectly with aoss.  It seems to be hardware, ALSA
version, or Skype version dependent.

Since Skype is closed source I'm afraid you'll have to do most of the
debugging work yourself, we can't waste time debugging closed source
apps.

I have heard that kiax (open source VOIP client) has some of the same
problems with aoss as Skype so that's likely to be the most productive
approach.

Lee

