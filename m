Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272244AbRJCJ3t>; Wed, 3 Oct 2001 05:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272092AbRJCJ3m>; Wed, 3 Oct 2001 05:29:42 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:39942 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S271906AbRJCJ33>; Wed, 3 Oct 2001 05:29:29 -0400
Message-ID: <3BBADA6A.A8AA51A8@idb.hist.no>
Date: Wed, 03 Oct 2001 11:29:14 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.4.11-pre2 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <Pine.LNX.4.33.0110031025530.1694-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

> 500 MHz PIII UP server, 433 MHz client over a single 100 mbit ethernet
> using Simon Kirby's udpspam tool to overload the server. Result: 2.4.10
> locks up before the patch. 2.4.10 with the first generation irqrate patch
> applied protects against the lockup (if max_rate is correct), but results
> in dropped packets. The auto-tuning+polling patch results in a working
> system and working network, no lockup and no dropped packets. Why this
> happened and how it happened has been discussed extensively.

I hope we get some variant of this in 2.4.  A device callback
stopping rx interrupts only is of course even better, but
won't that be 2.5 stuff?

Helge Hafting
