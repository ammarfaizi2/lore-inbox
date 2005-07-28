Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261382AbVG1IjB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261382AbVG1IjB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 04:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbVG1Ii4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 04:38:56 -0400
Received: from mx1.elte.hu ([157.181.1.137]:62148 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261358AbVG1Igi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 04:36:38 -0400
Date: Thu, 28 Jul 2005 10:35:44 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Keith Owens <kaos@ocs.com.au>, David.Mosberger@acm.org,
       Andrew Morton <akpm@osdl.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Add prefetch switch stack hook in scheduler function
Message-ID: <20050728083544.GA22740@elte.hu>
References: <10613.1122538148@kao2.melbourne.sgi.com> <42E897FD.6060506@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42E897FD.6060506@yahoo.com.au>
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


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> >No, they can be up to 30K apart.  See include/asm-ia64/ptrace.h.
> >thread_info is at ~0xda0, depending on the config.  The switch_stack
> >can be as high as 0x7bd0 in the kernel stack, depending on why the task
> >is sleeping.
> >
> 
> Just a minor point, I agree with David: I'd like it to be called 
> prefetch_task(), because some architecture may want to prefetch other 
> memory.

such as?

	Ingo
