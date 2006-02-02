Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932360AbWBBW3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbWBBW3o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 17:29:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932361AbWBBW3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 17:29:44 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:31900 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932360AbWBBW3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 17:29:43 -0500
Subject: Re: [ 00/10] [Suspend2] Modules support.
From: Lee Revell <rlrevell@joe-job.com>
To: Andrew Morton <akpm@osdl.org>
Cc: pavel@ucw.cz, nigel@suspend2.net, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060202142323.088a585c.akpm@osdl.org>
References: <20060201113710.6320.68289.stgit@localhost.localdomain>
	 <200602022131.59928.nigel@suspend2.net> <20060202115907.GH1884@elf.ucw.cz>
	 <200602022214.52752.nigel@suspend2.net> <20060202152316.GC8944@ucw.cz>
	 <20060202132708.62881af6.akpm@osdl.org>
	 <1138916079.15691.130.camel@mindpipe>
	 <20060202142323.088a585c.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 02 Feb 2006 17:29:40 -0500
Message-Id: <1138919381.15691.162.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-02 at 14:23 -0800, Andrew Morton wrote:
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
> 

OK.

Follow up - do we have a rough idea how bad the suspend problem is, like
approximately what % of laptops don't DTRT and just suspend when you
close the lid?

Lee

