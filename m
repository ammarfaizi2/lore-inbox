Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266295AbUHTKzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266295AbUHTKzn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 06:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266353AbUHTKzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 06:55:43 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:51097 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266295AbUHTKzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 06:55:32 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P4
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Charbonnel <thomas@undata.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <20040820104107.GA20446@elte.hu>
References: <20040816113131.GA30527@elte.hu> <20040816120933.GA4211@elte.hu>
	 <1092716644.876.1.camel@krustophenia.net> <20040817080512.GA1649@elte.hu>
	 <20040819073247.GA1798@elte.hu>
	 <1092972918.10063.11.camel@krustophenia.net>
	 <20040820081319.GA4321@elte.hu>
	 <1092993242.10063.66.camel@krustophenia.net>
	 <20040820102732.GA14622@elte.hu>
	 <1092998028.10063.103.camel@krustophenia.net>
	 <20040820104107.GA20446@elte.hu>
Content-Type: text/plain
Message-Id: <1092999330.10063.110.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 20 Aug 2004 06:55:31 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-20 at 06:41, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > > well, 9 msecs is still not nice. I've been able to trigger larger than
> > > 10msec latencies too on a 2 GHz box.
> > 
> > If this is the case then should a make -j12 have ground the machine to
> > a halt the way it did?
> 
> well, does it slow down that much with tracing and voluntary-preempt 
> disabled too?
> 

Yup. turns out, this is enough to use all available RAM and swap space
(1G total).  I probably went OOM.

Good stress test though.

Lee

