Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262136AbVFHHv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262136AbVFHHv6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 03:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262137AbVFHHv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 03:51:58 -0400
Received: from mx2.elte.hu ([157.181.151.9]:52116 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262136AbVFHHv4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 03:51:56 -0400
Date: Wed, 8 Jun 2005 09:48:47 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org, Esben Nielsen <simlo@phys.au.dk>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.47-29
Message-ID: <20050608074847.GB13452@elte.hu>
References: <20050607194119.GA11185@elte.hu> <1118176290.18629.29.camel@dhcp153.mvista.com> <20050608072855.GA8900@elte.hu> <20050608074254.GA13452@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050608074254.GA13452@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > > There is a local_irq_enable missing someplace in UP ..
> > > 
> > > BUG: scheduling with irqs disabled: khelper/0x00000000/5
> > > caller is __down_mutex+0x276/0x440
> > >  [<c03a88d6>] __down_mutex+0x276/0x440 (4)
> > 
> > .config please.
> 
> ok, managed to reproduce.

ok, fixed it and uploaded the -47-30 patch with the fix.

	Ingo
