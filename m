Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129038AbQKFKzD>; Mon, 6 Nov 2000 05:55:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129098AbQKFKyx>; Mon, 6 Nov 2000 05:54:53 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:56906 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129038AbQKFKyg>; Mon, 6 Nov 2000 05:54:36 -0500
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Mon, 6 Nov 2000 10:53:23 +0000 (GMT)
Cc: dwmw2@infradead.org (David Woodhouse), oxymoron@waste.org (Oliver Xymoron),
        kaos@ocs.com.au (Keith Owens), linux-kernel@vger.kernel.org
In-Reply-To: <3A065CDD.BF15B3AC@mandrakesoft.com> from "Jeff Garzik" at Nov 06, 2000 02:25:17 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13sju0-00065u-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Implement a way for a userspace tool to get the correct mixer levels in
> > place at the time the sound hardware is reset, so there are no glitches in
> > the levels, and I'll agree with you.
> 
> Linux-Mandrake's initscripts run aumix on bootup and shutdown, to take
> care of this...

And they don't solve the problem David was talking about. There is a short
deeply unpleasant scream from some soundcards on reload because the card init
and the 0.5-1 second later aumix run dont stop the feedback loop fast enough
when a mic is plugged in

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
