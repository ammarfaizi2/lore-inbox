Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266850AbUIIToO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266850AbUIIToO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 15:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266821AbUIITld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 15:41:33 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:52177 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266903AbUIITak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 15:30:40 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk12-S0
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
       linux-kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Alexander Nyberg <alexn@dsv.su.se>
In-Reply-To: <20040909061729.GH1362@elte.hu>
References: <20040905140249.GA23502@elte.hu>
	 <20040906110626.GA32320@elte.hu> <200409061348.41324.rjw@sisk.pl>
	 <1094473527.13114.4.camel@boxen> <20040906122954.GA7720@elte.hu>
	 <20040907092659.GA17677@elte.hu> <20040907115722.GA10373@elte.hu>
	 <1094597988.16954.212.camel@krustophenia.net>
	 <20040908082050.GA680@elte.hu> <1094683020.1362.219.camel@krustophenia.net>
	 <20040909061729.GH1362@elte.hu>
Content-Type: text/plain
Message-Id: <1094758246.1362.264.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 09 Sep 2004 15:30:46 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-09 at 02:17, Ingo Molnar wrote:
> could you try -S0:

Nope, different error:

  CC      arch/i386/kernel/irq.o
arch/i386/kernel/irq.c: In function `do_IRQ':
arch/i386/kernel/irq.c:273: warning: implicit declaration of function `redirect_hardirq'
arch/i386/kernel/irq.c:349: error: `noirqdebug' undeclared (first use in this function)
arch/i386/kernel/irq.c:349: error: (Each undeclared identifier is reported only once
arch/i386/kernel/irq.c:349: error: for each function it appears in.)
arch/i386/kernel/irq.c:350: warning: implicit declaration of function `note_interrupt'
make[1]: *** [arch/i386/kernel/irq.o] Error 1
make: *** [arch/i386/kernel] Error 2

Lee

