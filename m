Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751298AbWJEITf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbWJEITf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 04:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbWJEITf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 04:19:35 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:53378 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751298AbWJEITd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 04:19:33 -0400
Date: Thu, 5 Oct 2006 10:11:23 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
       John Stultz <johnstul@us.ibm.com>,
       Valdis Kletnieks <valdis.kletnieks@vt.edu>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>,
       David Woodhouse <dwmw2@infradead.org>, Jim Gettys <jg@laptop.org>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [patch 00/22] high resolution timers / dynamic ticks - V3
Message-ID: <20061005081123.GA28622@elte.hu>
References: <20061004172217.092570000@cruncher.tec.linutronix.de> <20061005011608.b69e3461.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061005011608.b69e3461.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@osdl.org> wrote:

> On Wed, 04 Oct 2006 17:31:29 -0000
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > this is an updated replacement queue against -mm3 , with all the
> > fixlets backmerged to the appropriate places (Build-fix-from: added).
> 
> That all seems to work OK with the two features configged off.
> 
> With CONFIG_HIGH_RES_TIMERS=y, CONFIG_NO_HZ=n it's pretty sick.  It 
> pauses for several seconds after "input: AlpsPS/2 ALPS GlidePoint as 
> /class/input/input2" (printk-time claims 2 seconds, but it was longer 
> than that).

checking.

	Ingo
