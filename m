Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261839AbVFGMGe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261839AbVFGMGe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 08:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbVFGMGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 08:06:34 -0400
Received: from mx1.elte.hu ([157.181.1.137]:17128 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261839AbVFGMGa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 08:06:30 -0400
Date: Tue, 7 Jun 2005 14:05:51 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.47-20
Message-ID: <20050607120551.GA26481@elte.hu>
References: <20050607110409.GA14613@elte.hu> <42A58A3A.4080002@stud.feec.vutbr.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42A58A3A.4080002@stud.feec.vutbr.cz>
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


* Michal Schmidt <xschmi00@stud.feec.vutbr.cz> wrote:

> Ingo Molnar wrote:
> >i have released the -V0.7.47-20 Real-Time Preemption patch, which can be 
> >downloaded from the usual place:
> 
> It doesn't build with CONFIG_RT_DEADLOCK_DETECT:
>    CC      arch/i386/kernel/cpu/mtrr/main.o
> arch/i386/kernel/cpu/mtrr/main.c:52: error: syntax error at '#' token
> arch/i386/kernel/cpu/mtrr/main.c:52: error: `lockname' undeclared here 

thanks, applied and i have released the -25 patch with this fix 
includes.

	Ingo
