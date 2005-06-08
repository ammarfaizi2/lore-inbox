Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261328AbVFHPzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbVFHPzU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 11:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbVFHPxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 11:53:49 -0400
Received: from mx1.elte.hu ([157.181.1.137]:54509 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261328AbVFHPvW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 11:51:22 -0400
Date: Wed, 8 Jun 2005 17:50:49 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: kus Kusche Klaus <kus@keba.com>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
Message-ID: <20050608155049.GA7160@elte.hu>
References: <AAD6DA242BC63C488511C611BD51F367323235@MAILIT.keba.co.at> <Pine.LNX.4.10.10506080847590.28001-100000@godzilla.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10506080847590.28001-100000@godzilla.mvista.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> > > i have released the -V0.7.48-00 Real-Time Preemption patch, 
> > [snip]
> > > be affected that much (besides possible build issues). Non-x86 arches
> > > wont build. Some regressions might happen, so take care..
> > 
> > What arches are likely to work in the near future?
> > I've seen that "Kconfig.RT" is sourced for i386, x86_64, ppc, 
> > and mips, but not for arm.
> > 
> > arm is one of the platforms we are interested in, any chances?
> 
> I can make it work, but Ingo isn't accepting non-generic IRQ arches .. 
> So it's pretty much on hold until someone bring ARM into the generic 
> IRQ world.

Thomas and me already did that - i think Thomas could send a patch for 
review?

	Ingo
