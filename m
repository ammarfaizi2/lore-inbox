Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267402AbTGZSQM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 14:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267471AbTGZSQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 14:16:11 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:4100 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S267402AbTGZSQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 14:16:08 -0400
Subject: Re: Ingo Molnar and Con Kolivas 2.6 scheduler patches
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       LKML <linux-kernel@vger.kernel.org>, kernel@kolivas.org, mingo@elte.hu
In-Reply-To: <20030726181913.GY15452@holomorphy.com>
References: <1059211833.576.13.camel@teapot.felipe-alfaro.com>
	 <200307261142.43277.m.c.p@wolk-project.de>
	 <20030726181913.GY15452@holomorphy.com>
Content-Type: text/plain
Message-Id: <1059244278.576.0.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3.99 
Date: Sat, 26 Jul 2003 20:31:18 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-07-26 at 20:19, William Lee Irwin III wrote:
> On Sat, Jul 26, 2003 at 11:46:45AM +0200, Marc-Christian Petersen wrote:
> > Now that I've tested 2.6.0-test-1-wli (William Lee Irwin's Tree) for over a 
> > week, I thought about, that the problem might _not_ be only the O(1) 
> > Scheduler, because -wli has changed almost nothing to the scheduler stuff, 
> > it's almost 2.6.0-test1 code and running that kernel, my system is _alot_ 
> > more responsive than 2.6.0-test1 or 2.6.0-test1-mm* or all the Oxint 
> > scheduler fixes have ever been.
> > Strange no?
> > P.S.: I've not tested Ingo's G3 scheduler fix yet. More to come.
> 
> I've no plausible explanation for this; perhaps the only possible one
> is that one of the algorithms that was sped up was behaving badly enough
> to interfere with scheduling.

I've also noticed that 2.6.0-test1-wl1A behaves pretty well, given that
no major changes to the CPU scheduler are included.

