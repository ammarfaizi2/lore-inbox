Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936083AbWK1UMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936083AbWK1UMP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 15:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936093AbWK1UMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 15:12:14 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:18373 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S936083AbWK1UMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 15:12:14 -0500
Subject: Re: 2.6.19-rc6-rt8: alsa xruns
From: Lee Revell <rlrevell@joe-job.com>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: Ingo Molnar <mingo@elte.hu>,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>
In-Reply-To: <1164743931.15887.34.camel@cmn3.stanford.edu>
References: <1164743931.15887.34.camel@cmn3.stanford.edu>
Content-Type: text/plain
Date: Tue, 28 Nov 2006 15:12:36 -0500
Message-Id: <1164744757.1701.58.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-11-28 at 11:58 -0800, Fernando Lopez-Lezcano wrote:
> Hi, I'm trying out the latest -rt patch and getting alsa xruns when
> using jackd and jack clients. This is a sample from the output of
> qjackctl / jackd (jack 0.102.25, qjackctl 0.2.21):

Any improvement if you disable high res timers?

Also, the latency tracer does not work on dual core AMD machines due to
the TSC drift.  Might as well disable it.

Lee


