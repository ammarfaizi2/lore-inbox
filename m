Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264492AbTLLGYn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 01:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264493AbTLLGYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 01:24:43 -0500
Received: from dyn-213-36-179-191.ppp.tiscali.fr ([213.36.179.191]:40710 "EHLO
	nsbm.kicks-ass.org") by vger.kernel.org with ESMTP id S264492AbTLLGYm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 01:24:42 -0500
Date: Fri, 12 Dec 2003 07:24:23 +0100
From: Witukind <witukind@nsbm.kicks-ass.org>
To: gene.heskett@verizon.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.23] cursor dissapears in framebuffer console after
 switching back from X
Message-Id: <20031212072423.35b7ff7c.witukind@nsbm.kicks-ass.org>
In-Reply-To: <200312111859.55655.gene.heskett@verizon.net>
References: <200312081536.26022.andrew@walrond.org>
	<20031210054253.GA1982@kroah.com>
	<20031211213235.7a41e3f8.witukind@nsbm.kicks-ass.org>
	<200312111859.55655.gene.heskett@verizon.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Dec 2003 18:59:55 -0500
Gene Heskett <gene.heskett@verizon.net> wrote:

> On Thursday 11 December 2003 15:32, Witukind wrote:
> >This is 100% reproduceable on my machine. When I boot Linux the
> > cursor can be seen. then I start XFree86 and when I switch back to
> > the framebuffer console with ALT-CTRL-F(x) it is not there anymore.
> > I am using tdfx.o with a Voodoo 3 2000 PCI, XFree86 4.3.0
> > (Slackware 9.1). If more information is needed I'll be glad to
> > provide it.
> 
> This was asked by me a week or 2 back,and the answer is that in your 
> .config that built your kernel, you probably have both a framebuffer 
> for your card enabled, and a generic vesa framebuffer.  Turn off the 
> generic framebuffer and make/reinstall your kernel.

I don't have a VESA framebuffer enabled. Only tdfx.o.

> -- 
> Cheers, Gene
> AMD K6-III@500mhz 320M
> Athlon1600XP@1400mhz  512M
> 99.22% setiathome rank, not too shabby for a WV hillbilly
> Yahoo.com attornies please note, additions to this message
> by Gene Heskett are:
> Copyright 2003 by Maurice Eugene Heskett, all rights reserved.
> 
> 


-- 
Jabber: heimdal@jabber.org
