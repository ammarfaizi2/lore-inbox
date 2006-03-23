Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030213AbWCWId2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030213AbWCWId2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 03:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030216AbWCWId2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 03:33:28 -0500
Received: from mail.gmx.de ([213.165.64.20]:45549 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030213AbWCWId1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 03:33:27 -0500
X-Authenticated: #19452082
Date: Thu, 23 Mar 2006 09:33:30 +0100
From: Thomas Kuther <gimpel@sonnenkinder.org>
To: ck@vds.kolivas.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [ck] swap prefetching merge plans
Message-ID: <20060323093330.488162c9@SiRiUS.home>
In-Reply-To: <200603230901.57052.jos@mijnkamer.nl>
References: <20060322205305.0604f49b.akpm@osdl.org>
	<200603231804.36334.kernel@kolivas.org>
	<200603230901.57052.jos@mijnkamer.nl>
X-Mailer: Sylpheed-Claws 2.0.0 (GTK+ 2.8.16; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Mar 2006 09:01:53 +0100
jos poortvliet <jos@mijnkamer.nl> wrote:

> Op donderdag 23 maart 2006 08:04, schreef Con Kolivas:
> > On Thu, 23 Mar 2006 03:53 pm, Andrew Morton wrote:
> > > A look at the -mm lineup for 2.6.17:
> > >
> > > mm-implement-swap-prefetching.patch
> > > mm-implement-swap-prefetching-fix.patch
> > > mm-implement-swap-prefetching-tweaks.patch
> > >
> > >   Still don't have a compelling argument for this, IMO.
> 
> well, the reason i use it is my computer is much more reactive in the
> morning. linux uses to get very slow after a night of not-doing-much
> except some 'sleep 5h && blabla' and cron stuff. in the morning it
> takes a few HOURS to get up and running smoothly. with swap prefetch,
> it actually feels faster compared to a fresh boot. now you can force
> swap prefetch to start working, i use it now and then after some
> heavy taskts which pulled everything to swap.

I absolutely second that! It was really annoying to have the box
unresponsive in the morning - like waiting 3-4 minutes till sylpheed
started up. This effect is almost totally gone with sp.   
