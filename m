Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131233AbRDNINy>; Sat, 14 Apr 2001 04:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131246AbRDNINo>; Sat, 14 Apr 2001 04:13:44 -0400
Received: from hood.tvd.be ([195.162.196.21]:49187 "EHLO hood.tvd.be")
	by vger.kernel.org with ESMTP id <S131233AbRDNINd>;
	Sat, 14 Apr 2001 04:13:33 -0400
Date: Sat, 14 Apr 2001 10:12:30 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Nate Eldredge <neldredge@hmc.edu>
cc: linux-kernel@vger.kernel.org, lomarcan@tin.it
Subject: Re: SCSI Tape Corruption - update 2
In-Reply-To: <15063.8582.293619.762113@mercury.st.hmc.edu>
Message-ID: <Pine.LNX.4.05.10104141011180.6109-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Apr 2001, Nate Eldredge wrote:
> lomarcan@tin.it wrote:
> > Well, the 2.2 distributed with Mandrake 7.2 works fine ... :) 
> >
> > Hmmm... 32 CONSECUTIVE bytes are a very peculiar error. What can it be? 
> >
> > Still experimenting...
> 
> I once ran into a problem with 32-byte errors appearing in files, and
> later, in memory.  I eventually traced it to buggy motherboard cache.
> (32 bytes is the size of a cache line.)  A memory tester might be
> something to try (I wrote a simple program that seemed to show the
> error better than memtest86; can send it if desired.)

In that case I'd expect the problem to show up when doing whatever. So far I
could not find corrupted files on my hard disk, only when writing to tape, and
only with 2.3/2.4.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

