Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267476AbUH1Rwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267476AbUH1Rwx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 13:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267387AbUH1Rwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 13:52:53 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:25767 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267476AbUH1Rwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 13:52:51 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q0
From: Lee Revell <rlrevell@joe-job.com>
To: "K.R. Foley" <kr@cybsft.com>
Cc: Felipe Alfaro Solana <lkml@felipe-alfaro.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mark_H_Johnson@raytheon.com
In-Reply-To: <4130B7BD.5070801@cybsft.com>
References: <20040823221816.GA31671@yoda.timesys>
	 <20040824061459.GA29630@elte.hu> <20040828120309.GA17121@elte.hu>
	 <200408281818.28159.lkml@felipe-alfaro.com>  <4130B7BD.5070801@cybsft.com>
Content-Type: text/plain
Message-Id: <1093715573.8611.38.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 28 Aug 2004 13:52:57 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-08-28 at 12:50, K.R. Foley wrote:
> Felipe Alfaro Solana wrote:
> > On Saturday 28 August 2004 14:03, Ingo Molnar wrote:
> > 
> > 
> >>Similarly, there are 4 independent options for the .config:
> >>CONFIG_PREEMPT, CONFIG_PREEMPT_VOLUNTARY, CONFIG_PREEMPT_SOFTIRQS and
> >>CONFIG_PREEMPT_HARDIRQS. (In theory all of these options should compile
> >>independently, but i've only tested all-enabled so far.)
> > 
> > 
> > I must be missing something, but after applying diff-bk-040828-2.6.8.1.bz2 and 
> > voluntary-preempt-2.6.9-rc1-bk4-Q1 on top of 2.6.8.1, I'm unable to find 
> > neither CONFIG_PREEMPT_VOLUNTARY, CONFIG_PREEMPT_SOFTIRQS, nor 
> > CONFIG_PREEMPT_HARDIRQS.
> > 
> > Any ideas are welcome.
> 
> Looks like all of these config options are missing from Q1 also. I was 
> just looking myself.
> 

Same results here, none of those config options seem to exist.  I also
get this warning a lot:

include/linux/rwsem.h: In function `down_read':
include/linux/rwsem.h:43: warning: implicit declaration of function `cond_resched'

Lee

