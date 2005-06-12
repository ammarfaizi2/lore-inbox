Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261200AbVFLTYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbVFLTYl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 15:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261230AbVFLTXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 15:23:18 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:21268
	"EHLO g5.random") by vger.kernel.org with ESMTP id S262651AbVFLRGL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 13:06:11 -0400
Date: Sun, 12 Jun 2005 19:06:06 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Karim Yaghmour <karim@opersys.com>
Cc: paulmck@us.ibm.com, Bill Huey <bhuey@lnxw.com>,
       Lee Revell <rlrevell@joe-job.com>, Tim Bird <tim.bird@am.sony.com>,
       linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org
Subject: Re: Attempted summary of "RT patch acceptance" thread
Message-ID: <20050612170606.GF5796@g5.random>
References: <20050610193926.GA19568@nietzsche.lynx.com> <42A9F788.2040107@opersys.com> <20050610223724.GA20853@nietzsche.lynx.com> <20050610225231.GF6564@g5.random> <20050610230836.GD21618@nietzsche.lynx.com> <20050610232955.GH6564@g5.random> <20050611014133.GO1300@us.ibm.com> <20050611155459.GB5796@g5.random> <20050611210417.GC1299@us.ibm.com> <42AB7857.1090907@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42AB7857.1090907@opersys.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2005 at 07:48:39PM -0400, Karim Yaghmour wrote:
> Let me clarify what I say above to make it clear that linux/hard-rt
> and include/linux-hrt/ could/would include a merged PREEMPT_RT, adeos, and
> rtai-fusion. The combo patch put together by Philippe (which includes both
> PREEMPT_RT and adeos) is already a good start in that direction. Like we
> said earlier, both methods are not mutually exclusive.

FWIW I definitely agree that merging PREEMPT_RT design and nanokernel
design in a single RT kernel makes lots of sense, and this confirms my
original belief that preempt-RT and nanokernel are orthogonal and they
don't cover the same domain of RT apps (or they'd overlap completely and
it would be pointless to have them at the same time in the same kernel
to use them at the same time).
