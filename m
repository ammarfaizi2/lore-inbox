Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261497AbUKFXGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbUKFXGM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 18:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261499AbUKFXGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 18:06:12 -0500
Received: from dragon.woods.net ([208.186.177.35]:17319 "EHLO a.smtp.woods.net")
	by vger.kernel.org with ESMTP id S261497AbUKFXGD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 18:06:03 -0500
Date: Sat, 6 Nov 2004 16:06:03 -0700 (MST)
From: "Christopher E. Brown" <cbrown@woods.net>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Daniel Egger <degger@fhm.edu>,
       Linux Mailing List Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8 and 2.6.9 Dual Opteron glitches
In-Reply-To: <200411022253.51040.rjw@sisk.pl>
Message-ID: <Pine.LNX.4.44.0411061601080.24349-100000@dragon.woods.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Nov 2004, Rafael J. Wysocki wrote:

> Hi,
>
> On Tuesday 02 of November 2004 14:59, Daniel Egger wrote:
> > Hija,
> >
> > I've a few glitches with my brandnew dual Opteron System which I'd
> > like to share with you. First of all, all those problems seem to
> > be there with 2.6.8.1 and 2.6.9 but since this seemed to be the
> > case I moved on with 2.6.9 and hadn't investigated any further
> > on 2.6.8.1 so some of the issues might only apply to 2.6.9.
>
> I'm using 2.6.10-rc1-mm2 currently, on a dual Opteron w/ Tyan Thunder K8W.
>
> > 1) 32 bit kernel HPET calibration hang: If the kernel is compiled
> >     with HPET support, the kernel will hang on boot while
> >     calibrating the timer. The problem goes away if HPET support is
> >     not compiled in. I've no idea what information to provide to help
> >     debug this.
>
> I can't confirm this.  I've just set CONFIG_HPET and friends (except for
> CONFIG_HPET_RTC_IRQ) and nothing wrong happens.


Running 2.6.9 32bit here on a Tyan Thunder K8W with BIOS 2.02.

Is a new system, started with BIOS 1.02, built the kernel with CONFIG_HPET
and CONFIG_HPET_RTC_IRQ enabled.  No issues, but no messages about HPET
during boot.

Updated to current BIOS (that among other things adds an enable/disable
HPET option) and I have the same issues, system hang on HPET calabration,
with an opps several minutes later.  Disable the HPET in BIOS and the
system boots just fine (but no HPET).



