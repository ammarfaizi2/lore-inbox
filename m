Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268154AbUIAVlW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268154AbUIAVlW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 17:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267974AbUIAVhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 17:37:50 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:50048 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268121AbUIAVPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 17:15:09 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q5
From: Lee Revell <rlrevell@joe-job.com>
To: Martin Josefsson <gandalf@wlug.westbo.se>
Cc: Ingo Molnar <mingo@elte.hu>, Daniel Schmitt <pnambic@unu.nu>,
       "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mark_H_Johnson@raytheon.com, tytso@mit.edu
In-Reply-To: <1094053973.2282.2.camel@tux.rsn.bth.se>
References: <200408282210.03568.pnambic@unu.nu>
	 <20040828203116.GA29686@elte.hu>
	 <1093727453.8611.71.camel@krustophenia.net>
	 <20040828211334.GA32009@elte.hu> <1093727817.860.1.camel@krustophenia.net>
	 <1093737080.1385.2.camel@krustophenia.net>
	 <1093746912.1312.4.camel@krustophenia.net> <20040829054339.GA16673@elte.hu>
	 <20040830090608.GA25443@elte.hu> <1093934448.5403.4.camel@krustophenia.net>
	 <20040831065327.GA30631@elte.hu>
	 <1093993396.3404.17.camel@krustophenia.net>
	 <1094053973.2282.2.camel@tux.rsn.bth.se>
Content-Type: text/plain
Message-Id: <1094073302.1343.0.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 01 Sep 2004 17:15:02 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-01 at 11:52, Martin Josefsson wrote:
> On Wed, 2004-09-01 at 01:03, Lee Revell wrote:
> 
> Hi Lee
> 
> > This solves the problem with the random driver.  The worst latencies I
> > am seeing are in netif_receive_skb().  With netdev_max_backlog set to 8,
> > the worst is about 160 usecs:
> 
> I'm a bit curious... have you tried these tests with ip_conntrack
> enabled?

No, this is disabled in my config.  I will try enabling it.

What would the expected result be?

Lee

