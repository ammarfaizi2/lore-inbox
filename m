Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132156AbRACEfU>; Tue, 2 Jan 2001 23:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132176AbRACEfK>; Tue, 2 Jan 2001 23:35:10 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:17673 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S132156AbRACEfA>; Tue, 2 Jan 2001 23:35:00 -0500
Message-ID: <3A52A4D0.8FF34531@Hell.WH8.TU-Dresden.De>
Date: Wed, 03 Jan 2001 05:04:32 +0100
From: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Organization: Dept. Of Computer Science, Dresden University Of Technology
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-prerelease i686)
X-Accept-Language: en, de-DE
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Oops in prune_dcache (2.4.0-prerelease)
In-Reply-To: <Pine.LNX.4.10.10101021946310.1024-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Linus Torvalds wrote:
> 
> The strange thing is that 0x01000000 value, which almost certainly should
> just be NULL. A one-bit error.
> 
> Now, I assume this machine has been historically stable, with no history
> of memory corruption problems.. It's entirely possible (and likely) that
> the one-bit error is due to some wild kernel pointer. Which makes this
> _really_ hard to debug.

Yes the machine is otherwise rock stable, not overclocked and memory timings
are rather conservative. Before the oops the machine had been compiling some
major application for like 5 hours and maybe the excessive stress kicked a
bit somewhere - who knows.

> I'll try to think about it some more, but I'd love to have more reports to
> go on to try to find a pattern..

That's one I can't reproduce. I've just run memtest86 over the entire ram
and it doesn't show any oddities - which doesn't really rule out an
occassional bit-flip due to neutrino storms though ;-)
If someone else has seen something similar lately, it's time to speak up.

-Udo.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
