Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264501AbUG3Duu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264501AbUG3Duu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 23:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264911AbUG3Duu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 23:50:50 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:60570 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S264501AbUG3Dus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 23:50:48 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-J3
From: Lee Revell <rlrevell@joe-job.com>
To: Eric St-Laurent <ericstl34@sympatico.ca>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       wli@holomorphy.com, lenar@vision.ee,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1091154667.12149.15.camel@orbiter>
References: <20040713122805.GZ21066@holomorphy.com>
	 <40F3F0A0.9080100@vision.ee> <20040713143947.GG21066@holomorphy.com>
	 <1090732537.738.2.camel@mindpipe> <1090795742.719.4.camel@mindpipe>
	 <20040726082330.GA22764@elte.hu> <1090830574.6936.96.camel@mindpipe>
	 <20040726083537.GA24948@elte.hu> <20040726125750.5e467cfd.akpm@osdl.org>
	 <20040726203634.GA26096@elte.hu>  <1091154667.12149.15.camel@orbiter>
Content-Type: text/plain
Message-Id: <1091159465.782.2.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 29 Jul 2004 23:51:06 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-07-29 at 22:31, Eric St-Laurent wrote:
> It might be possible to eliminate the need_resched flag.  Here is an
> article that talk about a event-driven preemption model.
> 
> Quoting :
> 
> Over the long term, MontaVista is investigating whether preemption locks
> can be eliminated (or at least greatly reduced in number) by protecting
> all the short-duration critical regions with spinlocks that also disable
> interrupts on the local CPU, and the long-duration critical regions with
> mutex locks.

This is a pretty old article, from 2000, describing the preemption model
they implemented on 2.4.  I believe the above paragraph describes the
advantages of their model vs. the approach taken by the old 2.4 low
latency patches.

My understanding is that the preemptible 2.6 kernel already works this
way.

Lee

