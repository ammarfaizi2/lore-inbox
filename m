Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262483AbVFVIvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262483AbVFVIvX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 04:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262930AbVFVIrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 04:47:39 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:24774 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S262901AbVFVIo2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 04:44:28 -0400
Date: Wed, 22 Jun 2005 10:44:22 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-V0.7.49-00
In-Reply-To: <20050622074937.GE16508@elte.hu>
Message-Id: <Pine.OSF.4.05.10506221010100.15909-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jun 2005, Ingo Molnar wrote:

> 
> * Esben Nielsen <simlo@phys.au.dk> wrote:
> 
> > Yep, just as I pressed sent before I saw the following:
> 
> ok, i'll have to look at the latency trace of this.
> 
> > threshold violated: 28.0% (273usec)
> 
> btw., are you sure this happened with latency timing/tracing disabled?  
> (the printks will disturb the rtc_wakeup test).
> 
Yes.
But I have been running the same load with latence timing on and have not
seen traces of more than ~50us.

I do have problems with calibration of the clock in both rtc_wakeup and
realfeel2 due to frequency scaling, but it looks like if I have a cpu-hog
running it settles itself on the 697MHz as it should. But could this
frequency scaling lead to bad readings? If it for some reason scales down
the clock during a test it ought to give lower clock counts than the real
ones, not higher...

> 	Ingo
> 

Esben


