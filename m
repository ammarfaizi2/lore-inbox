Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261907AbUEQQip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbUEQQip (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 12:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261900AbUEQQin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 12:38:43 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:24510 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261907AbUEQQiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 12:38:19 -0400
Date: Mon, 17 May 2004 09:38:13 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Robert Picco <Robert.Picco@hp.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm3
Message-ID: <20040517163813.GH6763@smtp.west.cox.net>
References: <20040516025514.3fe93f0c.akpm@osdl.org> <20040517161432.GG6763@smtp.west.cox.net> <40A8E8A1.2090404@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40A8E8A1.2090404@hp.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2004 at 12:30:25PM -0400, Robert Picco wrote:

> Tom Rini wrote:
> 
> >On Sun, May 16, 2004 at 02:55:14AM -0700, Andrew Morton wrote:
> >
> > 
> >
> >>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.6/2.6.6-mm3/
> >>
> >>- A few VM changes, getting things synced up better with Andrea's work.
> >>
> >>- A new kgdb stub, for ia64 (what happened to the grand unified kgdb
> >> project?)
> >>   
> >>
> >
> >No one asked the ia64 folks who did that work "Hey, have you looked at
> >the grand unified kgdb project on kgdb.sf.net ?" would be my guess.
> >
> >Having said that, if you're willing to go with a slightly late
> >initalizing (I saw part of the early_param work get dropped again I
> >think, so I'm gonna guess you don't wanna deal with that again yet) KGDB
> >for i386 and PPC32, I can whip something up vs 2.6.6 in a day or so.
> 
> I did the ia64 port and started with Andrew's 2.6.4-mm2 i386 sources.  
> I'm assuming the long term strategy is to move to a unified kgdb being 
> done on sourceforge?  If so, I'll take a look at this.

My long term strategy is to get everyone using the version on
sourceforge that splits out the common portions of the stub from the
arch-specific portions.  If you could go ahead and get ia64 working on
this as well I'd appreciate it.

Right now it's still vs 2.6.5, but I'm going to try and fix that today
or tomorrow to be vs 2.6.6.

-- 
Tom Rini
http://gate.crashing.org/~trini/
