Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130075AbQKPQjm>; Thu, 16 Nov 2000 11:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131066AbQKPQjc>; Thu, 16 Nov 2000 11:39:32 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:12088 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131055AbQKPQjM>; Thu, 16 Nov 2000 11:39:12 -0500
Subject: Re: [PATCH] pcmcia event thread. (fwd)
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Thu, 16 Nov 2000 16:08:43 +0000 (GMT)
Cc: dwmw2@infradead.org (David Woodhouse), dhinds@valinux.com (David Hinds),
        torvalds@transmeta.com, tytso@valinux.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <3A106F81.FB5BE7F1@mandrakesoft.com> from "Jeff Garzik" at Nov 13, 2000 05:47:29 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13wRag-0007ym-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's purposefully not on Ted's critical list, the official line is "use
> pcmcia_cs external package" if you need i82365 or tcic instead of yenta
> AFAIK.  However... fixing things and being able to support all pcmcia
> and cardbus adapters would be wonderful.

>From a practical point of view that currently means 'delete Linus tree pcmcia
regardless of what you are doing' since the modules from David Hinds and Linus
pcmcia are not 100% binary compatible for all cases.

It isnt possible for anyone to ship a useful system with Linus pcmcia unless
the ISA stuff is fixed

Alan


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
