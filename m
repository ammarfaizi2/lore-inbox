Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136914AbRAHL4X>; Mon, 8 Jan 2001 06:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136963AbRAHL4O>; Mon, 8 Jan 2001 06:56:14 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:29459 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136914AbRAHL4A>; Mon, 8 Jan 2001 06:56:00 -0500
Subject: Re: DHCP Problems with 3com 3c905C Tornado
To: andrewm@uow.edu.au (Andrew Morton)
Date: Mon, 8 Jan 2001 11:56:19 +0000 (GMT)
Cc: timw@splhi.com, chris@gidayu.max.uni-duisburg.de (Christian Loth),
        linux-kernel@vger.kernel.org
In-Reply-To: <3A598474.3A69C684@uow.edu.au> from "Andrew Morton" at Jan 08, 2001 08:12:20 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14FauT-0004Nn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Obviously, something changed between 2.2.14 and more current
> kernels which broke pump.  I don't believe it's a driver change
> because it also affects the 3c90x driver.  I don't have a theory
> as to why this affects the 3com NICs though.  But I'm assuming
> that whatever broke pump also broke dhcpcd.

The classic thing that pump catches drivers with is that interface goes
up/down/up in rapid succession. That broke the acenic driver at one point 
too

> I note that with 3c59x in 2.4.0, pump-0.7.3 basically freezes up.
> It spits out a single bootp packet then goes to lunch.  I got
> bored waiting after ten minutes. So an upgrade is definitely needed.

strace would be interesting

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
