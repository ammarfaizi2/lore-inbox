Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261274AbUJ3Tgu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbUJ3Tgu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 15:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbUJ3Tgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 15:36:50 -0400
Received: from mx1.elte.hu ([157.181.1.137]:53461 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261286AbUJ3Tgs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 15:36:48 -0400
Date: Sat, 30 Oct 2004 21:37:06 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Florian Schmidt <mista.tapas@gmx.net>
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
Message-ID: <20041030193706.GB29747@elte.hu>
References: <20041029204220.GA6727@elte.hu> <20041029233117.6d29c383@mango.fruits.de> <20041029212545.GA13199@elte.hu> <1099086166.1468.4.camel@krustophenia.net> <20041029214602.GA15605@elte.hu> <1099091566.1461.8.camel@krustophenia.net> <20041030115808.GA29692@elte.hu> <1099158570.1972.5.camel@krustophenia.net> <20041030191725.GA29747@elte.hu> <20041030214738.1918ea1d@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041030214738.1918ea1d@mango.fruits.de>
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


* Florian Schmidt <mista.tapas@gmx.net> wrote:

> Hi, in the meantime i also booted into P9 again and the results differ
> dramatically. Much better in P9. Anyways, i reuploaded the tarball.
> The program tries to detect missed irq's now and counts the total
> number of irq's delivered by /dev/rtc. Since the program does not
> recover from missed irq's the "statistical" data for these runs is
> useless [except for the knowledge of the fact that one or more irq was
> missed :)]

just to make sure - you are running this on an UP system, correct?

	Ingo
