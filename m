Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262860AbUDALIT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 06:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262841AbUDALIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 06:08:19 -0500
Received: from ns.suse.de ([195.135.220.2]:8086 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262860AbUDALIR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 06:08:17 -0500
Date: Thu, 1 Apr 2004 13:07:12 +0200
From: Stefan Seyfried <seife@gmane0305.slipkontur.de>
To: David Weinehall <tao@debian.org>
Cc: vcjones@NetworkingUnlimited.com, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.X versus APM Suspend on IBM X23
Message-ID: <20040401110712.GB4688@suse.de>
References: <20040331222723.GA6240@NetworkingUnlimited.com.suse.lists.linux.kernel> <20040331224527.GU6041@khan.acc.umu.se.suse.lists.linux.kernel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040331224527.GU6041@khan.acc.umu.se.suse.lists.linux.kernel>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2004 at 10:52:45PM +0000, David Weinehall wrote:
> On Wed, Mar 31, 2004 at 05:27:23PM -0500, Vincent C Jones wrote:
> 
> > Using APM with ACPI and CPUfreq disabled: Suspend works, but only if
> > running on battery. When running on AC, I get what sound like PCMCIA
> > failure beeps (brief high low), the display goes dark, but the system
> > keeps on running and hitting any key brings be right back (at least

> > FWIW: there were no problems with suspend under any 2.4 kernels. 
> 
> I can confirm the exact same behaviour on a Thinkpad A20m.

Do you have a pcmcia card inserted? IBM Thinkpads (at least older models,
the TP600 for sure) don't suspend, if (AC && PCMCIA_CARD_INSERTED). If
only AC or only CARD_INSERTED, then they suspend.

-- 
Stefan Seyfried

"Any ideas, John?"
"Well, surrounding thems out."
