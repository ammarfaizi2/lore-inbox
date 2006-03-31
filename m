Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751280AbWCaKeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbWCaKeL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 05:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbWCaKeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 05:34:10 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:19395 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751280AbWCaKeJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 05:34:09 -0500
Date: Fri, 31 Mar 2006 12:31:38 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -rt] spin_lock in check_monotonic_clock must be raw
Message-ID: <20060331103138.GA26875@elte.hu>
References: <1143728884.26540.31.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143728884.26540.31.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Hi Ingo,
> 
> The lock in check_monotonic_clock must be a raw spinlock since it is 
> called from the hrtimer_interrupt.

thanks, applied.

	Ingo
