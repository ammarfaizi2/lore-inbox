Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261506AbUKCKOl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbUKCKOl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 05:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbUKCKOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 05:14:41 -0500
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:19319 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261506AbUKCKOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 05:14:39 -0500
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.6.8
Date: Wed, 3 Nov 2004 11:15:49 +0100
User-Agent: KMail/1.6.2
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Lee Revell <rlrevell@joe-job.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>
References: <1099227269.1459.45.camel@krustophenia.net> <200411030009.53343.annabellesgarden@yahoo.de> <20041103011254.GA16884@elte.hu>
In-Reply-To: <20041103011254.GA16884@elte.hu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200411031115.49486.annabellesgarden@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch 03 November 2004 02:12 schrieb Ingo Molnar:
> 
> * Karsten Wiese <annabellesgarden@yahoo.de> wrote:
> 
> > Am Dienstag 02 November 2004 16:06 schrieb Ingo Molnar:
> > > i've uploaded a fixed kernel (-V0.6.8) to:
> > >
> > >   http://redhat.com/~mingo/realtime-preempt/
> > >
> > > (this kernel also has the module-put-unlock-kernel fix that should solve
> > > the other warning reported by Thomas and Bill.)
> > >
> > > 	Ingo
> > 
> > Fixed a deadlock in snd-es1968 with attached patch.
> 
> thanks. This is a (SMP-only) bug in the vanilla driver too, correct?

Yes. I sent the patch to alsa-devel too.

Karsten
