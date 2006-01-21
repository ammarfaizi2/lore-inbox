Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932286AbWAUBBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbWAUBBU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 20:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbWAUBBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 20:01:20 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:30665 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932286AbWAUBBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 20:01:20 -0500
Subject: Re: [Alsa-devel] Re: RFC: OSS driver removal, a slightly different
	approach
From: Lee Revell <rlrevell@joe-job.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dave Jones <davej@redhat.com>, Krzysztof Halasa <khc@pm.waw.pl>,
       Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       alsa-devel@alsa-project.org, perex@suse.cz
In-Reply-To: <1137719627.8471.89.camel@localhost.localdomain>
References: <20060119174600.GT19398@stusta.de>
	 <m3ek34vucz.fsf@defiant.localdomain> <1137703413.32195.23.camel@mindpipe>
	 <1137709135.8471.73.camel@localhost.localdomain>
	 <20060119224222.GW21663@redhat.com>  <1137711088.3241.9.camel@mindpipe>
	 <1137719627.8471.89.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 20 Jan 2006 20:01:17 -0500
Message-Id: <1137805277.3241.53.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-20 at 01:13 +0000, Alan Cox wrote:
> On Iau, 2006-01-19 at 17:51 -0500, Lee Revell wrote:
> > The status is we need someone who has the hardware who can add printk's
> > to the driver to identify what triggers the hang.  It should not be
> > hard, the OSS driver reportedly works.
> > 
> > https://bugtrack.alsa-project.org/alsa-bug/view.php?id=328
> > 
> > The bug has been in FEEDBACK state for a long time.
> 
> 99.9% of users don't ever look in ALSA bugzilla. 
> 
> A dig shows
> 
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=157371
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=171221
> 

I know, we don't expect users to look in it.  But you can't expect a
handful of developers, only two of whom are paid to work on ALSA, to
track every distro's bugzilla either.  It's hard enough to keep up with
the ALSA bug tracker.

The best solution is for the distros to make sure to refer users with
ALSA problems to the ALSA bug tracker, and for the maintainers of the
distro bugzillas to properly forward bugs upstream, like Debian does.

Lee



