Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262660AbVGHNqh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262660AbVGHNqh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 09:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262663AbVGHNqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 09:46:35 -0400
Received: from mx1.elte.hu ([157.181.1.137]:30398 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262660AbVGHNos (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 09:44:48 -0400
Date: Fri, 8 Jul 2005 15:43:46 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Vitaly Wool <vwool@ru.mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 'sleeping function called from invalid context' bug when mounting an IDE device
Message-ID: <20050708134346.GA4890@elte.hu>
References: <20050708162846.54de783d.vwool@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050708162846.54de783d.vwool@ru.mvista.com>
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


* Vitaly Wool <vwool@ru.mvista.com> wrote:

> Hi Ingo,
> 
> I've come across the following problem during the debugging of IDE 
> driver for Philips PNX0105 ARM9 platform in RT mode 
> (CONFIG_PREEMPT_RT). When I mount/unmount a device, the following 
> error is printed out to a terminal:

could you send me the full backtrace?

> So, the problem is in the generic IDE code, namely, in ide_intr() 
> taking ide_lock.

which version did you try, and does this happen with the latest patch 
too?

	Ingo
