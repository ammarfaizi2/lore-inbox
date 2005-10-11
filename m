Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751369AbVJKK4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbVJKK4L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 06:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbVJKK4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 06:56:10 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:44262 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751369AbVJKK4J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 06:56:09 -0400
Date: Tue, 11 Oct 2005 12:56:40 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Felix Oxley <lkml@oxley.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc3-rt13: Build Problem
Message-ID: <20051011105640.GA15481@elte.hu>
References: <200510092213.25530.lkml@oxley.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510092213.25530.lkml@oxley.org>
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


* Felix Oxley <lkml@oxley.org> wrote:

>   LD      .tmp_vmlinux1
> drivers/built-in.o: In function `mkiss_open':
> : undefined reference to `there_is_no_init_MUTEX_LOCKED_for_RT_semaphores'
> drivers/built-in.o: In function `sixpack_open':
> : undefined reference to `there_is_no_init_MUTEX_LOCKED_for_RT_semaphores'
> drivers/built-in.o: In function `gameport_measure_speed':
> : undefined reference to `local_irq_save_nort'
> drivers/built-in.o: In function `gameport_measure_speed':
> : undefined reference to `local_irq_restore_nort'
> drivers/built-in.o: In function `mc32_probe1':
> : undefined reference to `there_is_no_init_MUTEX_LOCKED_for_RT_semaphores'
> make: *** [.tmp_vmlinux1] Error 1

thanks for the build-testing - i fixed these in my tree and they should 
be fixed in -rc4-rt1.

	Ingo
