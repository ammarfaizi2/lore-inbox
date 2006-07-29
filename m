Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161459AbWG2E2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161459AbWG2E2r (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 00:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161460AbWG2E2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 00:28:47 -0400
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:45020
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S1161459AbWG2E2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 00:28:47 -0400
Date: Fri, 28 Jul 2006 21:28:20 -0700
To: Jim Gettys <jg@laptop.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Neil Horman <nhorman@tuxdriver.com>,
       Dave Airlie <airlied@gmail.com>,
       Segher Boessenkool <segher@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, a.zummo@towertech.it, jg@freedesktop.org,
       Keith Packard <keithp@keithp.com>,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: [PATCH] RTC: Add mmap method to rtc character driver
Message-ID: <20060729042820.GA16133@gnuppy.monkey.org>
References: <F09D8005-BD93-4348-9FD1-0FA5D8D096F1@kernel.crashing.org> <20060725194733.GJ4608@hmsreliant.homelinux.net> <21d7e9970607251304n5681bf44gc751c21fd79be99d@mail.gmail.com> <44C67E1A.7050105@zytor.com> <20060725204736.GK4608@hmsreliant.homelinux.net> <1153861094.1230.20.camel@localhost.localdomain> <44C6875F.4090300@zytor.com> <1153862087.1230.38.camel@localhost.localdomain> <44C68AA8.6080702@zytor.com> <1153863542.1230.41.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1153863542.1230.41.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11+cvs20060403
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2006 at 05:39:01PM -0400, Jim Gettys wrote:
> Keith's the expert (who wrote the smart scheduler): I'd take a wild ass
> guess that 10ms is good enough.
> 
> Maybe people can keep him on the cc list this time...

Not to poop on people's parade, but the last time I looked /dev/rtc was
a single instance device, right ? If this reasoning is true, then mplayer
and other apps that want to open it can't.

What's the story with this ?

bill

