Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266069AbUIIUno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266069AbUIIUno (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 16:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266137AbUIIUno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 16:43:44 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:3295 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266069AbUIIUnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 16:43:42 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk12-R6
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       felipe_alfaro@linuxmail.org, Florian Schmidt <mista.tapas@gmx.net>,
       "K.R. Foley" <kr@cybsft.com>, Mark_H_Johnson@Raytheon.com,
       scott@timesys.com
In-Reply-To: <1094758399.1362.268.camel@krustophenia.net>
References: <20040903120957.00665413@mango.fruits.de>
	 <20040904195141.GA6208@elte.hu> <20040905140249.GA23502@elte.hu>
	 <20040906110626.GA32320@elte.hu>
	 <1094626562.1362.99.camel@krustophenia.net> <20040909192924.GA1672@elte.hu>
	 <1094758399.1362.268.camel@krustophenia.net>
Content-Type: text/plain
Message-Id: <1094762629.1362.320.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 09 Sep 2004 16:43:49 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-09 at 15:33, Lee Revell wrote:
> I believe Scott Wood suggested a fix back when I first reported this,
> have to check my mailbox.  Scott?
> 

Nope, checking the original thread, Scott pointed out that any RT
process will have mlockall'ed anyway and thus won't be affected by this
latency.  So, this one would be cool to fix, but it's not a problem as
such.

Lee 

