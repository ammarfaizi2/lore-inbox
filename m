Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266189AbUGJIXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266189AbUGJIXU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 04:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266191AbUGJIXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 04:23:20 -0400
Received: from mx1.elte.hu ([157.181.1.137]:43677 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266189AbUGJIXR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 04:23:17 -0400
Date: Sat, 10 Jul 2004 10:23:55 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Torrey Hoffman <thoffman@arnor.net>
Cc: Linux-Kernel List <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040710082355.GA28569@elte.hu>
References: <20040709182638.GA11310@elte.hu> <1089409011.2738.19.camel@rohan.arnor.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1089409011.2738.19.camel@rohan.arnor.net>
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


* Torrey Hoffman <thoffman@arnor.net> wrote:

> This looks great - one small problem: when compiling with ext3 as a
> module, I get:
> 
> WARNING: /lib/modules/2.6.7-bk20-vp/kernel/fs/jbd/jbd.ko needs unknown
> symbol voluntary_preemption

ok, i fixed this bug in -H3:

  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.7-bk20-H3

(-H3 also fixes another bug when enabling CONFIG_PREEMPT.)

	Ingo
