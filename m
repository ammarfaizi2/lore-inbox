Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129033AbRBAAvo>; Wed, 31 Jan 2001 19:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129064AbRBAAvf>; Wed, 31 Jan 2001 19:51:35 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:51674 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129033AbRBAAv2>; Wed, 31 Jan 2001 19:51:28 -0500
Message-ID: <3A78B4B3.56EB5C28@uow.edu.au>
Date: Thu, 01 Feb 2001 11:58:27 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Manfred Spraul <manfred@colorfullife.com>,
        Ingo Molnar <mingo@chiara.elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.0, 2.4.0-ac12: APIC lock-ups
In-Reply-To: <3A75D533.7F3F4019@colorfullife.com> <Pine.GSO.3.96.1010130111824.678C-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Maciej W. Rozycki" wrote:
> 
>  Following is the 82489DX-ized version of the patch.  I believe it's fine,
> but I would feel safer if others test it before I send it to Linus.

Your latest patch passes all my testing.

2.4.1+irq-whacker+netperf:        APIC dies instantly
2.4.1+irq-whacker+netperf+patch:  8 million interrupts, then I got bored.

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
