Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263016AbTDNNc4 (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 09:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263017AbTDNNc4 (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 09:32:56 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:46298 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id S263016AbTDNNcz (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 09:32:55 -0400
Date: Mon, 14 Apr 2003 15:44:48 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Paul Mackerras <paulus@samba.org>, Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] M68k IDE updates
In-Reply-To: <1050322915.25353.38.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.GSO.4.21.0304141544130.28305-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 Apr 2003, Alan Cox wrote:
> On Llu, 2003-04-14 at 09:39, Geert Uytterhoeven wrote:
> > Indeed. Ataris and Q40/Q60s have byteswapped IDE busses, but they expect
> > on-disk data to be that way, for compatibility with e.g. TOS.
> 
> That is a higher level problem. You need a byteswap mode for the loop device
> it seems. Then you can read atari disks on any box..

You're talking about a different problem.

We want to read Atari disks on Ataris, too.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

