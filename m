Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261379AbVBGJWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261379AbVBGJWK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 04:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbVBGJWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 04:22:09 -0500
Received: from mx2.elte.hu ([157.181.151.9]:47576 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261379AbVBGJWH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 04:22:07 -0500
Date: Mon, 7 Feb 2005 10:21:28 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
Message-ID: <20050207092128.GA19189@elte.hu>
References: <20050204100347.GA13186@elte.hu> <200502060419.j164JjCP027883@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502060419.j164JjCP027883@turing-police.cc.vt.edu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9, BAYES_00 -4.90,
	UPPERCASE_25_50 0.00
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> wrote:

> Building with:
> 
> # CONFIG_PREEMPT_NONE is not set
> # CONFIG_PREEMPT_VOLUNTARY is not set
> CONFIG_PREEMPT_DESKTOP=y
> # CONFIG_PREEMPT_RT is not set
> 
>   CC      kernel/sched.o
> kernel/sched.c:314:1: warning: "_finish_arch_switch" redefined
> kernel/sched.c:306:1: warning: this is the location of the previous definition

ok, i fixed this in the -03 patch.

	Ingo
