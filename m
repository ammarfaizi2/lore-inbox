Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266879AbUGVShC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266879AbUGVShC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 14:37:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266883AbUGVShC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 14:37:02 -0400
Received: from mx1.elte.hu ([157.181.1.137]:56284 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266879AbUGVSg7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 14:36:59 -0400
Date: Thu, 22 Jul 2004 20:38:13 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Rudo Thomas <rudo@matfyz.cz>
Subject: Re: voluntary-preempt I0: sluggish feel
Message-ID: <20040722183813.GA1719@elte.hu>
References: <20040721210051.GA2744@yoda.timesys> <20040721211826.GB30871@elte.hu> <20040721223749.GA2863@yoda.timesys> <20040722100657.GA14909@elte.hu> <20040722160055.GA4837@ss1000.ms.mff.cuni.cz> <20040722161941.GA23972@elte.hu> <20040722172428.GA5632@ss1000.ms.mff.cuni.cz> <20040722175457.GA5855@ss1000.ms.mff.cuni.cz> <20040722180142.GC30059@elte.hu> <20040722183218.GA5907@ss1000.ms.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040722183218.GA5907@ss1000.ms.mff.cuni.cz>
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


* Rudo Thomas <rudo@matfyz.cz> wrote:

> I would like to ask whether I should do this. Or is it just the other
> way round - renicing the ksoftirqd thread "kills" the effect of
> deferred processing?

it is perfectly fine to renice ksoftirqd. Are you running xmms under RT
priority? If yes then it will always preempt ksoftirqd.

	Ingo
