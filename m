Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130529AbQLOAhi>; Thu, 14 Dec 2000 19:37:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135305AbQLOAh3>; Thu, 14 Dec 2000 19:37:29 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:48648 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130529AbQLOAhI>; Thu, 14 Dec 2000 19:37:08 -0500
Date: Thu, 14 Dec 2000 16:06:01 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Stephen Frost <sfrost@snowman.net>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Netfilter <netfilter@us5.samba.org>
Subject: Re: test13-pre1 changelog
In-Reply-To: <20001214185620.P26953@ns>
Message-ID: <Pine.LNX.4.10.10012141603100.12695-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 14 Dec 2000, Stephen Frost wrote:
> 
> 	This go around I compiled everything into the kernel, actually.
> If it would be useful I can compile them as modules reboot and then see
> what happens...

Even when compiled into the kernel, you might just ifdown/ifup the device.
That will re-initialize most of the driver state.

Is this ppp over serial.c, or what?

			Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
