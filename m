Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261403AbVFMHKG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbVFMHKG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 03:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbVFMHKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 03:10:05 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:27377 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261403AbVFMHKB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 03:10:01 -0400
Subject: Re: [PATCH] local_irq_disable removal
From: Sven-Thorsten Dietrich <sdietrich@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Esben Nielsen <simlo@phys.au.dk>, Daniel Walker <dwalker@mvista.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050611200352.GA1477@elte.hu>
References: <20050611191654.GA22301@elte.hu>
	 <Pine.OSF.4.05.10506112123260.2917-100000@da410.phys.au.dk>
	 <20050611200352.GA1477@elte.hu>
Content-Type: text/plain
Date: Mon, 13 Jun 2005 00:08:47 -0700
Message-Id: <1118646527.5729.60.camel@sdietrich-xp.vilm.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-06-11 at 22:03 +0200, Ingo Molnar wrote:
> * Esben Nielsen <simlo@phys.au.dk> wrote:
> 
> > > the jury is still out on the accuracy of those numbers. The test had 
> > > RT_DEADLOCK_DETECT (and other -RT debugging features) turned on, which 
> > > mostly work with interrupts disabled. The other question is how were 
> > > interrupt response times measured.
> > > 
> > You would accept a patch where I made this stuff optional?
> 
> I'm not sure why. The soft-flag based local_irq_disable() should in fact 
> be a tiny bit faster than the cli based approach, on a fair number of 
> CPUs. But it should definitely not be slower in any measurable way.
> 

Is there any such SMP concept as a local_preempt_disable()  ?



