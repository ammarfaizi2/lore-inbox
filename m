Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136253AbRECIxm>; Thu, 3 May 2001 04:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136254AbRECIxc>; Thu, 3 May 2001 04:53:32 -0400
Received: from smtp2.libero.it ([193.70.192.52]:38579 "EHLO smtp2.libero.it")
	by vger.kernel.org with ESMTP id <S136253AbRECIx0>;
	Thu, 3 May 2001 04:53:26 -0400
Message-ID: <3AF11C74.F679F6F8@alsa-project.org>
Date: Thu, 03 May 2001 10:53:08 +0200
From: Abramo Bagnara <abramo@alsa-project.org>
Organization: Opera Unica
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19 i586)
X-Accept-Language: it, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: "David S. Miller" <davem@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: unsigned long ioremap()?
In-Reply-To: <Pine.LNX.4.05.10105030852330.9438-100000@callisto.of.borg> <15089.979.650927.634060@pizda.ninka.net> <3AF10E80.63727970@alsa-project.org> <3AF11211.B226543D@mandrakesoft.com> <3AF11953.54BBE72B@alsa-project.org> <3AF11A7E.9184627C@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> Abramo Bagnara wrote:
> > > > That's indeed the reason to change ioremap prototype for 2.5.
> > >
> > > Say what??
> > >
> >
> > Please give a look
> > http://www.uwsg.indiana.edu/hypermail/linux/kernel/0008.1/0338.html
> > http://www.uwsg.indiana.edu/hypermail/linux/kernel/0008.1/0407.html
> >
> > This was something that already got a wide consent.
> 
> Let's not return unsigned long -- DaveM's suggestion is far better.
> unsigned long is not opaque enough, IMHO.

I'm not sure to understand what's the proposed way to do offsetting:

#define IO_ADDR(cookie, ofs)?
(maybe with #define IO_SADDR(cookie, struct_name, field))
Others?

-- 
Abramo Bagnara                       mailto:abramo@alsa-project.org

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy

ALSA project               http://www.alsa-project.org
It sounds good!
