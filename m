Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263708AbUJ3LrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263708AbUJ3LrF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 07:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263709AbUJ3LrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 07:47:04 -0400
Received: from mx2.elte.hu ([157.181.151.9]:51369 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263708AbUJ3LpJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 07:45:09 -0400
Date: Sat, 30 Oct 2004 13:46:15 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Bill Huey <bhuey@lnxw.com>
Cc: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.5
Message-ID: <20041030114615.GA28331@elte.hu>
References: <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu> <417F7D7D.5090205@stud.feec.vutbr.cz> <20041027134822.GA7980@elte.hu> <417FD9F2.8060002@stud.feec.vutbr.cz> <20041028115719.GA9563@elte.hu> <20041030000234.GA20986@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041030000234.GA20986@nietzsche.lynx.com>
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

> On Thu, Oct 28, 2004 at 01:57:19PM +0200, Ingo Molnar wrote: > 
> > * Michal Schmidt <xschmi00@stud.feec.vutbr.cz> wrote:
> > 
> > > > i've uploaded -V0.4.1 with a fix that could fix this networking
> > > > deadlock. Does it work any better?
> > > 
> > > Unfortunately, no. It's only slightly different:
> > 
> > ok. I've uploaded -RT-V0.5 which includes a different approach to
> > solving these netfilter related deadlocks. It can be downloaded from the 
> > usual place:
> 
> This is in -V5.14

thanks - excellent trace - i hopefully fixed this in -V0.5.16, freshly
uploaded. This also made me notice an upstream buglet.

	Ingo
