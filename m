Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268144AbUHQIHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268144AbUHQIHP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 04:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268148AbUHQIHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 04:07:14 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:49859 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268144AbUHQIGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 04:06:01 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P2
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Charbonnel <thomas@undata.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <20040817073049.GA556@elte.hu>
References: <20040816032806.GA11750@elte.hu>
	 <20040816033623.GA12157@elte.hu>
	 <1092627691.867.150.camel@krustophenia.net>
	 <20040816034618.GA13063@elte.hu> <1092628493.810.3.camel@krustophenia.net>
	 <20040816040515.GA13665@elte.hu> <1092654819.5057.18.camel@localhost>
	 <20040816113131.GA30527@elte.hu> <20040816120933.GA4211@elte.hu>
	 <1092716644.876.1.camel@krustophenia.net>  <20040817073049.GA556@elte.hu>
Content-Type: text/plain
Message-Id: <1092730019.1859.1.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 17 Aug 2004 04:06:59 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-17 at 03:30, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > P2 will not boot for me.  It hangs right after detecting my
> > (surprise!) USB mouse.
> 
> hm. Could you take -P1's arch/i386/io_apic.c and put it into the P2 tree
> - does that fix your bootup? (and does your USB mouse work after that?)
> 

OK, I am still not sure that P2 was the problem - reverting from ALSA
1.0.6a to ALSA cvs from a few weeks ago seemed to fix the problem. 
Ugh.  Still testing.

Lee

