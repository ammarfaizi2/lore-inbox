Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751440AbWDDHFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbWDDHFp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 03:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751829AbWDDHFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 03:05:45 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:41174 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751440AbWDDHFo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 03:05:44 -0400
Date: Tue, 4 Apr 2006 09:03:23 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -rt] new update for tod periodic hook cycle times.
Message-ID: <20060404070322.GC5210@elte.hu>
References: <1144083104.24581.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1144083104.24581.6.camel@localhost.localdomain>
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


* Steven Rostedt <rostedt@goodmis.org> wrote:

> OK, scratch the two patches that I sent earlier. The ones that added 
> the enqueue to the hrtimer_interrupt and the tod update.  This patch 
> does the tod update from update_process_times.  This way we don't need 
> to allow driver writers the ability to create large latencies, because 
> they can add their call backs into the hrtimer_interrupt.

[this is the one that was applied in the end.]

	Ingo
