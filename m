Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbWI3IgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWI3IgA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 04:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbWI3If7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 04:35:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37535 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750778AbWI3If6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 04:35:58 -0400
Date: Sat, 30 Sep 2006 01:35:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: Re: [patch 00/23]
Message-Id: <20060930013529.4afd6906.akpm@osdl.org>
In-Reply-To: <20060929234435.330586000@cruncher.tec.linutronix.de>
References: <20060929234435.330586000@cruncher.tec.linutronix.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2006 23:58:18 -0000
Thomas Gleixner <tglx@linutronix.de> wrote:

> We are pleased to announce the next version of our "high resolution 
> timers" and "dynticks" patchset, which implements two important features 
> that Linux lacked for many years.

Could we please have a full description of these features?  All we have at
present is "high resolution timers" and "dynticks", which is ludicrously
terse.  Please also describe the design and implementation.  This is basic
stuff for a run-of-the-mill patch, let alone a feature like this one.

I don't believe I can adequately review this work without that information.
I can try, but obviously such a review will not be as beneficial - it can
only cover trivial matters.

With all the work which has gone into this, and with the impact which it
will have upon us all it is totally disproportionate that no more than a
few minutes were spent telling the rest of us what it does and how it
does it.

We've had a lot of problems with timekeeping in recent years, and they have
been hard and slow to solve.  Hence I'd like to set the bar very high on
the maintainability and understandability of this work.  And what I see
here doesn't look really great from that POV.

Thanks.
