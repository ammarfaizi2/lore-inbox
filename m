Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261363AbVF1UZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261363AbVF1UZV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 16:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261495AbVF1UYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 16:24:39 -0400
Received: from mx2.elte.hu ([157.181.151.9]:212 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261414AbVF1UW7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 16:22:59 -0400
Date: Tue, 28 Jun 2005 22:21:47 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-24
Message-ID: <20050628202147.GA30862@elte.hu>
References: <200506281927.43959.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506281927.43959.annabellesgarden@yahoo.de>
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

> Hi Ingo,
> 
> suffering (not really ;-) double-rated IO-APIC level-interrupts I 
> found the following patch as a solution:

thanks. I've applied your patch but also tweaked this area a bit, to 
make the i8259A PIC work too. I've uploaded the -31 patch with these 
fixes included.

	Ingo
