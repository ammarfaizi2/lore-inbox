Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262046AbUDJPD1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 11:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbUDJPD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 11:03:27 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:45522 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S262046AbUDJPDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 11:03:23 -0400
Date: Sat, 10 Apr 2004 08:03:17 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Marcus Hartig <m.f.h@web.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-mjb1
Message-ID: <49410000.1081609397@[10.10.2.4]>
In-Reply-To: <4077A003.2030001@web.de>
References: <4077A003.2030001@web.de>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> tested with latencytest-0.5.2. Sched stats turned off in the kernel.
> Look at "2.6.5 latencytest +aa5 +mm3 as/cfq scheduler" to compare.

The main thing that looks different is that loops per run is lower.
What does that mean?
 
> ---------- 2.6.5-mjb1 AS scheduler ----------
> x11.log:
> cpu_hz = 2.08792e+09
> cpu_load=0.800000  loops per run = 537513
> total latency = 1.953125 ms
> cpu latency = 1.562500 ms
> max diff = 3.03868 ms (overrun 0)
> within 1ms = 33088, factor = 99.9788%
> within 2ms = 33095, factor = 100%
> deviation = 0.0196589
> 
> proc.log:
> cpu_hz = 2.08792e+09
> cpu_load=0.800000  loops per run = 537547
> total latency = 1.953125 ms
> cpu latency = 1.562500 ms
> max diff = 3.05196 ms (overrun 0)
> within 1ms = 15385, factor = 99.9805%
> within 2ms = 15388, factor = 100%
> deviation = 0.0205876
> 
> diskwrite.log:
> cpu_hz = 2.08792e+09
> cpu_load=0.800000  loops per run = 537500
> total latency = 1.953125 ms
> cpu latency = 1.562500 ms
> max diff = 4.40418 ms (overrun 1)
> within 1ms = 10989, factor = 99.9273%
> within 2ms = 10996, factor = 99.9909%
> deviation = 0.0545299
> 
> diskcopy.log:
> cpu_hz = 2.08792e+09
> cpu_load=0.800000  loops per run = 537552
> total latency = 1.953125 ms
> cpu latency = 1.562500 ms
> max diff = 5.08319 ms (overrun 3)
> within 1ms = 27949, factor = 99.9321%
> within 2ms = 27965, factor = 99.9893%
> deviation = 0.0385951
> 
> diskread.log:
> cpu_hz = 2.08792e+09
> cpu_load=0.800000  loops per run = 537564
> total latency = 1.953125 ms
> cpu latency = 1.562500 ms
> max diff = 3.15495 ms (overrun 0)
> within 1ms = 28029, factor = 99.9715%
> within 2ms = 28037, factor = 100%
> deviation = 0.0249104
> 
> Best regards,
> 
> Marcus
> 
> 
> 


