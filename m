Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311496AbSCND0T>; Wed, 13 Mar 2002 22:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311498AbSCND0A>; Wed, 13 Mar 2002 22:26:00 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:55024 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S311496AbSCNDZq>;
	Wed, 13 Mar 2002 22:25:46 -0500
Date: Wed, 13 Mar 2002 19:25:44 -0800
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4.19-pre3] New wireless driver API part 1
Message-ID: <20020313192544.D14095@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <20020313185915.A14095@bougret.hpl.hp.com> <E16lLnM-0008E8-00@the-village.bc.nu> <20020313191159.B14095@bougret.hpl.hp.com> <3C9015D2.4060108@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C9015D2.4060108@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Wed, Mar 13, 2002 at 10:15:30PM -0500
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2002 at 10:15:30PM -0500, Jeff Garzik wrote:
> Jean Tourrilhes wrote:
> 
> >1) Most Wireless LAN driver live outside the kernel. So, their
> >evolution is somewhat decoupled to the kernel, so the earlier the
> >patch goes it the better it is for those.
> >
> As you may have gathered from my last email, this is a bit annoying when 
> trying to find and stabalize a driver for a card you just got :)

	Especially that there are so many driver to choose from, and
each is broken in some unique way.

> >	2) David Gibson, maintainer of the Orinoco driver, told me
> >that he would merge my new-API orinoco patches in his driver only when
> >the new API would be in 2.4.x (as you may have noticed, he hasn't
> >updated 2.5.X for a while). Chicken and Eggs.
> >
> Does that mean orinoco updates are coming for 2.5.x?

	I asked him a couple of times, but so far nothing. He is
working hard on various issues in the driver.

> Any idea if the other drivers are getting updates too, like airo?

	I think the CVS has a new version, including change to the
monitoring mode, but airo list is pretty quiet lately. airo.c is
pretty stable and bug free, so updates are not critical. I still need
to finish to convert it to the new API.

> My standard rule of thumb is turning out to be, deploy something 
> 2.4.x-worthy in 2.5.x, wait a while, and then deploy it in 2.4.x.  I 
> have no particular opinion about whether your patch should go in -right 
> now- but it seems like a fair patch for 2.4.x sooner or later.

	Yes, you are right, it has been in 2.5.X for only two months,
which is quite short.

>     Jeff

	Have fun...

	Jean
