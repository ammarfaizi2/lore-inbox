Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267323AbUIARM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267323AbUIARM0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 13:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267382AbUIARJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 13:09:58 -0400
Received: from pD9E0E7B2.dip.t-dialin.net ([217.224.231.178]:42112 "EHLO
	undata.org") by vger.kernel.org with ESMTP id S266730AbUIARJW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 13:09:22 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q7
From: Thomas Charbonnel <thomas@undata.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "K.R. Foley" <kr@cybsft.com>,
       Mark_H_Johnson@raytheon.com, Lee Revell <rlrevell@joe-job.com>
In-Reply-To: <20040901135122.GA18708@elte.hu>
References: <200408282210.03568.pnambic@unu.nu>
	 <20040828203116.GA29686@elte.hu>
	 <1093727453.8611.71.camel@krustophenia.net>
	 <20040828211334.GA32009@elte.hu> <1093727817.860.1.camel@krustophenia.net>
	 <1093737080.1385.2.camel@krustophenia.net>
	 <1093746912.1312.4.camel@krustophenia.net> <20040829054339.GA16673@elte.hu>
	 <20040830090608.GA25443@elte.hu> <20040901082958.GA22920@elte.hu>
	 <20040901135122.GA18708@elte.hu>
Content-Type: text/plain
Message-Id: <1094058546.6465.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 01 Sep 2004 19:09:07 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote :
> i've released the -Q7 patch:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc1-bk4-Q7

With Q7 I still get rx latency issues (> 130 us non-preemptible section
from rtl8139_poll). Moreover network connections were extremely slow
(almost hung) until I set /proc/sys/net/core/netdev_backlog_granularity
to 2.

Thomas


