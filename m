Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261265AbUKCBMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbUKCBMg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 20:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261285AbUKCBMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 20:12:35 -0500
Received: from mx2.elte.hu ([157.181.151.9]:15263 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261265AbUKCBMV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 20:12:21 -0500
Date: Wed, 3 Nov 2004 02:12:54 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Lee Revell <rlrevell@joe-job.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.6.8
Message-ID: <20041103011254.GA16884@elte.hu>
References: <1099227269.1459.45.camel@krustophenia.net> <1099324040.3337.32.camel@thomas> <20041102150634.GA24871@elte.hu> <200411030009.53343.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411030009.53343.annabellesgarden@yahoo.de>
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


* Karsten Wiese <annabellesgarden@yahoo.de> wrote:

> Am Dienstag 02 November 2004 16:06 schrieb Ingo Molnar:
> > i've uploaded a fixed kernel (-V0.6.8) to:
> >
> >   http://redhat.com/~mingo/realtime-preempt/
> >
> > (this kernel also has the module-put-unlock-kernel fix that should solve
> > the other warning reported by Thomas and Bill.)
> >
> > 	Ingo
> 
> Fixed a deadlock in snd-es1968 with attached patch.

thanks. This is a (SMP-only) bug in the vanilla driver too, correct?

	Ingo
