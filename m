Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265344AbTLSG6B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 01:58:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265345AbTLSG6B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 01:58:01 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:35750 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265344AbTLSG5u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 01:57:50 -0500
Date: Fri, 19 Dec 2003 07:57:47 +0100
From: Jens Axboe <axboe@suse.de>
To: Hans Reiser <reiser@namesys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.0
Message-ID: <20031219065747.GT2069@suse.de>
References: <Pine.LNX.4.58.0312171951030.5789@home.osdl.org> <20031217211516.2c578bab.akpm@osdl.org> <200312181112.43745.ismail.donmez@boun.edu.tr> <006201c3c54c$2bb00c50$0e25fe0a@southpark.ae.poznan.pl> <brsju1$ckg$1@gatekeeper.tmr.com> <3FE20077.80509@namesys.com> <20031218194203.GM2069@suse.de> <3FE2738A.4060004@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FE2738A.4060004@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 19 2003, Hans Reiser wrote:
> Jens Axboe wrote:
> 
> >
> >
> >I hope you don't expect to actually have something that's worthy of
> >being merged into 2.6.x in a months time?
> >
> > 
> >
> Have you looked at the stability of the typical experimental feature?  
> If we used that as a guide, we'd have sent it in 3 months ago.....;-)

I don't think that's true. Plus, a file system (even more true in the
case of reiser4) is a huge complex beast. A driver is a lot less
complex.

> We will have something we think is appropriate for inclusion as an 
> experimental feature very soon now.  Because our test scripts have 
> become much more sophisticated, it means more when we say we cannot 
> crash it, and it will go from experimental to stable faster than V3 
> did.  I won't predict how fast.

Well v3 was merged too soon to, but at that time there was a big motive
to do just that - get a journalled fs in the kernel. With v4 that just
isn't the case.

I don't doubt you have great testing scripts, but nothing beats real
life testing.

-- 
Jens Axboe

