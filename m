Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268948AbUHUJX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268948AbUHUJX5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 05:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268949AbUHUJX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 05:23:57 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:898 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268948AbUHUJXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 05:23:42 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P5
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Charbonnel <thomas@undata.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Mark_H_Johnson@raytheon.com
In-Reply-To: <20040821091804.GA26622@elte.hu>
References: <1092654819.5057.18.camel@localhost>
	 <20040816113131.GA30527@elte.hu> <20040816120933.GA4211@elte.hu>
	 <1092716644.876.1.camel@krustophenia.net> <20040817080512.GA1649@elte.hu>
	 <20040819073247.GA1798@elte.hu> <20040820133031.GA13105@elte.hu>
	 <1093058602.854.5.camel@krustophenia.net> <20040821091338.GA25931@elte.hu>
	 <1093079726.854.80.camel@krustophenia.net> <20040821091804.GA26622@elte.hu>
Content-Type: text/plain
Message-Id: <1093080202.854.94.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 21 Aug 2004 05:23:22 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-08-21 at 05:18, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > > > http://krustophenia.net/testresults.php?dataset=2.6.8.1-P6#/var/www/2.6.8.1-P6/trace8.txt
> > > 
> > > i suspect if you turn off tracing (or disable it in the kernel
> > > completely) then you'd see below-100 usec latencies here. A trace entry
> > > costs ~0.3 usecs on your box, so this 50-entry trace has roughly 15
> > > usecs of tracing overhead :-)
> > > 
> > 
> > FWIW, I did see one of these over 200 usecs.
> 
> which trace is this?
> 

Sorry, I was thinking of this one:

http://krustophenia.net/testresults.php?dataset=2.6.8.1-P6#/var/www/2.6.8.1-P6/trace10.txt

Lee

