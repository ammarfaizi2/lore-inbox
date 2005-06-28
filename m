Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261522AbVF1Uda@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbVF1Uda (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 16:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbVF1Uc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 16:32:59 -0400
Received: from mx1.elte.hu ([157.181.1.137]:63694 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261456AbVF1Uba (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 16:31:30 -0400
Date: Tue, 28 Jun 2005 22:30:17 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-24
Message-ID: <20050628203017.GA371@elte.hu>
References: <200506281927.43959.annabellesgarden@yahoo.de> <20050628202147.GA30862@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050628202147.GA30862@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Karsten Wiese <annabellesgarden@yahoo.de> wrote:
> 
> > Hi Ingo,
> > 
> > suffering (not really ;-) double-rated IO-APIC level-interrupts I 
> > found the following patch as a solution:
> 
> thanks. I've applied your patch but also tweaked this area a bit, to 
> make the i8259A PIC work too. I've uploaded the -31 patch with these 
> fixes included.

make that -50-32, had a leftover hack in io_apic.c.

	Ingo
