Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266905AbUJRRLa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266905AbUJRRLa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 13:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266820AbUJRRLa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 13:11:30 -0400
Received: from mx2.elte.hu ([157.181.151.9]:62913 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266905AbUJRRLY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 13:11:24 -0400
Date: Mon, 18 Oct 2004 19:12:13 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Adam Heath <doogie@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U5
Message-ID: <20041018171213.GA1055@elte.hu>
References: <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <Pine.LNX.4.58.0410181207000.1223@gradall.private.brainfood.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410181207000.1223@gradall.private.brainfood.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Adam Heath <doogie@debian.org> wrote:

> >  - debug feature: implemented /proc/sys/kernel/trace_verbose runtime
> >    flag (default:0), which enables a much more verbose printout in
> >    /proc/latency_trace.  This trace format can be useful in e.g.
> >    debugging timestamp weirdnesses.
> 
> With all these proc values, what do you recommend they should be set
> to?

just the default values - same for the .config options. Once the feature
gets more stable the latency measurements can begin again - for them the
/proc values are important.

	Ingo
