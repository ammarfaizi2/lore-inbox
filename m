Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750832AbVIDDrY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbVIDDrY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 23:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbVIDDrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 23:47:24 -0400
Received: from S01060013104bd78e.vc.shawcable.net ([24.85.145.160]:36071 "EHLO
	r3000.fsmlabs.com") by vger.kernel.org with ESMTP id S1750832AbVIDDrY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 23:47:24 -0400
Date: Sat, 3 Sep 2005 20:46:21 -0700 (PDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Christopher Friesen <cfriesen@nortel.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: looking for help tracing oops
In-Reply-To: <431925C4.60509@nortel.com>
Message-ID: <Pine.LNX.4.63.0509032044430.3393@r3000.fsmlabs.com>
References: <431925C4.60509@nortel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Sep 2005, Christopher Friesen wrote:

> 
> I'm debugging a problem.  Unfortunately, I have a module loaded that taints
> the kernel.
> 
> Now that that's out of the way, if anyone is still willing to help, the oops
> is below, along with the disassembly of filp_close().  One thing I don't
> understand--the function makes calls to other functions including printk(),
> but I don't see those calls listed in the disassembly.

I like to use `objdump -d -r` this is mostly handy for modules since the 
external references aren't resolved yet.
