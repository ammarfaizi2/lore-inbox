Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbWCNHyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbWCNHyH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 02:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752012AbWCNHyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 02:54:07 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:25791 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750728AbWCNHyG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 02:54:06 -0500
Date: Tue, 14 Mar 2006 08:51:47 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc6-rt1
Message-ID: <20060314075147.GB13662@elte.hu>
References: <20060312220218.GA3469@elte.hu> <1142301277.27125.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142301277.27125.18.camel@localhost.localdomain>
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

> Hi Ingo,
> 
> I couldn't compile it on x86_64 (and I believe PPC has the same 
> problem). I guess the function propagate_preempt_locks_value 
> disappeared.

yeah. Dynamic setting of that mode wasnt working too well (==at all).

> This patch removes the references from ppc and x86_64.

thanks, applied.

	Ingo
