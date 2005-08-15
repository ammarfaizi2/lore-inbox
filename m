Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932664AbVHOLR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932664AbVHOLR1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 07:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932666AbVHOLR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 07:17:27 -0400
Received: from mx2.elte.hu ([157.181.151.9]:43189 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932664AbVHOLR0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 07:17:26 -0400
Date: Mon, 15 Aug 2005 13:18:04 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Ryan Brown <some.nzguy@gmail.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       george anzinger <george@mvista.com>
Subject: [patch] Real-Time Preemption, -RT-2.6.13-rc6-V0.7.53-11
Message-ID: <20050815111804.GA26161@elte.hu>
References: <20050811110051.GA20872@elte.hu> <1c1c8636050812172817b14384@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c1c8636050812172817b14384@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=none autolearn=disabled SpamAssassin version=3.0.4
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ryan Brown <some.nzguy@gmail.com> wrote:

> is there a patch available for -rc6?

yes, i've just uploaded the -53-11 release, which is against 2.6.13-rc6.

the -53-11 release includes a number of fixes, in particular a fix for 
hard lockups that occur mostly on SMP systems, but also might occur on 
UP systems.

to build a -53-11 tree, the following patches should to be applied:

   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.12.tar.bz2
   http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.13-rc6.bz2
   http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.13-rc6-RT-V0.7.53-11

	Ingo
