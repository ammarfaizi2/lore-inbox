Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261535AbUKBMrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbUKBMrN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 07:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261533AbUKBMrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 07:47:13 -0500
Received: from mx2.elte.hu ([157.181.151.9]:18336 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261638AbUKBMp7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 07:45:59 -0500
Date: Tue, 2 Nov 2004 13:46:48 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] remove interactive credit
Message-ID: <20041102124648.GF15290@elte.hu>
References: <418707CD.1080903@kolivas.org> <20041102123746.GB15290@elte.hu> <41878057.9000302@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41878057.9000302@kolivas.org>
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


* Con Kolivas <kernel@kolivas.org> wrote:

> >>remove interactive credit
> >
> >we could try this in -mm, but it obviously needs alot of testing first. 
> >Do you have any particular workload in mind where the fairness win due
> >to this revert would/should be significant?
> 
> Since I created this variable in the first place I can say with quite
> some certainty that the size of the advantage is miniscule. Whereas
> clearly the design introduces special case mistreatment of only one
> type of task. It's an addition to the interactivity code I've often
> looked at and regretted doing.

yeah, i know, it was the only piece of code from your earlier -Oint
scheduler-fixup series i almost didnt ack. But now it's in and testing
needs to cross at least one stable kernel boundary before it can be
taken out again. (unless a patch is an obvious or important fix.)

	Ingo
