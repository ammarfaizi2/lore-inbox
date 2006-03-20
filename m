Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964819AbWCTOf6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbWCTOf6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 09:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964820AbWCTOf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 09:35:58 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:12203 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964819AbWCTOf6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 09:35:58 -0500
Date: Mon, 20 Mar 2006 15:33:52 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>, linux-kernel@vger.kernel.org
Subject: Re: [patch] latency-tracing-v2.6.16
Message-ID: <20060320143352.GA22171@elte.hu>
References: <20060320101307.GA15477@elte.hu> <20060320142409.GA5769@mail.ustc.edu.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060320142409.GA5769@mail.ustc.edu.cn>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Wu Fengguang <wfg@mail.ustc.edu.cn> wrote:

> If one (as I did at the first attempt) selects a CPU type of 
> "586/K5/5x86/6x86/6x86MX", he will get nothing from 
> /proc/latency_trace.
> 
> So does it make sense to add dependency lines like the following one?
> 
>         depends on (!X86_32 || X86_GENERIC || X86_TSC)

yeah, makes sense - i've added this too and have uploaded an updated 
version of the patch.

	Ingo
