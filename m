Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273520AbRIUNQx>; Fri, 21 Sep 2001 09:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273511AbRIUNQm>; Fri, 21 Sep 2001 09:16:42 -0400
Received: from ns.ithnet.com ([217.64.64.10]:44811 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S273509AbRIUNQd>;
	Fri, 21 Sep 2001 09:16:33 -0400
Date: Fri, 21 Sep 2001 15:16:40 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch] Re: 2.4.10-pre13 still problems with tty_register_ldisc export
Message-Id: <20010921151640.30f85132.skraw@ithnet.com>
In-Reply-To: <3BAB376C.18BD7664@eyal.emu.id.au>
In-Reply-To: <20010921130945.2eed67d6.skraw@ithnet.com>
	<3BAB376C.18BD7664@eyal.emu.id.au>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Sep 2001 22:49:48 +1000 Eyal Lebedinsky <eyal@eyal.emu.id.au> wrote:

> Stephan von Krawczynski wrote:
> > 
> > depmod: *** Unresolved symbols in
> > /lib/modules/2.4.10-pre13/kernel/drivers/net/ppp_async.o
> > depmod:         tty_register_ldisc
> > depmod: *** Unresolved symbols in
> > /lib/modules/2.4.10-pre13/kernel/drivers/net/ppp_synctty.o
> > depmod:         tty_register_ldisc
> 
> I think drivers/char/tty_io.c should export it.

With "should" you mean, it doesn't currently? In fact it really doesn't. Did
Linus get a patch? 

