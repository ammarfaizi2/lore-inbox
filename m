Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266417AbSKLLRX>; Tue, 12 Nov 2002 06:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266478AbSKLLRW>; Tue, 12 Nov 2002 06:17:22 -0500
Received: from [64.215.178.122] ([64.215.178.122]:11907 "HELO umaro.net")
	by vger.kernel.org with SMTP id <S266417AbSKLLRW>;
	Tue, 12 Nov 2002 06:17:22 -0500
Date: Tue, 12 Nov 2002 04:24:08 -0700
From: Rando Christensen <rando@babblica.net>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: spyro@f2s.com, viro@math.psu.edu, xavier.bestel@free.fr,
       linux-kernel@vger.kernel.org
Subject: Re: devfs
Message-Id: <20021112042408.02d2e3e3.rando@babblica.net>
In-Reply-To: <20021112104650.GA322@suse.de>
References: <1037094221.16831.21.camel@bip>
	<Pine.GSO.4.21.0211120445570.29617-100000@steklov.math.psu.edu>
	<20021112102535.1f94f50d.spyro@f2s.com>
	<20021112104650.GA322@suse.de>
Organization: Babblica
X-Mailer: Sylpheed version 0.8.5claws (GTK+ 1.2.10; )
digiw00tX: v1.0
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, 12 Nov 2002 10:46:50 +0000: Dave Jones (Dave Jones
<davej@codemonkey.org.uk>):

> On Tue, Nov 12, 2002 at 10:25:35AM +0000, Ian Molton wrote:
>  > > 	Again, WE ARE IN FEATURE FREEZE.
>  > And since when did feature freeze affect, as the guy said, *purely*
>  > userspace implementations?
>  Since it would a *feature* to move it out of kernel space.
>  To reiterate : _FEATURE_ _FREEZE_. Nothing[1] new[2]
>  should be going into mainline at this point.

Well, it does make sense to start planning out what might be done to
devfs in the /next/ devel kernel, then. If one were so inclined, they
could have a stable enough system for it ready for inclusion next time
around, depending on who they get to test it.

Clean up the devfs API for now, and start working on what might
eventually replace it- Whether that's devfs2 or a purely userspace
implementation or something new and wacky is up to whoever writes it.

Rather than saying "Devfs sucks, and we can't do anything about it other
than fix it's more minor problems because we're in feature freeze", we
should be saying "devfs sucks; we're a little late for feature freeze,
so let's clean up what we can and work on something much better for the
next time around."

Devfs as it is now is a nice idea, to me. It's an extremely organized
/dev which is also an accurate portrayal of what's available to use on a
particular machine. I'd hate to see it just ripped out entirely, and
while they've never affected me, I've heard of many issues with it. I'd
like to hear what ideas people may have /for/ a future replacement.

-- 
< There is a light that shines on the frontier >
<   And maybe someday, We're gonna be there.   >
<    Rando Christensen / rando@babblica.net    >
