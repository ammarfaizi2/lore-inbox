Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267618AbUJRTtz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267618AbUJRTtz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 15:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267702AbUJRTrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 15:47:10 -0400
Received: from mx1.elte.hu ([157.181.1.137]:60885 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267649AbUJRTqc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 15:46:32 -0400
Date: Mon, 18 Oct 2004 21:46:32 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Bill Huey <bhuey@lnxw.com>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U5
Message-ID: <20041018194632.GB9550@elte.hu>
References: <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041018193251.GA15313@nietzsche.lynx.com> <20041018193603.GB8159@elte.hu> <20041018194040.GC15313@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041018194040.GC15313@nietzsche.lynx.com>
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


* Bill Huey <bhuey@lnxw.com> wrote:

> On Mon, Oct 18, 2004 at 09:36:03PM +0200, Ingo Molnar wrote:
> > * Bill Huey <bhuey@lnxw.com> wrote:
> > > 
> > >   CC      arch/i386/kernel/traps.o
> > > arch/i386/kernel/traps.c: In function `do_debug':
> > > arch/i386/kernel/traps.c:786: error: `sysenter_past_esp' undeclared (first use in this function)
> > > arch/i386/kernel/traps.c:786: error: (Each undeclared identifier is reported only once
> > > arch/i386/kernel/traps.c:786: error: for each function it appears in.)
> > > make[1]: *** [arch/i386/kernel/traps.o] Error 1
> > > make: *** [arch/i386/kernel] Error 2
> > 
> > i guess this might be an -mm1 breakage if CONFIG_KGDB enabled - does it
> > happen with vanilla -mm1 too?
> 
> yep, should I wait for -mm2 ?

since 2.6.9's release is imminent there will unlikely be an -rc4-mm2,
2.6.9-mm1 should be the next one.

	Ingo
