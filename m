Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263839AbTDIWOK (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 18:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263842AbTDIWOK (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 18:14:10 -0400
Received: from mailrelay2.lanl.gov ([128.165.4.103]:24527 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP id S263839AbTDIWOI (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 18:14:08 -0400
Subject: Re: 2.5.67, 2.5-bk lock up with RH 9 and graphical log out.
From: Steven Cole <elenstev@mesatop.com>
To: Andrew Morton <akpm@digeo.com>
Cc: felipe_alfaro@linuxmail.org, linux-kernel@vger.kernel.org
In-Reply-To: <20030409144930.5c72d732.akpm@digeo.com>
References: <1049904293.24463.25.camel@spc9.esa.lanl.gov>
	 <1049921014.592.0.camel@teapot.felipe-alfaro.com>
	 <1049922707.24466.41.camel@spc9.esa.lanl.gov>
	 <1049924199.24466.51.camel@spc9.esa.lanl.gov>
	 <20030409144930.5c72d732.akpm@digeo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1049927124.24466.58.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2-3mdk 
Date: 09 Apr 2003 16:25:24 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-09 at 15:49, Andrew Morton wrote:
> Steven Cole <elenstev@mesatop.com> wrote:
> >
> > On Wed, 2003-04-09 at 15:11, Steven Cole wrote:
> > 
> > > I also tried 2.5.67-ac1 which behaves the same as above, and
> > > 2.5.67-mm1 which does not hang, but reboots.  Adding akpm to
> > > the cc-list since -mm1 behaves a little differently than the rest.
> > > 
> > > I replaced id:5:initdefault: with id:3:initdefault: in /etc/inittab
> > > and that made the lockups go away with 2.5.67-[bk,ac1,mm1].  
> > 
> > Sorry, that last statement was a little vague.  I usually start X
> > with "startx", and that works fine with everything.  Hitting "Log Out"
> > kills X and gets me back to run level 3.  However, if I do a
> > /sbin/init 5, log in with the graphical login and then hit "Log Out",
> > the 2.5.67-[bk,ac1] kernels lock up and -mm1 reboots.
> 
> Something seems to have gone bad with AGP and/or DRM and/or radeon lately.
> 
> Try disabling AGP and/or DRM in config.

I first tried -mm1 with AGP disabled, but when I did /sbin/init 5, I got
into a dialog about selecting a different X server, so I elected not to
do that right now.  I re-enabled AGP and disabled DRM, and -mm1 rebooted
as before when "Log Out" was selected.  As a preliminary test, I had
started X with startx, and that worked fine on logout as before.
Sorry, but I'm running out of time for more testing today.  I'll try
again tomorrow when I have more time.

Steven

