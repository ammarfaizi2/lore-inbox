Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131879AbRALT6N>; Fri, 12 Jan 2001 14:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132348AbRALT5x>; Fri, 12 Jan 2001 14:57:53 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:34053 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131879AbRALT5t>; Fri, 12 Jan 2001 14:57:49 -0500
Date: Fri, 12 Jan 2001 11:57:37 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: ide.2.4.1-p3.01112001.patch
In-Reply-To: <20010112204626.A2740@suse.cz>
Message-ID: <Pine.LNX.4.10.10101121151560.3010-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 12 Jan 2001, Vojtech Pavlik wrote:
> 
> I've got a vt82c586 here (bought it just for testing of this problem),
> and I wasn't able to create any corruption using that board and the 2.4
> drivers.

The fact that it works on one board doesn't mean that it works on _every_
board.

This is, in fact, why I will _NOT_ accept anything but a simple auto-dma
disable for this problem for early 2.4.x. I hope that people will continue
to work on and debug this problem, but it's just been around for too long,
and it's obvious enough that it doesn't happen with all hardware that I
doubt there is any other reasonable solution that doesn't require some
_very_ extensive testing to verify.

I'd love to see people who see these problems and are willing to test out
patches to fix it. But in parallel with that, I definitely want the 2.2.x
"disable auto-DMA" thing for the big public. We can enable it later if
some patch does seem to fix it for good.

			Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
