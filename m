Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932231AbWG2Vt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbWG2Vt4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 17:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932232AbWG2Vt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 17:49:56 -0400
Received: from mail.gmx.de ([213.165.64.21]:6300 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932231AbWG2Vt4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 17:49:56 -0400
X-Authenticated: #271361
Date: Sat, 29 Jul 2006 23:49:48 +0200
From: Edgar Toernig <froese@gmx.de>
To: Bill Huey (hui) <billh@gnuppy.monkey.org>
Cc: Neil Horman <nhorman@tuxdriver.com>, Jim Gettys <jg@laptop.org>,
       "H. Peter Anvin" <hpa@zytor.com>, Dave Airlie <airlied@gmail.com>,
       Segher Boessenkool <segher@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, a.zummo@towertech.it, jg@freedesktop.org,
       Keith Packard <keithp@keithp.com>,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: [PATCH] RTC: Add mmap method to rtc character driver
Message-Id: <20060729234948.0768dbf4.froese@gmx.de>
In-Reply-To: <20060729204107.GA20890@gnuppy.monkey.org>
References: <21d7e9970607251304n5681bf44gc751c21fd79be99d@mail.gmail.com>
	<44C67E1A.7050105@zytor.com>
	<20060725204736.GK4608@hmsreliant.homelinux.net>
	<1153861094.1230.20.camel@localhost.localdomain>
	<44C6875F.4090300@zytor.com>
	<1153862087.1230.38.camel@localhost.localdomain>
	<44C68AA8.6080702@zytor.com>
	<1153863542.1230.41.camel@localhost.localdomain>
	<20060729042820.GA16133@gnuppy.monkey.org>
	<20060729125427.GA6669@localhost.localdomain>
	<20060729204107.GA20890@gnuppy.monkey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Huey (hui) wrote:
>
> > Its always been the case.  Its hardware can only support one timer (or at least
> > one timer period), and as such multiple users would interefere with each other.
> 
> Well, this points out a serious problem with doing an mmap extension to
> /dev/rtc. It would be better to have a page mapped by another device like
> /dev/jiffy_counter, or something like that rather than to overload the
> /dev/rtc with that functionality.

You mean something like this, /dev/itimer?

    http://marc.theaimsgroup.com/?m=115412412427996

Ciao, ET.
