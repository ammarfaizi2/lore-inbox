Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263875AbUHSIqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263875AbUHSIqy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 04:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263893AbUHSIqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 04:46:54 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:55528 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S263875AbUHSInv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 04:43:51 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P4
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Charbonnel <thomas@undata.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       William Lee Irwin III <wli@holomorphy.com>
In-Reply-To: <20040819084001.GA4098@elte.hu>
References: <20040816034618.GA13063@elte.hu>
	 <1092628493.810.3.camel@krustophenia.net> <20040816040515.GA13665@elte.hu>
	 <1092654819.5057.18.camel@localhost> <20040816113131.GA30527@elte.hu>
	 <20040816120933.GA4211@elte.hu> <1092716644.876.1.camel@krustophenia.net>
	 <20040817080512.GA1649@elte.hu> <20040819073247.GA1798@elte.hu>
	 <1092902417.8432.108.camel@krustophenia.net>
	 <20040819084001.GA4098@elte.hu>
Content-Type: text/plain
Message-Id: <1092905104.8432.116.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 19 Aug 2004 04:45:06 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-19 at 04:40, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > On Thu, 2004-08-19 at 03:32, Ingo Molnar wrote:
> > > i've uploaded the -P4 patch:
> > > 
> > >   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8.1-P4
> > 
> > Any comments on the unmap_vmas issue?
> 
> wli indicated he's working on the pagetable zapping critical section
> issue - wli?
> 

In the meantime, can we easily do a touch_preempt_timing() here, to
disable reporting of this issue, so we can continue to identify others? 
This one is frequent enough that I have not been able to identify any
more.

Lee 

