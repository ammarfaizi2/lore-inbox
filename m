Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130176AbRBZGaL>; Mon, 26 Feb 2001 01:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130174AbRBZGaD>; Mon, 26 Feb 2001 01:30:03 -0500
Received: from alto.i-cable.com ([210.80.60.4]:10942 "EHLO alto.i-cable.com")
	by vger.kernel.org with ESMTP id <S130177AbRBZG3v>;
	Mon, 26 Feb 2001 01:29:51 -0500
Message-ID: <3A99F7D7.E5191DC0@hkicable.com>
Date: Mon, 26 Feb 2001 14:29:43 +0800
From: Thomas Lau <lkthomas@hkicable.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-ac3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.2-ac4: eth0: interrupt(s) dropped!
In-Reply-To: <20010225221643.Y22028@etna.cs.washington.edu> <3A99F7B4.F093CFB1@hkicable.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Lau wrote:

> Justin Huff wrote:
>
> > I'm getting this in my syslog:
> >
> > Feb 25 21:51:35 chimborazo kernel: eth0: interrupt(s) dropped!
> > Feb 25 21:52:04 chimborazo last message repeated 2 times
> > Feb 25 21:56:35 chimborazo kernel: NETDEV WATCHDOG: eth0: transmit timed
> > out
> > Feb 25 21:56:37 chimborazo kernel: NETDEV WATCHDOG: eth0: transmit timed
> > out
> > Feb 25 21:56:39 chimborazo kernel: eth0: interrupt(s) dropped!
> > Feb 25 21:56:48 chimborazo last message repeated 4 times
> > Feb 25 21:56:50 chimborazo kernel: NETDEV WATCHDOG: eth0: transmit timed
> > out
> > Feb 25 21:56:58 chimborazo last message repeated 4 times
> > Feb 25 22:01:08 chimborazo kernel: NETDEV WATCHDOG: eth0: transmit timed
> > out
> > Feb 25 22:01:18 chimborazo kernel: eth0: interrupt(s) dropped!
> > Feb 25 22:01:24 chimborazo kernel: eth0: interrupt(s) dropped!
> >
> > I have CONFIG_APL_ALLOW_INTS set.  The NIC is a ne2k based pcmcia card.
> > I'm running 2.4.2-ac4, but this has been happening since 2.4.1.
> > Ideas?
> >
> > --Justin
> >
>
> Well, I am using NE2000-PCI
> you got same problem?
> me too, it will drop eth0, I must use ifconfig to bring up eth0 again or
> reboot linux
> I noticed to alan before, but no reply for this problem.
> anyone have same problem ?
>
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/

