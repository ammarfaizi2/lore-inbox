Return-Path: <linux-kernel-owner+w=401wt.eu-S1751331AbWLLN2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbWLLN2R (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 08:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbWLLN2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 08:28:17 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:55503 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751331AbWLLN2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 08:28:16 -0500
Message-ID: <457EAE62.8090404@garzik.org>
Date: Tue, 12 Dec 2006 08:28:02 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       "David S. Miller" <davem@davemloft.net>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [patch] net, 8139too.c: fix netpoll deadlock
References: <20061212101656.GA5064@elte.hu> <20061212124935.GA4356@elte.hu>
In-Reply-To: <20061212124935.GA4356@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> Subject: [patch] net, 8139too.c: fix netpoll deadlock
> From: Ingo Molnar <mingo@elte.hu>
> 
> fix deadlock in the 8139too driver: poll handlers should never forcibly 
> enable local interrupts, because they might be used by netpoll/printk 
> from IRQ context.

ACK

(I'll queue it, if Linus doesn't pick it up; please CC me in the future)


