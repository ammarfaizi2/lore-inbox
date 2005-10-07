Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161011AbVJGW4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161011AbVJGW4z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 18:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030558AbVJGW4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 18:56:55 -0400
Received: from smtp2.Stanford.EDU ([171.67.16.125]:62913 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S1030556AbVJGW4y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 18:56:54 -0400
Subject: Re: 2.6.14-rc3-rt10 build problem (now rt12)
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>
Cc: nando@ccrma.Stanford.EDU, linux-kernel@vger.kernel.org
In-Reply-To: <20051007211654.GA14996@elte.hu>
References: <1128619072.4593.16.camel@cmn3.stanford.edu>
	 <20051007114126.GC857@elte.hu> <1128714933.23974.3.camel@cmn3.stanford.edu>
	 <20051007211654.GA14996@elte.hu>
Content-Type: text/plain
Date: Fri, 07 Oct 2005 15:56:41 -0700
Message-Id: <1128725801.23974.20.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-10-07 at 23:16 +0200, Ingo Molnar wrote:
> * Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:
> 
> > On Fri, 2005-10-07 at 13:41 +0200, Ingo Molnar wrote:
> > > * Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:
> > > 
> > > > Maybe not related to rt10, but still can't build it, ".config" 
> > > > attached:
> > > 
> > > ok, i fixed this in -rt11, does it build for you now?
> > 
> > rt12 bombs here on the smp/i686 compile (smp config attached):
> 
> ok - i have fixed these and have released -rt13 - does it work for you?

The kernel finally builds but I'm getting these on a depmod -a, will
check further:

WARNING: /lib/modules/2.6.13-0.7.rdt.rhfc4.ccrma/kernel/drivers/input/gameport/gameport.ko needs unknown symbol local_irq_restore_nort
WARNING: /lib/modules/2.6.13-0.7.rdt.rhfc4.ccrma/kernel/drivers/input/gameport/gameport.ko needs unknown symbol local_irq_save_nort

-- Fernando


