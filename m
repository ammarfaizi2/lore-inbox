Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262543AbULPCdt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262543AbULPCdt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 21:33:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262546AbULPCdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 21:33:49 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:8687 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262543AbULPCdr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 21:33:47 -0500
Subject: Re: USB making time drift [was Re: dynamic-hz]
From: john stultz <johnstul@us.ibm.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Andrea Arcangeli <andrea@suse.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20041216005814.GA6285@elf.ucw.cz>
References: <Pine.LNX.4.61.0412121817130.16940@montezuma.fsmlabs.com>
	 <20041213112853.GS16322@dualathlon.random>
	 <20041213124313.GB29426@atrey.karlin.mff.cuni.cz>
	 <20041213125844.GY16322@dualathlon.random>
	 <20041213191249.GB1052@elf.ucw.cz>
	 <20041214023651.GT16322@dualathlon.random>
	 <20041214095939.GC1063@elf.ucw.cz>
	 <20041214152558.GB16322@dualathlon.random>
	 <20041214220239.GA19221@elf.ucw.cz>
	 <20041214231649.GR16322@dualathlon.random>
	 <20041216005814.GA6285@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1103164425.20791.22.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 15 Dec 2004 18:33:46 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-15 at 16:58, Pavel Machek wrote:
> Hi!
> 
> > > How much drift do you see?
> > 
> > huge drift, minutes per hour or similar.
> 
> Okay, for your amusement, here's the evil
> "do-few-msec-interrupt-latency" program.

Ohhh! Awesome. I love it!

I'm playing with it and I'm seeing occasional jumps forward in time
(about an hour and 10mins, and then back). I'll start seeing if there
isn't anything we can do a quick fix for. Also I'll use this to test the
timeofday rework code I'm doing.

Very nice!

thanks!
-john

