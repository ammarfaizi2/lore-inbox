Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266907AbRGHW32>; Sun, 8 Jul 2001 18:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266031AbRGHW3S>; Sun, 8 Jul 2001 18:29:18 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:13573 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265975AbRGHW3E>; Sun, 8 Jul 2001 18:29:04 -0400
Subject: Re: Why Plan 9 C compilers don't have asm("")
To: yodaiken@fsmlabs.com (Victor Yodaiken)
Date: Sun, 8 Jul 2001 23:28:59 +0100 (BST)
Cc: torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <20010708155518.A23324@hq2> from "Victor Yodaiken" at Jul 08, 2001 03:55:18 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15JN2x-0000kq-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That seems amazingly dumb. You'd think a new processor design would
> optimize parallel computation over calls, but what do I know?

They try to. Take a look at the trace cache on the Pentium IV. They certainly
seem to have badly screwed the chip design up elsewhere but the trace cache
has some very clever ideas in it

> were so damn obstinate about "every instruction fits in 32 bits"
> and refused to have "call 32 bit immediate given in next word" not
> to mention a "load 32bit immediate given in next word".
> Note, the superior x86 instruction set has a 5 byte call immediate.

Some do. After all there is nothing unrisc about

	call [ip]++

Maybe the idea died with the PDP-11 designers 8)

Alan

