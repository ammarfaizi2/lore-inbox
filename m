Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292837AbSCOQEb>; Fri, 15 Mar 2002 11:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292840AbSCOQEV>; Fri, 15 Mar 2002 11:04:21 -0500
Received: from bitmover.com ([192.132.92.2]:46286 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S292837AbSCOQEJ>;
	Fri, 15 Mar 2002 11:04:09 -0500
Date: Fri, 15 Mar 2002 08:04:08 -0800
From: Larry McVoy <lm@bitmover.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Ben Greear <greearb@candelatech.com>, Larry McVoy <lm@bitmover.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4 and BitKeeper
Message-ID: <20020315080408.D11940@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Ben Greear <greearb@candelatech.com>, Larry McVoy <lm@bitmover.com>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3C90E994.2030702@candelatech.com> <Pine.LNX.4.21.0203140141450.4725-100000@freak.distro.conectiva> <3C904437.7080603@candelatech.com> <20020313224255.F9010@work.bitmover.com> <3C90E994.2030702@candelatech.com> <2865.1016190641@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <2865.1016190641@redhat.com>; from dwmw2@infradead.org on Fri, Mar 15, 2002 at 11:10:41AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2002 at 11:10:41AM +0000, David Woodhouse wrote:
> greearb@candelatech.com said:
> >  I did a clone with this.  However, I see no files, only directories.
> > The files do seem to be in the SCCS directories, but I don't know how
> > to make them appear in their normal place. 
> 
> Type 'make config'. Make is clever enough to get the Makefile from SCCS for 
> you. Add the missing dependencies to the Makefile so that make will fetch 
> stuff like scripts/Configure before trying to run it, etc. 

Has anyone done this and made it work?  It would save a lot of disk space
and performance if someone were to so.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
