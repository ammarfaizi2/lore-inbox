Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264690AbSJaJR3>; Thu, 31 Oct 2002 04:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264773AbSJaJR3>; Thu, 31 Oct 2002 04:17:29 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:36540 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S264690AbSJaJR2>;
	Thu, 31 Oct 2002 04:17:28 -0500
Date: Thu, 31 Oct 2002 10:23:32 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ville Herva <vherva@niksula.hut.fi>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: What's left over.
In-Reply-To: <20021031074604.GE2849@niksula.cs.hut.fi>
Message-ID: <Pine.GSO.4.21.0210311021240.15053-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Oct 2002, Ville Herva wrote:
> On Wed, Oct 30, 2002 at 06:31:36PM -0800, you [Linus Torvalds] wrote:
> > > Crash Dumping (LKCD)
> > 
> > This is definitely a vendor-driven thing. I don't believe it has any 
> > relevance unless vendors actively support it.
> 
> I don't think this is just a vendor thing. Currently, linux doesn't have any
> way of saving the crash dump when the box crashes. So if it crashes, the
> user needs to write the oops down by hand (error prone, the interesting part
> has often scrolled off screen), or attach a serial console (then he needs to
> reproduce it - not always possible, and actually majority of people (home
> users) don't have second box and the cable. Nor the motivation.)

Except on m68k, where we've had a feature to store all kernel messages in an
unused portion of memory (e.g. some Chip RAM on Amiga) and recover them after
reboot since ages.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

