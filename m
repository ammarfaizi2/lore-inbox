Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261927AbULKJ5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261927AbULKJ5W (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 04:57:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbULKJ5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 04:57:22 -0500
Received: from mx1.elte.hu ([157.181.1.137]:47080 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261927AbULKJ5U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 04:57:20 -0500
Date: Sat, 11 Dec 2004 10:57:02 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, LKML <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>,
       Mark Johnson <Mark_H_Johnson@RAYTHEON.COM>,
       "K.R. Foley" <kr@cybsft.com>, Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>, emann@mrv.com,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-12
Message-ID: <20041211095701.GA23813@elte.hu>
References: <32788.192.168.1.5.1102541960.squirrel@192.168.1.5> <1102543904.25841.356.camel@localhost.localdomain> <20041209093211.GC14516@elte.hu> <20041209131317.GA31573@elte.hu> <1102602829.25841.393.camel@localhost.localdomain> <1102619992.3882.9.camel@localhost.localdomain> <20041209221021.GF14194@elte.hu> <1102659089.3236.11.camel@localhost.localdomain> <20041210111105.GB6855@elte.hu> <1102731973.3228.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102731973.3228.8.camel@localhost.localdomain>
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


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Anyways, what is happening is that the io_apic code is mapping irqs to
> vectors, and your code didn't account for it. So here's my patch.

ah .. thanks, great debugging!

	Ingo
