Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315607AbSEZDk0>; Sat, 25 May 2002 23:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315619AbSEZDkZ>; Sat, 25 May 2002 23:40:25 -0400
Received: from bitmover.com ([192.132.92.2]:13781 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S315607AbSEZDkY>;
	Sat, 25 May 2002 23:40:24 -0400
Date: Sat, 25 May 2002 20:40:26 -0700
From: Larry McVoy <lm@bitmover.com>
To: Robert Schwebel <robert@schwebel.de>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
Message-ID: <20020525204026.D19792@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Robert Schwebel <robert@schwebel.de>, Larry McVoy <lm@bitmover.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020525150542.B17889@work.bitmover.com> <20020525221751.41FC311972@denx.denx.de> <20020525161034.L28795@work.bitmover.com> <20020526015609.F598@schwebel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 26, 2002 at 01:56:09AM +0200, Robert Schwebel wrote:
> On Sat, May 25, 2002 at 04:10:34PM -0700, Larry McVoy wrote:
> > Well, since you asked, how about you just go diff the include directories
> > of the two source bases. That's a wonderful place to start. Anyone who
> > spends 5 minutes in there will see that RTAI is derived from RTL.
> 
> Nobody has ever disputed that they have the same origin. 

Actually, people have, and in this thread.

> robert@callisto:~/embedded/rtai-24.1.9/upscheduler ! head -n 6 rtai_sched.c.ml
> /*
> COPYRIGHT (C) 2000  Paolo Mantegazza (mantegazza@aero.polimi.it)
> 
> This program is free software; you can redistribute it and/or modify
> it under the terms of version 2 of the GNU General Public License as
> published by the Free Software Foundation.
> 
> Where is your problem? I don't see anything else than pure GPL. 

My first problem is that this is a partial sampling of the source base.
My second problem is that Paolo Mantegazza isn't the original author of
that file.

> > The COPYING file in the *current* RTAI release is illegal. You can't say
> > "Well, there is some GPL stuff in here, but we're releasing under the
> > LGPL"
> 
> Wrong. Some files in the distribution are derived from GPLed work, and they
> are GPLed. Others are not, and they are LGPLed. 

Well, I find it misleading.  It makes it sound like you have rights to that
code that you don't and it makes it sound like it is LGPLed.  How would you
feel if someone included your GPLed work in a package and put the LGPL in
the COPYING file?  And slapped their copyrights on your work?
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
