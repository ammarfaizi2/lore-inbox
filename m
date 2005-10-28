Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965183AbVJ1Iib@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965183AbVJ1Iib (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 04:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965184AbVJ1Iib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 04:38:31 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:11925 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965183AbVJ1Iia (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 04:38:30 -0400
Date: Fri, 28 Oct 2005 10:38:48 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Nick Piggin'" <nickpiggin@yahoo.com.au>,
       "'Andrew Morton'" <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] optimize activate_task()
Message-ID: <20051028083848.GE5248@elte.hu>
References: <200510270153.j9R1r5g27370@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510270153.j9R1r5g27370@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Chen, Kenneth W <kenneth.w.chen@intel.com> wrote:

> recalc_task_prio() is called from activate_task() to calculate dynamic 
> priority and interactive credit for the activating task. For real-time 
> scheduling process, all that dynamic calculation is thrown away at the 
> end because rt priority is fixed.  Patch to optimize 
> recalc_task_prio() away for rt processes.
> 
> 
> Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
