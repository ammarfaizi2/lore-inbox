Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163453AbWLGVpr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163453AbWLGVpr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 16:45:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163451AbWLGVpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 16:45:47 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:41938 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1163449AbWLGVpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 16:45:46 -0500
Date: Thu, 7 Dec 2006 22:44:34 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
       Mike Galbraith <efault@gmx.de>, Clark Williams <williams@redhat.com>,
       Sergei Shtylyov <sshtylyov@ru.mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       Giandomenico De Tullio <ghisha@email.it>
Subject: Re: v2.6.19-rt6, yum/rpm
Message-ID: <20061207214434.GA29357@elte.hu>
References: <20061205171114.GA25926@elte.hu> <1165524358.9244.33.camel@cmn3.stanford.edu> <20061207205819.GA21953@elte.hu> <1165526445.27217.59.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1165526445.27217.59.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Arjan van de Ven <arjan@infradead.org> wrote:

> > i think it's the UP vs. SMP difference. We are chasing some SMP 
> > latencies right now that trigger on boxes that have deeper C sleep 
> > states. idle=poll seems to work around those problems.
> 
> well C-states do cause latencies... as advertized in the 
> /proc/acpi/processor/CPU0/power file.

no, this is a plain logic bug somewhere, not a hardware latency. 
Sometimes the latency is in the seconds range, etc.

	Ingo
