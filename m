Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292857AbSCOQSC>; Fri, 15 Mar 2002 11:18:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292858AbSCOQRv>; Fri, 15 Mar 2002 11:17:51 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:55006 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S292857AbSCOQRc>; Fri, 15 Mar 2002 11:17:32 -0500
Date: Fri, 15 Mar 2002 17:17:13 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Larry McVoy <lm@work.bitmover.com>, David Woodhouse <dwmw2@infradead.org>,
        Ben Greear <greearb@candelatech.com>, Larry McVoy <lm@bitmover.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4 and BitKeeper
Message-ID: <20020315161712.GC3662@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Larry McVoy <lm@work.bitmover.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Ben Greear <greearb@candelatech.com>, Larry McVoy <lm@bitmover.com>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3C90E994.2030702@candelatech.com> <Pine.LNX.4.21.0203140141450.4725-100000@freak.distro.conectiva> <3C904437.7080603@candelatech.com> <20020313224255.F9010@work.bitmover.com> <3C90E994.2030702@candelatech.com> <2865.1016190641@redhat.com> <20020315080408.D11940@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020315080408.D11940@work.bitmover.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2002 at 08:04:08AM -0800, Larry McVoy wrote:

> > Type 'make config'. Make is clever enough to get the Makefile from SCCS for 
> > you. Add the missing dependencies to the Makefile so that make will fetch 
> > stuff like scripts/Configure before trying to run it, etc. 
> 
> Has anyone done this and made it work?  It would save a lot of disk space
> and performance if someone were to so.

IIRC, make *config should be doable, but make dep should require quite
a bit of work (scripts/mkdep.c).

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
