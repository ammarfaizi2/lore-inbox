Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268485AbTBNV0i>; Fri, 14 Feb 2003 16:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268483AbTBNVZ4>; Fri, 14 Feb 2003 16:25:56 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:56073 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S268482AbTBNVZt>; Fri, 14 Feb 2003 16:25:49 -0500
Date: Fri, 14 Feb 2003 22:35:42 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Rusty Lynch <rusty@linux.co.intel.com>,
       lkml <linux-kernel@vger.kernel.org>, Patrick Mochel <mochel@osdl.org>,
       Dave Jones <davej@codemonkey.org.uk>,
       Daniel Pittman <daniel@rimspace.net>
Subject: Re: [PATCH][RFC] Proposal for a new watchdog interface using sysfs
Message-ID: <20030214213542.GH23589@atrey.karlin.mff.cuni.cz>
References: <1045106216.1089.16.camel@vmhack> <1045160506.1721.22.camel@vmhack> <20030213230408.GA121@elf.ucw.cz> <1045260726.1854.7.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1045260726.1854.7.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > temperature (RO)
> > >   - show: prints temperature in degrees farenheit
> > 
> > Please, use degrees celsius to keep it consistent with ACPI and
> > lm-sensors.
> 
> The ioctl interface is farenheit and has been since before Linux 2.0
> That may not have been smart but we are stuck with it there at
> least.

Oops, that's bad.

But I believe we should make it celsius in /sys, even if it means
conversion somewhere.

								Pavel

-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
