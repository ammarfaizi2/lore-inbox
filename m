Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbVA0VwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbVA0VwG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 16:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbVA0VwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 16:52:05 -0500
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:15796 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S261205AbVA0VwD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 16:52:03 -0500
Date: Thu, 27 Jan 2005 13:50:49 -0800
From: Tony Lindgren <tony@atomide.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Pavel Machek <pavel@suse.cz>, Arjan van de Ven <arjan@infradead.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>, George Anzinger <george@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Dynamic tick, version 050127-1
Message-ID: <20050127215048.GG15274@atomide.com>
References: <20050127212902.GF15274@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050127212902.GF15274@atomide.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [050127 13:34]:
> Hi all,
> 
> Thanks for all the comments, here's an updated version of the dynamic
> tick patch.

Oops, I guess I should test before posting :)

Looks like CONFIG_X86_LOCAL_APIC=y is currenly needed on uniprocessor
machines to compile. Also CONFIG_SMP=y makes the skipping to fail
on a uniprocessor machine.

Regards,

Tony
