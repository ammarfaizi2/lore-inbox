Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267350AbRGQVeb>; Tue, 17 Jul 2001 17:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267384AbRGQVeV>; Tue, 17 Jul 2001 17:34:21 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:46863 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267350AbRGQVeL>; Tue, 17 Jul 2001 17:34:11 -0400
Date: Tue, 17 Jul 2001 14:33:02 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Martin Murray <mmurray@deepthought.org>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: yenta_socket hangs sager laptop in kernel 2.4.6
In-Reply-To: <Pine.LNX.4.21.0107171610120.31029-100000@cobalt.deepthought.org>
Message-ID: <Pine.LNX.4.33.0107171432020.1949-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 17 Jul 2001, Martin Murray wrote:
>
> > And I bet you don't have a driver that knows about it.
>
> You know. 2.2.19 uses my cardbus controller on IRQ 11 without a
> problem.

Does it actually _use_ the cardbus PCI interrupt at all? At least older
versions of the external pcmcia package didn't use the PCI interrupt by
default at all, and relied on polling the state and the old ISA interrupts
instead..

		Linus

