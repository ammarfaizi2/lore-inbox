Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261383AbVDZIOl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261383AbVDZIOl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 04:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbVDZIOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 04:14:41 -0400
Received: from mx1.elte.hu ([157.181.1.137]:37289 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261383AbVDZIOZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 04:14:25 -0400
Date: Tue, 26 Apr 2005 10:13:41 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: ocroquette@free.fr, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Changing RT priority in kernel 2.6 without CAP_SYS_NICE
Message-ID: <20050426081341.GC31432@elte.hu>
References: <42628300.5020009@free.fr> <20050418080750.GA20811@elte.hu> <20050425220040.7e876ce5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050425220040.7e876ce5.akpm@osdl.org>
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


* Andrew Morton <akpm@osdl.org> wrote:

> Ingo Molnar <mingo@elte.hu> wrote:
> >
> >  Presently, a process without the capability CAP_SYS_NICE can not change 
> >  its own policy, which is OK.
> > 
> >  But it can also not decrease its RT priority (if scheduled with policy 
> >  SCHED_RR or SCHED_FIFO), which is what this patch changes.
> 
> This patch needed some massaging to copt with the changes in 
> nice-and-rt-prio-rlimits.patch - please check.
> 
> I guess we should merge nice-and-rt-prio-rlimits.patch.

the massaging looks ok - and i agree that we should merge the rt-rlimits 
patch.

	Ingo
