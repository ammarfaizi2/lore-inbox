Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270544AbTGZSCu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 14:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270575AbTGZSCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 14:02:50 -0400
Received: from holomorphy.com ([66.224.33.161]:60348 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S270544AbTGZSCs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 14:02:48 -0400
Date: Sat, 26 Jul 2003 11:19:13 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       LKML <linux-kernel@vger.kernel.org>, kernel@kolivas.org, mingo@elte.hu
Subject: Re: Ingo Molnar and Con Kolivas 2.6 scheduler patches
Message-ID: <20030726181913.GY15452@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Marc-Christian Petersen <m.c.p@wolk-project.de>,
	Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
	LKML <linux-kernel@vger.kernel.org>, kernel@kolivas.org,
	mingo@elte.hu
References: <1059211833.576.13.camel@teapot.felipe-alfaro.com> <200307261142.43277.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307261142.43277.m.c.p@wolk-project.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 26, 2003 at 11:46:45AM +0200, Marc-Christian Petersen wrote:
> Now that I've tested 2.6.0-test-1-wli (William Lee Irwin's Tree) for over a 
> week, I thought about, that the problem might _not_ be only the O(1) 
> Scheduler, because -wli has changed almost nothing to the scheduler stuff, 
> it's almost 2.6.0-test1 code and running that kernel, my system is _alot_ 
> more responsive than 2.6.0-test1 or 2.6.0-test1-mm* or all the Oxint 
> scheduler fixes have ever been.
> Strange no?
> P.S.: I've not tested Ingo's G3 scheduler fix yet. More to come.

I've no plausible explanation for this; perhaps the only possible one
is that one of the algorithms that was sped up was behaving badly enough
to interfere with scheduling.


-- wli
