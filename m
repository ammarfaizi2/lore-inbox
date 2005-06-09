Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261578AbVFICMU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261578AbVFICMU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 22:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262004AbVFICMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 22:12:20 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:48609 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261578AbVFICMR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 22:12:17 -0400
Subject: Re: [PATCH 3/4] new timeofday x86-64 arch specific changes (v. B1)
From: john stultz <johnstul@us.ibm.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Andi Kleen <ak@suse.de>, Parag Warudkar <kernel-stuff@comcast.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1118281635.6247.42.camel@mindpipe>
References: <060220051827.15835.429F4FA6000DF9D700003DDB220588617200009A9B9CD3040A029D0A05@comcast.net>
	 <200506051015.33723.kernel-stuff@comcast.net>
	 <20050606092925.GA23831@wotan.suse.de>
	 <200506060746.23047.kernel-stuff@comcast.net>
	 <20050608135138.GX23831@wotan.suse.de>  <1118281635.6247.42.camel@mindpipe>
Content-Type: text/plain
Date: Wed, 08 Jun 2005 19:12:13 -0700
Message-Id: <1118283133.5754.41.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-08 at 21:47 -0400, Lee Revell wrote:
> On Wed, 2005-06-08 at 15:51 +0200, Andi Kleen wrote:
> > On Mon, Jun 06, 2005 at 07:46:22AM -0400, Parag Warudkar wrote:
> > > On Monday 06 June 2005 05:29, Andi Kleen wrote:
> > > > And does it work with nopmtimer ?
> > > >
> > > > -Andi
> > > 
> > > Thanks for trimming the CC list. 
> > > 
> > > No it doesn't work with nopmtimer - music still plays fast. I have to go back 
> > > to 2.6.11 to get it to play at right speed. 
> > 
> > Then it is something else, not the pmtimer.
> > 
> > I dont know what it could be. Do a binary search? 
> 
> XMMS has a long history of buggy ALSA support, which has improved
> lately.  Make sure you're using the latest version.
> 
> Also try 2.6.11 with ALSA 1.0.9, maybe it's an interaction between ALSA
> and the new gettimeofday patches.

Wahzuntme! :)  Well, I'd be very interested if my patches were to blame,
but I believe Parag said it happened with or without my patches.

Parag: If I'm incorrect and the issue goes away without my patches,
please let me know as I want to get to the bottom of it. 

thanks
-john


