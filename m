Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261345AbUKBTpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbUKBTpd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 14:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbUKBTpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 14:45:32 -0500
Received: from mx2.elte.hu ([157.181.151.9]:63720 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261794AbUKBTh4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 14:37:56 -0500
Date: Tue, 2 Nov 2004 20:38:59 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Lee Revell <rlrevell@joe-job.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       LKML <linux-kernel@vger.kernel.org>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.6.8
Message-ID: <20041102193859.GB3053@elte.hu>
References: <OF7B340ED3.3EE1B145-ON86256F40.005675F6-86256F40.005676E0@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF7B340ED3.3EE1B145-ON86256F40.005675F6-86256F40.005676E0@raytheon.com>
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


* Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:

> (cat/3504/CPU#0): new 5286 us maximum-latency wakeup.
> (cat/3504/CPU#0): new 71828 us maximum-latency wakeup.

ok - wakeup-latency timing is completely unreliable on SMP and will
produce bogus results.

	Ingo
