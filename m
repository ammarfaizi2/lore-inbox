Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132860AbRDIWM5>; Mon, 9 Apr 2001 18:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132861AbRDIWMr>; Mon, 9 Apr 2001 18:12:47 -0400
Received: from [199.217.175.51] ([199.217.175.51]:3855 "EHLO
	core.federated.com") by vger.kernel.org with ESMTP
	id <S132860AbRDIWMb>; Mon, 9 Apr 2001 18:12:31 -0400
From: Jim Studt <jim@federated.com>
Message-Id: <200104092212.RAA11802@core.federated.com>
Subject: Re: aic7xxx and 2.4.3 failures - fix, it is interrupt routing
In-Reply-To: <Pine.LNX.4.10.10104092009020.397-100000@linux.local> from "[G_rard
 Roudier]" at "Apr 9, 2001 08:14:51 pm"
To: "[G_rard Roudier]" <groudier@club-internet.fr>
Date: Mon, 9 Apr 2001 17:12:17 -0500 (CDT)
CC: Jim Studt <jim@federated.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

G*rard Roudier insightfully opined..
> Looks like an IRQ problem to me.
> I mean the kernel wants to change IRQ routing and just do the wrong job.

Give the man a prize!  

After failing to work with 2.4.0, 2.4.1, 2.4.3, and 2.4.3-ac3 I
enabled X86_UP_IOAPIC to stir up the interrupt code and it works.

I'll keep one of these servers set aside for testing and see if I can't
figure out a little more specifically what the problem is, but IOAPIC
is fine.  

Thanks for the help all!

-- 
                                     Jim Studt, President
                                     The Federated Software Group, Inc.
