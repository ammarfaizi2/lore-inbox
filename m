Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267170AbUBMS6t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 13:58:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267181AbUBMS6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 13:58:49 -0500
Received: from fw.osdl.org ([65.172.181.6]:47241 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267170AbUBMS6j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 13:58:39 -0500
Date: Fri, 13 Feb 2004 10:58:38 -0800
From: Chris Wright <chrisw@osdl.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][0/6] A different KGDB stub
Message-ID: <20040213105838.F14506@build.pdx.osdl.net>
References: <20040212000237.GA19676@smtp.west.cox.net> <20040211162756.12bb19e8.akpm@osdl.org> <20040212165259.GP19676@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040212165259.GP19676@smtp.west.cox.net>; from trini@kernel.crashing.org on Thu, Feb 12, 2004 at 09:52:59AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Tom Rini (trini@kernel.crashing.org) wrote:
> On Wed, Feb 11, 2004 at 04:27:56PM -0800, Andrew Morton wrote:
> > CONFIG_KGDB_SYSRQ		(Just turn it on by default?)
> > 
> > I have never used (or, as far as I know, needed) any of the above.
> 
> I think CONFIG_KGDB_SYSRQ can die since with the 8250 and enet drivers
> you can try and connect at any point, which will schedule a breakpoint
> and you can get in like that.  As for NO_KGDB_CPUS, I'm not entirely
> certain why this can't go away and there'd be an array of NR_CPUS in
> size.

Using kgdboe I've had numerous times where it gets a bit wedged and
only sysrq-g could get the breakpoint.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
