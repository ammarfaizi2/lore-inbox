Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267184AbUBMTE4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 14:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267186AbUBMTE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 14:04:56 -0500
Received: from fed1mtao03.cox.net ([68.6.19.242]:59071 "EHLO
	fed1mtao03.cox.net") by vger.kernel.org with ESMTP id S267184AbUBMTEz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 14:04:55 -0500
Date: Fri, 13 Feb 2004 12:04:53 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Chris Wright <chrisw@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][0/6] A different KGDB stub
Message-ID: <20040213190453.GA1564@smtp.west.cox.net>
References: <20040212000237.GA19676@smtp.west.cox.net> <20040211162756.12bb19e8.akpm@osdl.org> <20040212165259.GP19676@smtp.west.cox.net> <20040213105838.F14506@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040213105838.F14506@build.pdx.osdl.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 13, 2004 at 10:58:38AM -0800, Chris Wright wrote:

> * Tom Rini (trini@kernel.crashing.org) wrote:
> > On Wed, Feb 11, 2004 at 04:27:56PM -0800, Andrew Morton wrote:
> > > CONFIG_KGDB_SYSRQ		(Just turn it on by default?)
> > > 
> > > I have never used (or, as far as I know, needed) any of the above.
> > 
> > I think CONFIG_KGDB_SYSRQ can die since with the 8250 and enet drivers
> > you can try and connect at any point, which will schedule a breakpoint
> > and you can get in like that.  As for NO_KGDB_CPUS, I'm not entirely
> > certain why this can't go away and there'd be an array of NR_CPUS in
> > size.
> 
> Using kgdboe I've had numerous times where it gets a bit wedged and
> only sysrq-g could get the breakpoint.

Alright.   We can just always have it on SYSRQ+KGDB then.

-- 
Tom Rini
http://gate.crashing.org/~trini/
