Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267518AbUIJQHo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267518AbUIJQHo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 12:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267554AbUIJQE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 12:04:29 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:24970 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S267549AbUIJQBM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 12:01:12 -0400
Subject: Re: TG3 doesn't work in kernel 2.4.27 (David S. Miller)
From: Paul Larson <pl@us.ibm.com>
To: Jake Moilanen <moilanen@austin.ibm.com>
Cc: Roland Dreier <roland@topspin.com>,
       "David S. Miller" <davem@davemloft.net>, Michael.Waychison@Sun.COM,
       Brian.Somers@Sun.COM, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1094651744.9913.280.camel@plars.austin.ibm.com>
References: <20040816110000.1120.31256.Mailman@lists.us.dell.com>
	 <200408162049.FFF09413.8592816B@anet.ne.jp>
	 <20040816143824.15238e42.davem@redhat.com> <412CD101.4050406@sun.com>
	 <20040825120831.55a20c57.davem@redhat.com> <412CF0E9.2010903@sun.com>
	 <20040825175805.6807014c.davem@redhat.com> <412DC055.4070401@sun.com>
	 <20040830161126.585a6b62.davem@davemloft.net>
	 <1094238777.9913.278.camel@plars.austin.ibm.com> <4138C3DD.1060005@sun.com>
	 <52acw7rtrw.fsf@topspin.com> <20040903133059.483e98a0.davem@davemloft.net>
	 <52ekljq6l2.fsf@topspin.com> <20040907133332.4ceb3b5a@localhost>
	 <52isapkg9z.fsf@topspin.com>  <20040908073412.3b7c9388@localhost>
	 <1094651744.9913.280.camel@plars.austin.ibm.com>
Content-Type: text/plain
Message-Id: <1094832030.9913.348.camel@plars.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 10 Sep 2004 11:00:30 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just realized that I forgot to mention, the latest kernel I tried on
with 2.6.9-rc1-bk15, which was still broken, network doesn't work. 
However, the autoneg failed messages in dmesg were gone.  I tried
multiple reboots to see if it would work/not work at random and I never
saw it work even once.

Thanks,
Paul Larson

On Wed, 2004-09-08 at 08:55, Paul Larson wrote:
> I've had no success on any of the blades or bladecenters I've tried it
> on.
> 
> On Wed, 2004-09-08 at 07:34, Jake Moilanen wrote:
> > > With the 3.9 tg3 driver, neither SoL nor the real network seems to
> > > ever come back.  As far as I can tell, the network is dead (and
> > > without SoL there's no way for me to see what happens to the kernel).
> > > 
> > > Have you had success with the latest tg3 on JS20?
> > 
> > I've had mixed results.  On some of my blades it never works.  On others
> > it will come up every third attempt or so.
> > 
> > Thanks,
> > Jake

