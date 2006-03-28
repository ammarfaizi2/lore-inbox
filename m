Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbWC1U0q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbWC1U0q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 15:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbWC1U0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 15:26:46 -0500
Received: from mail8.fw-bc.sony.com ([160.33.98.75]:15792 "EHLO
	mail8.fw-bc.sony.com") by vger.kernel.org with ESMTP
	id S932153AbWC1U0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 15:26:45 -0500
Message-ID: <44299BE5.6040308@am.sony.com>
Date: Tue, 28 Mar 2006 12:26:13 -0800
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [patch 06/10] PI-futex: rt-mutex docs
References: <20060325184620.GG16724@elte.hu>
In-Reply-To: <20060325184620.GG16724@elte.hu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some minor nits.

Ingo Molnar wrote:
> Is the temporary priority
> +boosted owner blocked on a rt_mutex itself it propagates the priority
> +boosting to the owner of the rt_mutex it is blocked on.

Should that sentence start with "If"?

> The priority
> +boosting is immidiately removed once the rt_mutex has been unlocked.

immidiately -> immediately

> Per
> +rtmutex only the top priority waiter is enqueued into the owners
> +priority waiters list. Also this list enqueues in priority
> +order.

owners -> owner's

> The optimized fathpath operations require cmpxchg
> +support.

fathpath -> fastpath

If you would like the above changes in patch format,
please let me know.

Regards,
 -- Tim

=============================
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
=============================
