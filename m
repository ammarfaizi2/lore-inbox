Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264186AbTEOTUN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 15:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264188AbTEOTUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 15:20:13 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:17422 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264186AbTEOTUJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 15:20:09 -0400
Date: Thu, 15 May 2003 15:26:36 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
       akpm@digeo.com
Subject: Re: 2.5 kernels fail to start second CPU
In-Reply-To: <20030515184445.GQ8978@holomorphy.com>
Message-ID: <Pine.LNX.3.96.1030515151950.30986A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 May 2003, William Lee Irwin III wrote:

> On Thu, May 15, 2003 at 02:21:10PM -0400, Bill Davidsen wrote:
> > While you are (somewhat) on the topic of starting processors, I want to
> > benchmark and application on a dual Xeon system. I want to try these
> > configurations, preferably without opening the box, since it's in
> > another time zone.
> >   2 cpu w/ ht		normal boot
> >   2 cpu w/o ht		noht
> >   1 cpu w/o ht		nosmp noht
> >   1 cpu w/ ht		???
> > It looks as if maxcpus=2 counts physical units? I can't try it until Monday.
> 
> What on earth are you getting on about?

I want to benchmark the box using one or two CPUs, with and without
hyperthreading, as listed in the configurations above. To do this I want
to use the boot options also listed in the original post above. I can
reboot the box remotely but I can't physically remove a cpu to get the
single cpu+ht config, so I'm looking for boot line options to provide
that.

> ia32 is utter crap with respect to power management, virtualization,
> and generalized firmware.
> 
> If you don't have remote power management, buy it in whatever form
> possible.

I'm not trying to manage the power, it's not a laptop, I'm trying to run
benchmarks as noted in the first sentence of my question. I don't see
how you got from there to virtualization from how to start (or not) cpus.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

