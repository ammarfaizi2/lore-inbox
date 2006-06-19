Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964869AbWFSTuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964869AbWFSTuY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 15:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964871AbWFSTuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 15:50:24 -0400
Received: from mail.timesys.com ([65.117.135.102]:61919 "EHLO
	postfix.timesys.com") by vger.kernel.org with ESMTP id S964869AbWFSTuX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 15:50:23 -0400
Subject: Re: [PATCHSET] Announce: High-res timers, tickless/dyntick and
	dynamic HZ
From: Thomas Gleixner <tglx@timesys.com>
Reply-To: tglx@timesys.com
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, john stultz <johnstul@us.ibm.com>,
       Con Kolivas <kernel@kolivas.org>
In-Reply-To: <4496D24F.80003@gmail.com>
References: <1150643426.27073.17.camel@localhost.localdomain>
	 <449580CA.2060704@gmail.com> <20060618182820.GA32765@elte.hu>
	 <4496D24F.80003@gmail.com>
Content-Type: text/plain; charset=utf-8
Date: Mon, 19 Jun 2006 21:51:45 +0200
Message-Id: <1150746705.29299.57.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-19 at 18:35 +0200, Michal Piotrowski wrote:
> Here is the last EXPORT_SYMBOL fix.
> WARNING: /lib/modules/2.6.17-hrt-dyntick1/kernel/drivers/cpufreq/cpufreq_stats.ko needs unknown symbol jiffies_64_to_clock_t

Thanks, fixed.

> BTW. APM doesn't compile.
> 
> /usr/src/linux-work1/arch/i386/kernel/apm.c: In function ‘apm_do_idle’:
> /usr/src/linux-work1/arch/i386/kernel/apm.c:767: error: ‘TIF_POLLING_NRFLAG’ undeclared (first use in this function)

Fixed, new patch at:

http://www.tglx.de/projects/hrtimers/2.6.17/linux-2.6.17-hrt-dyntick4.patch

http://www.tglx.de/projects/hrtimers/2.6.17/linux-2.6.17-hrt-dyntick4.patches.tar.bz2

	tglx


