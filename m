Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264425AbTLLAAG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 19:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264426AbTLLAAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 19:00:05 -0500
Received: from out001pub.verizon.net ([206.46.170.140]:4270 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S264425AbTLLAAB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 19:00:01 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
To: Witukind <witukind@nsbm.kicks-ass.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.23] cursor dissapears in framebuffer console after switching back from X
Date: Thu, 11 Dec 2003 18:59:55 -0500
User-Agent: KMail/1.5.1
References: <200312081536.26022.andrew@walrond.org> <20031210054253.GA1982@kroah.com> <20031211213235.7a41e3f8.witukind@nsbm.kicks-ass.org>
In-Reply-To: <20031211213235.7a41e3f8.witukind@nsbm.kicks-ass.org>
Organization: None that appears to be detectable by casual observers
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312111859.55655.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [151.205.60.44] at Thu, 11 Dec 2003 17:59:58 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 December 2003 15:32, Witukind wrote:
>This is 100% reproduceable on my machine. When I boot Linux the
> cursor can be seen. then I start XFree86 and when I switch back to
> the framebuffer console with ALT-CTRL-F(x) it is not there anymore.
> I am using tdfx.o with a Voodoo 3 2000 PCI, XFree86 4.3.0
> (Slackware 9.1). If more information is needed I'll be glad to
> provide it.

This was asked by me a week or 2 back,and the answer is that in your 
.config that built your kernel, you probably have both a framebuffer 
for your card enabled, and a generic vesa framebuffer.  Turn off the 
generic framebuffer and make/reinstall your kernel.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

