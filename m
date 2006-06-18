Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932297AbWFRTsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbWFRTsq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 15:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932311AbWFRTsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 15:48:46 -0400
Received: from mail.timesys.com ([65.117.135.102]:3557 "EHLO
	postfix.timesys.com") by vger.kernel.org with ESMTP id S932297AbWFRTsp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 15:48:45 -0400
Subject: Re: [PATCHSET] Announce: High-res timers, tickless/dyntick and
	dynamic HZ
From: Thomas Gleixner <tglx@timesys.com>
Reply-To: tglx@timesys.com
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       john stultz <johnstul@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Con Kolivas <kernel@kolivas.org>
In-Reply-To: <449580CA.2060704@gmail.com>
References: <1150643426.27073.17.camel@localhost.localdomain>
	 <449580CA.2060704@gmail.com>
Content-Type: text/plain
Date: Sun, 18 Jun 2006 21:50:02 +0200
Message-Id: <1150660202.27073.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal,

On Sun, 2006-06-18 at 18:35 +0200, Michal Piotrowski wrote:
> HARNING: /lib/modules/2.6.17-hrt-dyntick1/kernel/sound/pci/ac97/snd-ac97-codec.ko needs unknown symbol msecs_to_jiffies
> WARNING: /lib/modules/2.6.17-hrt-dyntick1/kernel/drivers/net/skge.ko needs unknown symbol jiffies_to_msecs
> WARNING: /lib/modules/2.6.17-hrt-dyntick1/kernel/drivers/cpufreq/cpufreq_ondemand.ko needs unknown symbol jiffies_to_usecs
> 
> Here is fix small fix.

Applied, thanks. 

New patch available at:

http://www.tglx.de/projects/hrtimers/2.6.17/patch-2.6.17-hrt-dyntick2.patch

http://www.tglx.de/projects/hrtimers/2.6.17/patch-2.6.17-hrt-dyntick2.patches.tar.bz2

	tglx


