Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261279AbVGGK0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbVGGK0j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 06:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbVGGK0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 06:26:39 -0400
Received: from mx1.elte.hu ([157.181.1.137]:12952 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261279AbVGGK0S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 06:26:18 -0400
Date: Thu, 7 Jul 2005 12:25:17 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Cc: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Message-ID: <20050707102517.GA22422@elte.hu>
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <200507062200.08924.s0348365@sms.ed.ac.uk> <20050706210249.GA2017@elte.hu> <200507062315.07536.s0348365@sms.ed.ac.uk> <1120691329.6766.62.camel@cmn37.stanford.edu> <42CCC5FD.6070101@stud.feec.vutbr.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42CCC5FD.6070101@stud.feec.vutbr.cz>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9, BAYES_00 -4.90,
	UPPERCASE_25_50 0.00
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Michal Schmidt <xschmi00@stud.feec.vutbr.cz> wrote:

> Fernando Lopez-Lezcano wrote:
> >I see the same thing. "CONFIG_PRINTK_IGNORE_LOGLEVEL is not set" but
> >still printk ignores the loglevel (I commented out the #ifdef in
> >kernel/printk.c to make the spurious messages go away). 
> 
> The condition is reversed.
> The '#ifdef CONFIG_PRINTK_IGNORE_LOGLEVEL' should be
> '#ifndef CONFIG_PRINTK_IGNORE_LOGLEVEL'.

indeed - fixed.

	Ingo
