Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbWG2M7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbWG2M7P (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 08:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbWG2M7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 08:59:15 -0400
Received: from ra.tuxdriver.com ([70.61.120.52]:9994 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1750784AbWG2M7O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 08:59:14 -0400
Date: Sat, 29 Jul 2006 08:54:27 -0400
From: Neil Horman <nhorman@tuxdriver.com>
To: Bill Huey <billh@gnuppy.monkey.org>
Cc: Jim Gettys <jg@laptop.org>, "H. Peter Anvin" <hpa@zytor.com>,
       Dave Airlie <airlied@gmail.com>,
       Segher Boessenkool <segher@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, a.zummo@towertech.it, jg@freedesktop.org,
       Keith Packard <keithp@keithp.com>
Subject: Re: [PATCH] RTC: Add mmap method to rtc character driver
Message-ID: <20060729125427.GA6669@localhost.localdomain>
References: <20060725194733.GJ4608@hmsreliant.homelinux.net> <21d7e9970607251304n5681bf44gc751c21fd79be99d@mail.gmail.com> <44C67E1A.7050105@zytor.com> <20060725204736.GK4608@hmsreliant.homelinux.net> <1153861094.1230.20.camel@localhost.localdomain> <44C6875F.4090300@zytor.com> <1153862087.1230.38.camel@localhost.localdomain> <44C68AA8.6080702@zytor.com> <1153863542.1230.41.camel@localhost.localdomain> <20060729042820.GA16133@gnuppy.monkey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060729042820.GA16133@gnuppy.monkey.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2006 at 09:28:20PM -0700, Bill Huey wrote:
> On Tue, Jul 25, 2006 at 05:39:01PM -0400, Jim Gettys wrote:
> > Keith's the expert (who wrote the smart scheduler): I'd take a wild ass
> > guess that 10ms is good enough.
> > 
> > Maybe people can keep him on the cc list this time...
> 
> Not to poop on people's parade, but the last time I looked /dev/rtc was
> a single instance device, right ? If this reasoning is true, then mplayer
> and other apps that want to open it can't.
> 
> What's the story with this ?
> 
Its always been the case.  Its hardware can only support one timer (or at least
one timer period), and as such multiple users would interefere with each other.

Regards
Neil

> bill
