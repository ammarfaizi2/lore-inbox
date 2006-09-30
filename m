Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751448AbWI3TP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbWI3TP3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 15:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbWI3TP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 15:15:29 -0400
Received: from www.osadl.org ([213.239.205.134]:42400 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751448AbWI3TP2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 15:15:28 -0400
Subject: Re: [patch 00/23]
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
In-Reply-To: <20060930013529.4afd6906.akpm@osdl.org>
References: <20060929234435.330586000@cruncher.tec.linutronix.de>
	 <20060930013529.4afd6906.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 30 Sep 2006 21:17:24 +0200
Message-Id: <1159643844.9326.831.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-09-30 at 01:35 -0700, Andrew Morton wrote:
> Could we please have a full description of these features?  All we have at
> present is "high resolution timers" and "dynticks", which is ludicrously
> terse.  Please also describe the design and implementation.  This is basic
> stuff for a run-of-the-mill patch, let alone a feature like this one.
> 
> I don't believe I can adequately review this work without that information.
> I can try, but obviously such a review will not be as beneficial - it can
> only cover trivial matters.
> 
> With all the work which has gone into this, and with the impact which it
> will have upon us all it is totally disproportionate that no more than a
> few minutes were spent telling the rest of us what it does and how it
> does it.
> 
> We've had a lot of problems with timekeeping in recent years, and they have
> been hard and slow to solve.  Hence I'd like to set the bar very high on
> the maintainability and understandability of this work.  And what I see
> here doesn't look really great from that POV.

Fair enough. Point taken. We're working on it and on the comments you
gave. Thanks for taking the time to go through it nevertheless.

The OLS proceedings
http://www.linuxsymposium.org/2006/linuxsymposium_procv1.pdf

and the slides of my talk 
http://tglx.de/projects/hrtimers/ols2006-hrtimers.pdf

might also shed some light on the design.

	tglx


