Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbTK0Xbo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 18:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbTK0Xbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 18:31:44 -0500
Received: from adsl-216-102-91-59.dsl.snfc21.pacbell.net ([216.102.91.59]:50865
	"EHLO nasledov.com") by vger.kernel.org with ESMTP id S261670AbTK0Xbn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 18:31:43 -0500
Date: Thu, 27 Nov 2003 15:33:58 -0800
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: APM Suspend Problem
Message-ID: <20031127233357.GA12525@nasledov.com>
References: <20031127062057.GA31974@nasledov.com> <1069921674.6691.202.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1069921674.6691.202.camel@gaston>
User-Agent: Mutt/1.5.4i
From: Misha Nasledov <misha@nasledov.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I figured as much, but my laptop still fails to suspend as it did in -test2
and the 2.4 kernel series.

On Fri, Nov 28, 2003 at 09:58:21AM +1100, Benjamin Herrenschmidt wrote:
> > hdc: start_power_step(step: 0)
> > hdc: completing PM request, suspend
> > hda: start_power_step(step: 0)
> > hda: start_power_step(step: 1)
> > hda: complete_power_step(step: 1, stat: 50, err: 0)
> > hda: completing PM request, suspend
> > hda: Wakeup request inited, waiting for !BSY...
> > hda: start_power_step(step: 1000)
> > blk: queue c138fa00, I/O limit 4095Mb (mask 0xffffffff)
> > hda: completing PM request, resume
> > hdc: Wakeup request inited, waiting for !BSY...
> > hdc: start_power_step(step: 1000)
> > hdc: completing PM request, resume
> 
> Those messages are harmless, they just show normal operations
> of the IDE suspend code. I beleive it's probably time to disable
> the debug code in there ;)

-- 
Misha Nasledov
misha@nasledov.com
http://nasledov.com/misha/
