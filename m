Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271609AbTGRLdq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 07:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271616AbTGRLdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 07:33:46 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:43769 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S271609AbTGRLdp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 07:33:45 -0400
Date: Fri, 18 Jul 2003 13:48:39 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PATCH: typo bits
In-Reply-To: <1058528165.19558.3.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.GSO.4.21.0307181346130.22944-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Jul 2003, Alan Cox wrote:
> > > -  dep_tristate '  SL811HS Alternate (support isochornous mode)' CONFIG_USB_SL811HS_ALT $CONFIG_USB
> > > +   dep_tristate '  SL811HS Alternate (support isosynchronous mode)' CONFIG_USB_SL811HS_ALT $CONFIG_USB
> > >  fi
> > > diff -Nru a/drivers/usb/host/sl811.c b/drivers/usb/host/sl811.c
> > > --- a/drivers/usb/host/sl811.c	Thu Jul 17 11:07:46 2003
> > > +++ b/drivers/usb/host/sl811.c	Thu Jul 17 11:07:46 2003
> > > @@ -9,7 +9,7 @@
> > >   * 	  Adam Richter, Gregory P. Smith;
> > >    	2.Original SL811 driver (hc_sl811.o) by Pei Liu <pbl@cypress.com>
> > >   *
> > > - * It's now support isochronous mode and more effective than hc_sl811.o
> > > + * It's now support isosynchronous mode and more effective than hc_sl811.o
> > 
> > I thought the correct term was `isochronous'...
> 
> Perhaps someone can clarify - however isochornus is definitely wrong either way

Yes, isochornus is wrong.

Just try dict:

  - No definitions found for "isosynchronous"

  - 2 definitions found

    From Webster's Revised Unabridged Dictionary (1913) [web1913]:

      Isochronous \I*soch"ro*nous\, a. [Gr. ?; ? equal + ? time.]
	 Same as {Isochronal}.

    From The Free On-line Dictionary of Computing (09 FEB 02) [foldoc]:

      isochronous
      
	 <communications> /i:-sok'rn-*s/ A form of data transmission
	 that guarantees to provide a certain minimum {data rate}, as
	 required for time-dependent data such as {video} or {audio}.
      
	 Isochronous transmission transmits asynchronous data over a
	 synchronous data link so that individual characters are only
	 separated by a whole number of bit-length intervals.  This is
	 in contrast to {asynchronous} transmission, in which the
	 characters may be separated by arbitrary intervals, and with
	 {synchronous} transmission [which does what?].
      
	 {Asynchronous Transfer Mode} and {High Performance Serial Bus}
	 can provide isochronous service.
      
	 Compare: {plesiochronous}.
      
	 [ANIXTER, LAN Magazine 7.93]
      
	 [Better explanation?]
      
	 (1999-03-12)


Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

