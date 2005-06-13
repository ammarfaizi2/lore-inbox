Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261612AbVFMPTA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261612AbVFMPTA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 11:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbVFMPSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 11:18:07 -0400
Received: from opersys.com ([64.40.108.71]:56074 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261612AbVFMPPU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 11:15:20 -0400
Subject: Re: PREEMPT_RT vs ADEOS: the numbers, part 1
From: Kristian Benoit <kbenoit@opersys.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Karim Yaghmour <karim@opersys.com>, linux-kernel@vger.kernel.org,
       paulmck@us.ibm.com, bhuey@lnxw.com, andrea@suse.de, tglx@linutronix.de,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org
In-Reply-To: <20050613150021.GA5891@elte.hu>
References: <42AA6A6B.5040907@opersys.com> <20050611191448.GA24152@elte.hu>
	 <42AB662B.4010104@opersys.com>  <20050613150021.GA5891@elte.hu>
Content-Type: text/plain
Date: Mon, 13 Jun 2005 11:12:30 -0400
Message-Id: <1118675550.5792.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-06-13 at 17:00 +0200, Ingo Molnar wrote:
> FYI, there's a new feature in the -V0.7.48-25 (and later) -RT patches 
> that implements this: CONFIG_LPPTEST. It is a simple standalone
> driver 
> and userspace utility from Thomas Gleixner that can be used to
> measure 
> the IRQ-latency of the system over a null-modem-parallel-cable.

Thanks a lot, I must check that and make an adeos and adeos/PREEMPT_RT
version of it. That will probably provide different info than the simple
driver I wrote.

Kristian

