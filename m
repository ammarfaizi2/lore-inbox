Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315463AbSEYX4o>; Sat, 25 May 2002 19:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315472AbSEYX4n>; Sat, 25 May 2002 19:56:43 -0400
Received: from bs1.dnx.de ([213.252.143.130]:64938 "EHLO bs1.dnx.de")
	by vger.kernel.org with ESMTP id <S315463AbSEYX4l>;
	Sat, 25 May 2002 19:56:41 -0400
Date: Sun, 26 May 2002 01:56:09 +0200
From: Robert Schwebel <robert@schwebel.de>
To: Larry McVoy <lm@bitmover.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
Message-ID: <20020526015609.F598@schwebel.de>
In-Reply-To: <20020525150542.B17889@work.bitmover.com> <20020525221751.41FC311972@denx.denx.de> <20020525161034.L28795@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 25, 2002 at 04:10:34PM -0700, Larry McVoy wrote:
> Well, since you asked, how about you just go diff the include directories
> of the two source bases. That's a wonderful place to start. Anyone who
> spends 5 minutes in there will see that RTAI is derived from RTL.

Nobody has ever disputed that they have the same origin. And some of the
very obvious things are even so old that they have been there long before
RTL and RTAI came into existence, and some are like my "for" loop example. 

> Here's some more, go contrast rt_task_make_periodic() in each of the
> source trees, pretty clearly RTL. In fact, the scheduler code is really
> easy to see that it's a ripoff.

Here are the license headers of the schedulers: 

-----------8<----------
robert@callisto:~/embedded/rtai-24.1.9/upscheduler ! head -n 6 rtai_sched.c.ml
/*
COPYRIGHT (C) 2000  Paolo Mantegazza (mantegazza@aero.polimi.it)

This program is free software; you can redistribute it and/or modify
it under the terms of version 2 of the GNU General Public License as
published by the Free Software Foundation.
---------->8----------
robert@callisto:~/embedded/rtai-24.1.9/mupscheduler ! head -n 6
rtai_sched.c.ml
/*
COPYRIGHT (C) 2000  Paolo Mantegazza (mantegazza@aero.polimi.it)

This program is free software; you can redistribute it and/or modify
it under the terms of version 2 of the GNU General Public License as
published by the Free Software Foundation.
-----------8<----------
robert@callisto:~/embedded/rtai-24.1.9/smpscheduler ! head -n 6
rtai_sched.c.ml
/*
COPYRIGHT (C) 2000  Paolo Mantegazza (mantegazza@aero.polimi.it)

This program is free software; you can redistribute it and/or modify
it under the terms of version 2 of the GNU General Public License as
published by the Free Software Foundation.
---------->8----------

Where is your problem? I don't see anything else than pure GPL. 

It's the same with the patches, which don't have a license file, but as
patches for an original GPLed kernel they are surely GPL as well. 

> The COPYING file in the *current* RTAI release is illegal. You can't say
> "Well, there is some GPL stuff in here, but we're releasing under the
> LGPL"

Wrong. Some files in the distribution are derived from GPLed work, and they
are GPLed. Others are not, and they are LGPLed. 

Robert
-- 
 +--------------------------------------------------------+
 | Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de |
 | Pengutronix - Linux Solutions for Science and Industry |
 |   Braunschweiger Str. 79,  31134 Hildesheim, Germany   |
 |    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4    |
 +--------------------------------------------------------+
