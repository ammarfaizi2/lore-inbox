Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263332AbUJ2N4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263332AbUJ2N4n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 09:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263343AbUJ2N4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 09:56:41 -0400
Received: from mx2.elte.hu ([157.181.151.9]:27030 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263323AbUJ2Nza (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 09:55:30 -0400
Date: Fri, 29 Oct 2004 15:55:30 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Message-ID: <20041029135530.GA22463@elte.hu>
References: <20041029113652.GC32204@elte.hu> <200410291335.i9TDZvjZ006279@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410291335.i9TDZvjZ006279@localhost.localdomain>
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


* Paul Davis <paul@linuxaudiosystems.com> wrote:

> 		if (poll (driver->pfd, nfds, driver->poll_timeout) < 0) {

in Rui's test (9 fluidsynth instances running), what would be the value
of nfds - 9 or 1? I.e. is the '9 streams' abstraction provided by jackd,
and you map it to a single alsa driver fd over which you poll, or is
each stream a separate fd?

	Ingo
