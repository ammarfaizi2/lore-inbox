Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262423AbVE0KNH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262423AbVE0KNH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 06:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbVE0KNG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 06:13:06 -0400
Received: from mx2.elte.hu ([157.181.151.9]:58767 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262423AbVE0KMy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 06:12:54 -0400
Date: Fri, 27 May 2005 12:12:29 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] improve SMP reschedule and idle routines
Message-ID: <20050527101229.GA10479@elte.hu>
References: <4296CA7A.4050806@cyberone.com.au> <20050527085726.GA20512@elte.hu> <4296EA77.2030605@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4296EA77.2030605@yahoo.com.au>
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

> Make some changes to the NEED_RESCHED and POLLING_NRFLAG to reduce 
> confusion, and make their semantics rigid. Also have preempt 
> explicitly disabled in idle routines. Improves efficiency of 
> resched_task and some cpu_idle routines.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
