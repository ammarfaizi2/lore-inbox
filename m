Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751427AbWBQTxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbWBQTxm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 14:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbWBQTxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 14:53:42 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:30652 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751427AbWBQTxl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 14:53:41 -0500
Date: Fri, 17 Feb 2006 20:52:01 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, ce@ruault.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] timer-irq-driven soft-watchdog, cleanups
Message-ID: <20060217195201.GA29025@elte.hu>
References: <43EF8388.10202@ruault.com> <20060215185120.6c35eca2.akpm@osdl.org> <58cb370e0602160533n3325ba03yfedaf4e55278521d@mail.gmail.com> <20060216122045.7a664bc6.akpm@osdl.org> <58cb370e0602170347qeddb390u680895fd2f0aab7d@mail.gmail.com> <20060217130801.GA16115@elte.hu> <58cb370e0602170646h3d0cddo8b042eab251d9365@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cb370e0602170646h3d0cddo8b042eab251d9365@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> > If you still get warnings even with this patch applied, then my very
> > strong suspicion is that the 10+ seconds delays in the IDE code are
> > real, and not false-positives. If there are such places then the minimum
> > we should do is to document them via touch_softlockup_watchdog() ...
> > even if you "knew" about such places already.
> 
> Fully agreed, where is the patch?

it's included in the mail you replied to :)

	Ingo
