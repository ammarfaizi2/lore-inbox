Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264153AbUHSJGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264153AbUHSJGA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 05:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264260AbUHSJGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 05:06:00 -0400
Received: from mx1.elte.hu ([157.181.1.137]:48074 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S264153AbUHSJF7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 05:05:59 -0400
Date: Thu, 19 Aug 2004 11:07:20 +0200
From: Ingo Molnar <mingo@elte.hu>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: [patch] Latency Tracer, voluntary-preempt-2.6.8-rc4-O6
Message-ID: <20040819090720.GA8508@elte.hu>
References: <20040726083537.GA24948@elte.hu> <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu> <20040810132654.GA28915@elte.hu> <20040812235116.GA27838@elte.hu> <411DF776.6090102@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <411DF776.6090102@superbug.demon.co.uk>
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


* James Courtier-Dutton <James@superbug.demon.co.uk> wrote:

> Could the patch be adjusted to make the syslog and the
> /proc/latency_trace produce the same output?

to further unify the formats i've added the start/end entries to
latency_trace in -P4. Saving the stacktrace would be too much trouble
though.

	Ingo
