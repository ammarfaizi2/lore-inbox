Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbWBCKvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbWBCKvP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 05:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbWBCKvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 05:51:15 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:57305 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932162AbWBCKvO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 05:51:14 -0500
Date: Fri, 3 Feb 2006 11:51:00 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Lee Revell <rlrevell@joe-job.com>, nigel@suspend2.net, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [ 00/10] [Suspend2] Modules support.
Message-ID: <20060203105100.GD2830@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602022131.59928.nigel@suspend2.net> <20060202115907.GH1884@elf.ucw.cz> <200602022214.52752.nigel@suspend2.net> <20060202152316.GC8944@ucw.cz> <20060202132708.62881af6.akpm@osdl.org> <1138916079.15691.130.camel@mindpipe> <20060202142323.088a585c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060202142323.088a585c.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Čt 02-02-06 14:23:23, Andrew Morton wrote:
> Lee Revell <rlrevell@joe-job.com> wrote:
> >
> > On Thu, 2006-02-02 at 13:27 -0800, Andrew Morton wrote:
> > > And having them separate like this weakens both in the area where
> > >   the real problems are: drivers. 
> > 
> > Which are the worst offenders, keeping in mind that ALSA was recently
> > fixed?
> > 
> 
> I don't have that info, sorry - that was vague handwaving.
> 
> We seem to get a lot of reports of PATA drivers failing to resume correctly.
> 
> And video hardware not coming back in a sane state (lack of documentation).

Video problems seem to be broken for suspend2ram, not swsusp.

Not that we don't have swsusp drivers problems, but they tend to be
randomly, all over the map, mostly over drivers I never heard about.

suspend2ram is different fish, video and ATA are real problems
there. At least there are solutions on ATA being worked on.

								Pavel
-- 
Thanks, Sharp!
