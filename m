Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292298AbSBBPND>; Sat, 2 Feb 2002 10:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292299AbSBBPMy>; Sat, 2 Feb 2002 10:12:54 -0500
Received: from h24-71-103-168.ss.shawcable.net ([24.71.103.168]:62214 "HELO
	discworld.dyndns.org") by vger.kernel.org with SMTP
	id <S292298AbSBBPMg>; Sat, 2 Feb 2002 10:12:36 -0500
X-Authentication: 6b0a6c24d87cd2d88db5ba834064fe46d7a226f9
Date: Sat, 2 Feb 2002 09:12:09 -0600
From: Charles Cazabon <linux-kernel@discworld.dyndns.org>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: Larry McVoy <lm@work.bitmover.com>
Subject: Re: Bitkeeper change granularity (was Re: A modest proposal -- We need a patch penguin)
Message-ID: <20020202091209.A7679@twoflower.internal.do>
In-Reply-To: <lm@bitmover.com> <200202011111.g11BBVf0009257@tigger.cs.uni-dortmund.de> <20020201083855.C8664@work.bitmover.com> <20020202001058.UXDU10685.femail14.sdc1.sfba.home.com@there> <20020201191928.D2122@twoflower.internal.do> <20020201215040.F27081@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020201215040.F27081@work.bitmover.com>; from lm@bitmover.com on Fri, Feb 01, 2002 at 09:50:40PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy <lm@bitmover.com> wrote:
> 
>     bk clone main temporary-fork
> 
> >   [hack hack hack]
> >   bk commit
> >   [hack hack hack]
> 
>     bk fix -c
> 
> >   [hack hack hack]
> >   bk commit 
> >   [hack hack hack]
> >   bk commit
> 
>     bk push
> 
> All exists, works as described, no changes necessary.

But will the changes which were committed and then reverted from the
temporary tree show up in the main tree after the "push"?  There should be no
evidence that they ever took place, so as not to clutter Linus' tree with
changes a developer made and had no intention of sending to Linus.

Charles
-- 
-----------------------------------------------------------------------
Charles Cazabon                            <linux@discworld.dyndns.org>
GPL'ed software available at:  http://www.qcc.sk.ca/~charlesc/software/
-----------------------------------------------------------------------
