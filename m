Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261600AbUKCNpc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbUKCNpc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 08:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbUKCNpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 08:45:32 -0500
Received: from mx1.elte.hu ([157.181.1.137]:56764 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261600AbUKCNpT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 08:45:19 -0500
Date: Wed, 3 Nov 2004 14:46:26 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Lorenzo Allegrucci <l_allegrucci@yahoo.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm2-V0.7.1
Message-ID: <20041103134626.GA13852@elte.hu>
References: <20041018145008.GA25707@elte.hu> <20041027001542.GA29295@elte.hu> <20041103105840.GA3992@elte.hu> <200411031444.10570.l_allegrucci@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411031444.10570.l_allegrucci@yahoo.it>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lorenzo Allegrucci <l_allegrucci@yahoo.it> wrote:

>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> net/built-in.o(.text+0x1887f): In function `netpoll_setup':
> : undefined reference to `rcu_read_lock_up_read'
> net/built-in.o(.text+0x188ed): In function `netpoll_setup':
> : undefined reference to `rcu_read_lock_up_read'
> make: *** [.tmp_vmlinux1] Error 1

fixed in -V0.7.3.

	Ingo
