Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261625AbUJaNkl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbUJaNkl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 08:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbUJaNkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 08:40:41 -0500
Received: from mx1.elte.hu ([157.181.1.137]:26035 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261625AbUJaNkJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 08:40:09 -0500
Date: Sun, 31 Oct 2004 14:40:16 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Message-ID: <20041031134016.GA24645@elte.hu>
References: <1099165925.1972.22.camel@krustophenia.net> <20041030221548.5e82fad5@mango.fruits.de> <1099167996.1434.4.camel@krustophenia.net> <20041030231358.6f1eeeac@mango.fruits.de> <1099171567.1424.9.camel@krustophenia.net> <20041030233849.498fbb0f@mango.fruits.de> <20041031120721.GA19450@elte.hu> <20041031124828.GA22008@elte.hu> <1099227269.1459.45.camel@krustophenia.net> <20041031131318.GA23437@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041031131318.GA23437@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> > FWIW with V0.5.16 I had several hard lockups when running Florian's
> > test app at 2048 Hz.
> 
> please check out V0.6.1, i made the semaphore code more robust and
> more compatible. The V0.6 series could also fix the XFS and reiserfs
> problems reported.

i've just uploaded V0.6.2 that fixes a console-unblanking-timer thinko. 
This bug was present for quite some time, but this is the first time it 
triggered on my testbox - might be more common on others.

	Ingo
