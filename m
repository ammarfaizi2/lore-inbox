Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267248AbTBUIzF>; Fri, 21 Feb 2003 03:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267252AbTBUIzF>; Fri, 21 Feb 2003 03:55:05 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:21923 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S267248AbTBUIzE>;
	Fri, 21 Feb 2003 03:55:04 -0500
Date: Fri, 21 Feb 2003 10:04:19 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "David S. Miller" <davem@redhat.com>
cc: James Simmons <jsimmons@infradead.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] Re: FBdev updates.
In-Reply-To: <1045791900.21577.5.camel@rth.ninka.net>
Message-ID: <Pine.GSO.4.21.0302211003250.9232-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Feb 2003, David S. Miller wrote:
> On Thu, 2003-02-20 at 11:58, James Simmons wrote:
> > > (3) persuade me that I want to write matroxcon and forget about fbcon at all, or
> > 
> > This is the best solution. 

Huh?

> And then we will have sbuscon as well, thus two places where
> putcs() is necessary.
> 
> I don't understand, but I do hope that at some point it will be
> realized that maybe allowing fbcon to generically handle putcs()
> hardware is beneficial.
> 
> I can dream. :-)

Don't worry, tile blitting will be there (eventually)...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

