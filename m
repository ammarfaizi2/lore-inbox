Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261213AbVBCU4U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbVBCU4U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 15:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbVBCU4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 15:56:06 -0500
Received: from mx1.elte.hu ([157.181.1.137]:57284 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261153AbVBCUzt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 15:55:49 -0500
Date: Thu, 3 Feb 2005 21:55:41 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Eugeny S. Mints" <emints@ru.mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc2-V0.7.37-02
Message-ID: <20050203205541.GA26144@elte.hu>
References: <20041203205807.GA25578@elte.hu> <20041207132927.GA4846@elte.hu> <20041207141123.GA12025@elte.hu> <20041214132834.GA32390@elte.hu> <20050104064013.GA19528@nietzsche.lynx.com> <20050104094518.GA13868@elte.hu> <20050115133454.GA8748@elte.hu> <20050122122915.GA7098@elte.hu> <20050201201402.GA31930@elte.hu> <42028F4D.2040708@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42028F4D.2040708@ru.mvista.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Eugeny S. Mints <emints@ru.mvista.com> wrote:

> Ingo Molnar wrote:
> >i have released the -V0.7.37-02 Real-Time Preemption patch, which can be
> >downloaded from the usual place:
> >
> >  http://redhat.com/~mingo/realtime-preempt/
> Minor fix for deadlock tracer: "...acquired at XXX"  may print  caller's 
> of an up() eip instead of eip of caller of a down() in case a lock was 
> initally contended before deadlock is detected.
> 
> Seems actual for 37-03 as well. patch is attached.

ah - this might explain some of the weirder deadlock traces. Thanks and
applied.

	Ingo
