Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751197AbVKKVIX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbVKKVIX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 16:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbVKKVIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 16:08:22 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:12511 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751197AbVKKVIW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 16:08:22 -0500
Date: Fri, 11 Nov 2005 22:08:37 +0100
From: Ingo Molnar <mingo@elte.hu>
To: art <art@usfltd.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rt10 =?iso-8859-1?Q?compilation?=
	=?iso-8859-1?Q?_error_kernel=2Fsched=2Ec=3A_In_function_=91=5F=5Fcond=5Fr?=
	=?iso-8859-1?Q?esched=5Fraw=5Fspinlock'?=
Message-ID: <20051111210837.GA6215@elte.hu>
References: <200511111446.AA29884834@usfltd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200511111446.AA29884834@usfltd.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* art <art@usfltd.com> wrote:

> 
>   LD      arch/i386/mach-default/built-in.o
>   LD      arch/i386/crypto/built-in.o
>   AS [M]  arch/i386/crypto/aes-i586-asm.o
>   CC [M]  arch/i386/crypto/aes.o
>   LD [M]  arch/i386/crypto/aes-i586.o
>   CC      kernel/sched.o
> kernel/sched.c: In function ‘__cond_resched_raw_spinlock’:
> kernel/sched.c:4593: error: ‘struct <anonymous>’ has no member named ‘break_lock’
> kernel/sched.c:4593: error: ‘struct <anonymous>’ has no member named ‘break_lock’
> make[1]: *** [kernel/sched.o] Error 1
> make: *** [kernel] Error 2

-rt11 should fix this.

	Ingo
