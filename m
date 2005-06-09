Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262359AbVFIL5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262359AbVFIL5c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 07:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262361AbVFIL5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 07:57:32 -0400
Received: from mx2.elte.hu ([157.181.151.9]:3494 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262359AbVFIL5X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 07:57:23 -0400
Date: Thu, 9 Jun 2005 13:56:21 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org, sdietrich@mvista.com
Subject: Re: [PATCH] local_irq_disable removal
Message-ID: <20050609115621.GB12744@elte.hu>
References: <1118214519.4759.17.camel@dhcp153.mvista.com> <20050608112119.GA28703@elte.hu> <1118262818.30686.8.camel@dhcp153.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118262818.30686.8.camel@dhcp153.mvista.com>
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

> Excellent .. I have one fix related to preempt_schedule_irq() below. 
> There needs to be an ifdef , cause when PREEPMT_RT is off you would 
> end up with interrupts enabled when exiting preempt_schedule_irq() ..

thanks, i've added this to the -48-03 patch.

	Ingo
