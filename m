Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136806AbREISRx>; Wed, 9 May 2001 14:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136808AbREISRn>; Wed, 9 May 2001 14:17:43 -0400
Received: from zeus.kernel.org ([209.10.41.242]:47844 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S136806AbREISRd>;
	Wed, 9 May 2001 14:17:33 -0400
Date: Wed, 9 May 2001 20:16:25 +0200 (CEST)
From: Benedikt Eric Heinen <beh@icemark.net>
X-X-Sender: <beh@fenun.icemark.ch>
To: Carles Pina i Estany <is08139@salleURL.edu>
cc: <gmo@broadcom.com>, <linux-kernel@vger.kernel.org>,
        "'linux-tp600@icemark.ch'" <linux-tp600@icemark.ch>
Subject: Re: [Linux/TP600] RE: PCMCIA Cards on 2.4.0
In-Reply-To: <Pine.LNX.4.30.0101201900100.10134-100000@vela.salleURL.edu>
Message-ID: <Pine.LNX.4.33.0105092013150.14739-100000@fenun.icemark.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Well, 2.4.0 does not seem to be able to talk to
> > the card. The first sign of trouble is the lines:
> >
> > cs: socket c13d4800 timed out during reset.
> > 	Try increasing setup_delay.
> >
> > at the point where other kernels say instead:
> >
> > cs: cb_alloc(bus 5): vendor 0x10b7, device 0x5057
> >
> > and so the former does not seem to be able to access
> > the card while the others are happy.


While this "thread" is sort of reallly old now; does anyone have
any more solutions to offer? I only recently tried to upgrade my
TP600 from linux-2.4.0-test6 to 2.4.2... And I am stuck with the
above error. Neither of previously proposed solutions (disable
ACPI and build PCMCIA support into kernel instead of a module)
work. My Xircom 100MB+56k still fails with the above error... :(


Any further ideas, what could be done to "fix" this?


  Benedikt

          By three methods we may learn wisdom:
             First, by reflection which is noblest;
             second, by imitation, which is the easiest;
             and third, by experience, which is the bitterest.
                         - Confucius  (B.C. 551-479)

