Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129323AbRCBRRQ>; Fri, 2 Mar 2001 12:17:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129339AbRCBRRG>; Fri, 2 Mar 2001 12:17:06 -0500
Received: from ns1.uklinux.net ([212.1.130.11]:59663 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S129323AbRCBRQ6>;
	Fri, 2 Mar 2001 12:16:58 -0500
Envelope-To: linux-kernel@vger.redhat.com
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200103021631.QAA01076@raistlin.arm.linux.org.uk>
Subject: Re: Another rsync over ssh hang (repeatable, with 2.4.1 on both ends)
To: kuznet@ms2.inr.ac.ru
Date: Fri, 2 Mar 2001 16:31:07 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200103021547.SAA16651@ms2.inr.ac.ru> from "kuznet@ms2.inr.ac.ru" at Mar 02, 2001 06:47:18 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kuznet@ms2.inr.ac.ru writes:
> Russel, you are warned that kernels<2.2.17 and rsync is an incompatible
> combination.

So, what you're saying is that because these kernels have known problems
with rsync, the fact that my symptoms on 2.4.0 are 100% _precisely_ the
same means its not the same bug?

In addition, the fact that the tcp _retries_ indicate that both sides
are behaving correctly _in this instance_ means that its not a 2.4 bug?

If you still insist that it is purely a 2.2.15pre13 bug dispite the
growing evidence against this, then I shall see if I can get everything
together to put 2.2.18 on this machine.  I can't guarantee when I'll
be able to do this though.

Also, as I pointed out, since the machines are 40+ miles away for
most of the week, and are without a reasonable net connection, I
can only comment on what is _currently_ running, and I thought it at
least useful to indicate that both my and Scott symptoms are identical.

PS, could you please spell my name correctly?

PPS, rather than arguing about this, can people proceed to investigate
Scotts problem, and I'll "tag along" to see if my problem gets fixed.
Thanks.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

