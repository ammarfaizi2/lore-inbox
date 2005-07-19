Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261984AbVGSOCr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbVGSOCr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 10:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbVGSOA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 10:00:57 -0400
Received: from mx2.elte.hu ([157.181.151.9]:16030 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261362AbVGSN6L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 09:58:11 -0400
Date: Tue, 19 Jul 2005 15:57:15 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: "K.R. Foley" <kr@cybsft.com>, Chuck Harding <charding@llnl.gov>,
       William Weston <weston@sysex.net>,
       Linux Kernel Discussion List <linux-kernel@vger.kernel.org>,
       Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Message-ID: <20050719135715.GA20664@elte.hu>
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <20050716171537.GB16235@elte.hu> <200507171407.20373.annabellesgarden@yahoo.de> <200507191314.24093.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507191314.24093.annabellesgarden@yahoo.de>
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


* Karsten Wiese <annabellesgarden@yahoo.de> wrote:

> > Found another error:
> > the ioapic cache isn't fully initialized in -51-31's ioapic_cache_init().
> > <snip>
> > 
>
> and another: some NULL-pointers are used in -51-31 instead of 
> ioapic_data[0]. Please apply attached patch on top of -51-31. It 
> includes yesterday's fix.

thanks, i've applied it and released -32.

	Ingo
