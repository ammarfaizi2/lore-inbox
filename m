Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284985AbRLaWbg>; Mon, 31 Dec 2001 17:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287673AbRLaWb0>; Mon, 31 Dec 2001 17:31:26 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:7186 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S284985AbRLaWbJ>;
	Mon, 31 Dec 2001 17:31:09 -0500
Date: Mon, 31 Dec 2001 20:31:12 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: James Simmons <jsimmons@transvirtual.com>
Cc: Scott McDermott <vaxerdec@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Framebuffer...Why oh Why???
Message-ID: <20011231203112.A16975@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	James Simmons <jsimmons@transvirtual.com>,
	Scott McDermott <vaxerdec@conectiva.com.br>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011231195655.A16870@conectiva.com.br> <Pine.LNX.4.10.10112311425020.12522-100000@www.transvirtual.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10112311425020.12522-100000@www.transvirtual.com>
User-Agent: Mutt/1.3.23i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Dec 31, 2001 at 02:26:04PM -0800, James Simmons escreveu:
> 
> > > Text mode is slow and has poor resolution, yes even svga text mode stuff
> > > is way slower than accelerated fbconsole for me, I don't like having to
> > > wait for the screen to update when I page a file and go to the next
> > > page.
> > 
> > ouch, this hasn't been the case for me for ages, maybe I should try this
> > accelerated fbconsole thing again...
> 
> Which framebuffer driver? Soem are good and some suck. Vesafb is really
> bad. It far better to use a native card dr4iver if it is avaliable.

My card is a Neomagic, so I use vesafb...

Please let me know if somebody has specs for:

00:08.0 VGA compatible controller: Neomagic Corporation NM2160 [MagicGraph
128XD] (rev 01)

If they're enough to write a fb driver for this card... Well, I can try and
write a driver. 8)

Humm, there are XFree86 drivers (that sucks lately, but I'm lazy so maybe
its my fault)...

- Arnaldo
