Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261628AbUJaOVH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbUJaOVH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 09:21:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261629AbUJaOVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 09:21:07 -0500
Received: from pop.gmx.de ([213.165.64.20]:60868 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261628AbUJaOVC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 09:21:02 -0500
X-Authenticated: #4399952
Date: Sun, 31 Oct 2004 16:20:59 +0100
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>, Paul Davis <paul@linuxaudiosystems.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Message-ID: <20041031162059.1a3dd9eb@mango.fruits.de>
In-Reply-To: <20041031134016.GA24645@elte.hu>
References: <1099165925.1972.22.camel@krustophenia.net>
	<20041030221548.5e82fad5@mango.fruits.de>
	<1099167996.1434.4.camel@krustophenia.net>
	<20041030231358.6f1eeeac@mango.fruits.de>
	<1099171567.1424.9.camel@krustophenia.net>
	<20041030233849.498fbb0f@mango.fruits.de>
	<20041031120721.GA19450@elte.hu>
	<20041031124828.GA22008@elte.hu>
	<1099227269.1459.45.camel@krustophenia.net>
	<20041031131318.GA23437@elte.hu>
	<20041031134016.GA24645@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Oct 2004 14:40:16 +0100
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > > FWIW with V0.5.16 I had several hard lockups when running Florian's
> > > test app at 2048 Hz.
> > 
> > please check out V0.6.1, i made the semaphore code more robust and
> > more compatible. The V0.6 series could also fix the XFS and reiserfs
> > problems reported.
> 
> i've just uploaded V0.6.2 that fixes a console-unblanking-timer thinko. 
> This bug was present for quite some time, but this is the first time it 
> triggered on my testbox - might be more common on others.

V0.6.2 works pretty good. max jitter until now 21% [205us]. still fiddling
with the output formatting for rtc_wakeup.

flo
