Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263093AbUGXXa7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263093AbUGXXa7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 19:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263100AbUGXXa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 19:30:59 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:14820 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S263093AbUGXXa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 19:30:57 -0400
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel
	Preemption Patch
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-audio-dev@music.columbia.edu, arjanv@redhat.com,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1090709351.1194.18.camel@mindpipe>
References: <20040712174639.38c7cf48.akpm@osdl.org>
	 <1089687168.10777.126.camel@mindpipe>
	 <20040712205917.47d1d58b.akpm@osdl.org>
	 <1089705440.20381.14.camel@mindpipe> <20040719104837.GA9459@elte.hu>
	 <1090301906.22521.16.camel@mindpipe> <20040720061227.GC27118@elte.hu>
	 <20040720121905.GG1651@suse.de> <1090642050.2871.6.camel@mindpipe>
	 <1090647952.1006.7.camel@mindpipe>  <20040724064304.GA32269@elte.hu>
	 <1090709351.1194.18.camel@mindpipe>
Content-Type: text/plain
Message-Id: <1090711856.851.1.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 24 Jul 2004 19:30:57 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-07-24 at 18:49, Lee Revell wrote:
> On Sat, 2004-07-24 at 02:43, Ingo Molnar wrote:
> > 
> > ok, i'll put in a tunable for the sg size.
> > 
> I therefore propose 256KB as a good default

Scratch this, I got a 380 usec spike with 256KB, enough to trigger jackd
to reatart.  128KB so far has only gone as high as 185 usecs.

Lee

