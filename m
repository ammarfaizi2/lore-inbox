Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131055AbRABSFj>; Tue, 2 Jan 2001 13:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131199AbRABSFa>; Tue, 2 Jan 2001 13:05:30 -0500
Received: from colorfullife.com ([216.156.138.34]:51470 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S131055AbRABSF0>;
	Tue, 2 Jan 2001 13:05:26 -0500
Message-ID: <3A52113E.755A5AB4@colorfullife.com>
Date: Tue, 02 Jan 2001 18:34:54 +0100
From: Manfred <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: gf435@gmx.net, linux-kernel@vger.kernel.org
Subject: Re: kernel freeze on 2.4.0.prerelease (smp,raid5)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No oops, nothing in the logs after reboot with 240t13p3. 
>
>Perhaps someone has an idea where to dig? 
>
> ps: Here is my short system description: 
>
> Dual Celeron (SMP) 

Perhaps a deadlock with a normal (not irq) spinlock.

Could you enable SysRQ and press <Alt>+<SysRq>+<P> ("showPc")
Then write down the EIP values (including the [< >] brackets) and
translate them with ksymoops.

See Documentation/sysrq.txt and oops-tracing.txt.

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
