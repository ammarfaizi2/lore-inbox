Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751602AbVK3Ty2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602AbVK3Ty2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 14:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751603AbVK3Ty2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 14:54:28 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:30592 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751599AbVK3Ty2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 14:54:28 -0500
Date: Wed, 30 Nov 2005 20:54:49 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] linux-2.6.14-rt21 PPC32 signal delivery in realtime preemption.
Message-ID: <20051130195449.GA25075@elte.hu>
References: <438DBE4B.4000709@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <438DBE4B.4000709@ru.mvista.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.3 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Valentine Barshak <vbarshak@ru.mvista.com> wrote:

> This happens because interrupts are not enabled in the realtime 
> preemption mode by the time kernel delivers signals to processes. This 
> patch enables interrupts so that realtime mutexes can be acquired in 
> the "right" context. The original code has been found in 
> CONFIG_PREEMPT_RT support for i386 architecture. Thanks.
> 
> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>

thanks, applied.

	Ingo
