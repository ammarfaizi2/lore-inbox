Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282480AbRK0SQi>; Tue, 27 Nov 2001 13:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282470AbRK0SQa>; Tue, 27 Nov 2001 13:16:30 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:64529 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S282453AbRK0SQN>; Tue, 27 Nov 2001 13:16:13 -0500
Date: Tue, 27 Nov 2001 19:16:04 +0100
From: Pavel Machek <pavel@suse.cz>
To: James Simmons <jsimmons@transvirtual.com>
Cc: mj@ucw.cz, kernel list <linux-kernel@vger.kernel.org>,
        ACPI mailing list <acpi@phobos.fachschaften.tu-muenchen.de>
Subject: Re: Restoring videomode on return from S3 sleep
Message-ID: <20011127191604.A3152@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20011126210621.A2039@elf.ucw.cz> <Pine.LNX.4.10.10111271003070.21131-100000@www.transvirtual.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10111271003070.21131-100000@www.transvirtual.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I'll need to restore video mode on returning from acpi sleep...
> > 
> > Unfortunately, video selection code is not part of kernel, it is
> > 16-bit code. acpi_wakeup.S, otoh, *is* part of kernel :-(. 
> 
> Is this on the console and if it is I assum you are uing vgacon. It could 
> be the S# card has a broken implemenation. This wouldn't be the first.
> Their has been a patch sometime for vesafb to work properly with S3 cards.
> 
> S3 framebuffer anyone? I remember their has been scathered work on this
> but I never seen anything come to light for this.

Oh. Sorry. By S3 I mean ACPI S3 state. ACPI S3 == suspend to RAM.

Basically what I need is to restore video mode after returning from
ACPI S3 sleep state, so that vesafb works properly.
								Pavel
-- 
Casualities in World Trade Center: 6453 dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
