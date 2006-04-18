Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932251AbWDRGcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbWDRGcd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 02:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbWDRGcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 02:32:33 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:41615 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932251AbWDRGcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 02:32:32 -0400
Subject: Re: [-rt] time-related problems with CPU frequency scaling
From: Lee Revell <rlrevell@joe-job.com>
To: woho@woho.de
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <200604180811.13110.woho@woho.de>
References: <200604162041.10844.woho@woho.de>
	 <1145313317.16138.90.camel@mindpipe>  <200604180811.13110.woho@woho.de>
Content-Type: text/plain
Date: Tue, 18 Apr 2006 02:32:27 -0400
Message-Id: <1145341947.23853.3.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-18 at 08:11 +0200, Wolfgang Hoffmann wrote:
> So I misunderstood preempt_max_latency. I thought it to be absolute
> time, but it actually is codepath cycles, translated to microseconds
> using the current CPU frequency. Thanks for clarifying.  

They are one and the same.  At 800Mhz the same code patch causes twice
the latency.

Lee

