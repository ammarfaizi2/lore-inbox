Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271121AbUJUXpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271121AbUJUXpa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 19:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271115AbUJUXnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 19:43:12 -0400
Received: from smtp-out-02.utu.fi ([130.232.202.172]:45010 "EHLO
	smtp-out-02.utu.fi") by vger.kernel.org with ESMTP id S271099AbUJUXiU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 19:38:20 -0400
Date: Fri, 22 Oct 2004 02:38:12 +0300
From: Jan Knutar <jk-lkml@sci.fi>
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
In-reply-to: <4177E50F.9030702@sover.net>
To: Stephen Wille Padnos <spadnos@sover.net>
Cc: Timothy Miller <miller@techsource.com>, Jon Smirl <jonsmirl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <200410220238.13071.jk-lkml@sci.fi>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.6.2
References: <4176E08B.2050706@techsource.com> <4177DF15.8010007@techsource.com>
 <4177E50F.9030702@sover.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 21 October 2004 19:34, Stephen Wille Padnos wrote:

> I'm thinking more like microcode.  The functional blocks on the chip 
> would be capable of being "rewired" by the OS, depending on the 
> applications being run.  All of the functions would still operate out of 
> card-local memory.

Are you thinking something along the lines of an optimizing+profiling
host-CPU-software-renderer to FPGA-reprogrammed JIT accelerator? :)

The idea of reprogramming the hardware to toss out the line drawing and
other things that GTK and friends probably only present to X as pixmaps
anyway, and use that 'die space' for something else, is certainly appealing.

Of course, for a software -> hardware JITc, I think the budget required would
be a few magnitudes more than mentioned here earlier, and half a decade
of debugging or more ontop..
