Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263415AbVCKPrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263415AbVCKPrJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 10:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263404AbVCKPqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 10:46:44 -0500
Received: from mx2.elte.hu ([157.181.151.9]:11175 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263415AbVCKPih (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 10:38:37 -0500
Date: Fri, 11 Mar 2005 16:38:17 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@osdl.org>, rlrevell@joe-job.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
Message-ID: <20050311153817.GA32020@elte.hu>
References: <20050204100347.GA13186@elte.hu> <1108789704.8411.9.camel@krustophenia.net> <Pine.LNX.4.58.0503100323370.14016@localhost.localdomain> <Pine.LNX.4.58.0503100447150.14016@localhost.localdomain> <20050311095747.GA21820@elte.hu> <Pine.LNX.4.58.0503110508360.19798@localhost.localdomain> <20050311101740.GA23120@elte.hu> <Pine.LNX.4.58.0503110521390.19798@localhost.localdomain> <20050311024322.690eb3a9.akpm@osdl.org> <Pine.LNX.4.58.0503110754240.19798@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503110754240.19798@localhost.localdomain>
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


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Here's the patch. It's probably more of an overkill wrt buffer heads,
> but it seems to be the easiest solution.

isnt there some ext3-private journal structure (journal-bh) linked off 
the bh? If the lock is in that structure then the overhead would only 
affect ext3.

	Ingo
