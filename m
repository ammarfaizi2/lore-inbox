Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261334AbTDCQXc>; Thu, 3 Apr 2003 11:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261326AbTDCQXc>; Thu, 3 Apr 2003 11:23:32 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:5287 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S261334AbTDCQXa>;
	Thu, 3 Apr 2003 11:23:30 -0500
Date: Thu, 3 Apr 2003 18:33:17 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Sven Luther <luther@dpt-info.u-strasbg.fr>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       James Simmons <jsimmons@infradead.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [PATCH]: EDID parser
In-Reply-To: <1049383273.11742.0.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.GSO.4.21.0304031831030.23642-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 Apr 2003, Alan Cox wrote:
> On Iau, 2003-04-03 at 15:15, Sven Luther wrote:
> > > Read is not enough. If you have connected one /dev/fbx to two monitors,
> > > you must find highest common denominator for them, and use this one.
> > 
> > Err, i don't understand this ? Do you mean you are outputing to two
> > monitors at the same time ?
> 
> I think you mean lowest common denominator.
> 
> > If that is so maybe you mean, speaking in graphic card terminology, and
> > not in fbdev one, that you are sharing one common framebuffer between
> > two outputs, right, possibly doing mirroring tricks or something such ?
> 
> Classic example is a SiS 6326 driving monitor and TV. You need to keep
> the display to TV acceptable ranges.

I don't know whether that's a good example...

I assume the signal for the TV is different from the signal for the monitor
(these days you don't find many monitors that do 15.6 kHz / 50 Hz)? In that
case it's just the resolution that has to be more or less compatible.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

