Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311491AbSCNDMS>; Wed, 13 Mar 2002 22:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311490AbSCNDMI>; Wed, 13 Mar 2002 22:12:08 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:36077 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S311492AbSCNDMA>;
	Wed, 13 Mar 2002 22:12:00 -0500
Date: Wed, 13 Mar 2002 19:11:59 -0800
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4.19-pre3] New wireless driver API part 1
Message-ID: <20020313191159.B14095@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <20020313185915.A14095@bougret.hpl.hp.com> <E16lLnM-0008E8-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16lLnM-0008E8-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Mar 14, 2002 at 03:20:47AM +0000
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2002 at 03:20:47AM +0000, Alan Cox wrote:
> > the new Wireless Extension API to 2.4.X so that they can hack their
> > drivers without having to deal with 2.5.X. This patch just do that, so
> > could you please add that to your tree ?
> 
> Would it be better to leave the patch where said driver people can get it,
> and when they submit drivers needing it (if ever) then merge it ?

	Maybe, maybe not.
	1) Most Wireless LAN driver live outside the kernel. So, their
evolution is somewhat decoupled to the kernel, so the earlier the
patch goes it the better it is for those.
	2) David Gibson, maintainer of the Orinoco driver, told me
that he would merge my new-API orinoco patches in his driver only when
the new API would be in 2.4.x (as you may have noticed, he hasn't
updated 2.5.X for a while). Chicken and Eggs.
	3) Risk is minimal, bloat is minimal. What's the penality of
merging it now ?

	I'm open to suggestions and will do what's best for
everybody. What other people think ?
	But I feel now is a good time (as it seem that 2.4.19 will
have to go through some stabilisation process).

	Thanks for the comment ;-)

	Jean
