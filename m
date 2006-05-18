Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751177AbWERIGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbWERIGz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 04:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbWERIGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 04:06:54 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:47242 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751177AbWERIGx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 04:06:53 -0400
Date: Thu, 18 May 2006 10:06:54 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -rt 2/2] arm update
Message-ID: <20060518080654.GE30387@elte.hu>
References: <200605141557.k4EFv5Sd004979@dwalker1.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605141557.k4EFv5Sd004979@dwalker1.mvista.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

>  - Fixed arm mcount/arm_return_addr so they aren't under OABI_COMPAT ifdefs .
>  - adds a new NR_syscalls macro, converts the old one into __NR_syscalls for
>    calculating the table padding .
>  - removes old semaphore __MUTEX_INITIALIZER()
>  - depends blocker on X86 
>  - updates clockfw_lock to a raw_spinlock_t

thanks, applied.

	Ingo
