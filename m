Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263326AbUJ2Nrn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263326AbUJ2Nrn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 09:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263329AbUJ2Nrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 09:47:42 -0400
Received: from mx1.elte.hu ([157.181.1.137]:47564 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263326AbUJ2Nra (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 09:47:30 -0400
Date: Fri, 29 Oct 2004 15:48:20 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Message-ID: <20041029134820.GA21746@elte.hu>
References: <1099008264.4199.4.camel@krustophenia.net> <200410290057.i9T0v5I8011561@localhost.localdomain> <20041029080247.GC30400@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041029080247.GC30400@elte.hu>
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


> i don't know what you mean by "channel" information in this context.

after reading some more code i believe the concept is called 'stream' in
ALSA speak. How many streams did Rui's test utilize? (nine?)

if multiple streams were used, then can the handling of one stream delay
another stream? How are streams prioritized, and are they queued in a
FIFO or in a LIFO manner? (Also, are such 'streams' directly mapped to
some hardware concept on the audio card ('channel' or 'voice'?) or am i
confusing things?)

	Ingo
