Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267743AbUH1UBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267743AbUH1UBg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 16:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267739AbUH1UBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 16:01:36 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:56239 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267743AbUH1UBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 16:01:11 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q2
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mark_H_Johnson@raytheon.com
In-Reply-To: <20040828194449.GA25732@elte.hu>
References: <20040823221816.GA31671@yoda.timesys>
	 <20040824061459.GA29630@elte.hu> <20040828120309.GA17121@elte.hu>
	 <200408281818.28159.lkml@felipe-alfaro.com> <4130B7BD.5070801@cybsft.com>
	 <1093715573.8611.38.camel@krustophenia.net>
	 <20040828194449.GA25732@elte.hu>
Content-Type: text/plain
Message-Id: <1093723276.8611.60.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 28 Aug 2004 16:01:17 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-08-28 at 15:44, Ingo Molnar wrote:

> there's a Kconfig chunk missing from the Q0/Q1 patches, i've uploaded Q2

Still not quite right:

  HOSTLD  scripts/mod/modpost
  CC      arch/i386/kernel/asm-offsets.s
In file included from arch/i386/kernel/asm-offsets.c:7:
include/linux/sched.h: In function `lock_need_resched':
include/linux/sched.h:983: error: structure has no member named `break_lock'
make[1]: *** [arch/i386/kernel/asm-offsets.s] Error 1
make: *** [arch/i386/kernel/asm-offsets.s] Error 2

Lee

