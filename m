Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276917AbRJHPHY>; Mon, 8 Oct 2001 11:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276919AbRJHPHO>; Mon, 8 Oct 2001 11:07:14 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:38925 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276339AbRJHPHJ>; Mon, 8 Oct 2001 11:07:09 -0400
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Mon, 8 Oct 2001 16:12:53 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), andrea@suse.de (Andrea Arcangeli),
        mingo@elte.hu (Ingo Molnar), hadi@cyberus.ca (jamal),
        linux-kernel@vger.kernel.org (Linux-Kernel), netdev@oss.sgi.com,
        torvalds@transmeta.com (Linus Torvalds)
In-Reply-To: <Pine.LNX.3.96.1011008100030.13807A-100000@mandrakesoft.mandrakesoft.com> from "Jeff Garzik" at Oct 08, 2001 10:03:57 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15qc5N-0000p5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think (Ingo's?) analogy of an airbag was appropriate, if that's indeed
> how the code winds up functioning.

Very much so

"Driver killed because the air bag enable is off by default and only
mentioned on page 87 of the handbook in a footnote"

> Having a mechanism that prevents what would otherwise be a lockup is
> useful.  NAPI is useful.  Having both would be nice :)

NAPI is important - the irq disable tactic is a last resort. If the right
hardware is irq flood aware it should only ever trigger to save us from
irq routing errors (eg cardbus hangs) 
