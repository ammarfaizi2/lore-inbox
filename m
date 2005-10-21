Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965059AbVJUSKx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965059AbVJUSKx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 14:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965066AbVJUSKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 14:10:53 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:3266
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S965059AbVJUSKw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 14:10:52 -0400
Subject: Re: False positive (well not really) on RT backward clock check
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: john stultz <johnstul@us.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1129917588.27168.215.camel@cog.beaverton.ibm.com>
References: <Pine.LNX.4.58.0510210942180.3903@localhost.localdomain>
	 <1129902741.15748.4.camel@tglx.tec.linutronix.de>
	 <Pine.LNX.4.58.0510211142060.5770@localhost.localdomain>
	 <1129909935.15748.12.camel@tglx.tec.linutronix.de>
	 <1129917588.27168.215.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Organization: linutronix
Date: Fri, 21 Oct 2005 20:13:27 +0200
Message-Id: <1129918407.15748.19.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-10-21 at 10:59 -0700, john stultz wrote:
> > This is at the moment where the clock source is switched over. I check
> > what might be the reason.
> > 
> > John, any idea ?
> 
> This is using the B7 tod code, correct? If so, B8 corrected a problem
> specifically with changing clocksources (most easily seen while changing
> to the TSC based clocksource), so I would not be surprised if this is
> the same bug.

Thanks, will rebase to B8

	tglx


