Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262821AbTBORQN>; Sat, 15 Feb 2003 12:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262871AbTBORQM>; Sat, 15 Feb 2003 12:16:12 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:38928 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S262821AbTBORQM>; Sat, 15 Feb 2003 12:16:12 -0500
Date: Sat, 15 Feb 2003 18:26:06 +0100
From: Pavel Machek <pavel@suse.cz>
To: Cort Dougan <cort@fsmlabs.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Rusty Lynch <rusty@linux.co.intel.com>, Pavel Machek <pavel@ucw.cz>,
       lkml <linux-kernel@vger.kernel.org>, Patrick Mochel <mochel@osdl.org>,
       Dave Jones <davej@codemonkey.org.uk>,
       Daniel Pittman <daniel@rimspace.net>
Subject: Re: [PATCH][RFC] Proposal for a new watchdog interface using sysfs
Message-ID: <20030215172606.GC31778@atrey.karlin.mff.cuni.cz>
References: <1045106216.1089.16.camel@vmhack> <1045160506.1721.22.camel@vmhack> <20030213230408.GA121@elf.ucw.cz> <1045260726.1854.7.camel@irongate.swansea.linux.org.uk> <20030214213542.GH23589@atrey.karlin.mff.cuni.cz> <1045264651.13488.40.camel@vmhack> <1045274042.2961.4.camel@irongate.swansea.linux.org.uk> <20030215082707.GE13148@host109.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030215082707.GE13148@host109.fsmlabs.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> } > The watchdog infrastructure would just show what ever integer the driver
> } > provides via the watchdog_ops.get_temperature() function pointer, so it
> } > would be up to the driver developer to decide if the data is really
> } > Fahrenheit or whatever.
> } 
> } We do need to be sure they all agree about it however 8)
> 
> Just to make sure no-one is happy except physicists, I suggest Kelvin.  I
> also suggest we spell disk/disc as "disck".

Do I miss smiley around here?

Actually Kelvin is not such a bad idea, as deciKelvin is already used
by ACPI internally. It is converted to celsius before userspace sees
it, through.

									Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
