Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311922AbSCODhU>; Thu, 14 Mar 2002 22:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311923AbSCODhJ>; Thu, 14 Mar 2002 22:37:09 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:25098 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S311922AbSCODgv>;
	Thu, 14 Mar 2002 22:36:51 -0500
Date: Fri, 15 Mar 2002 13:43:00 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: jt@hpl.hp.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4.19-pre3] New wireless driver API part 1
Message-ID: <20020315024300.GC1289@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Jeff Garzik <jgarzik@mandrakesoft.com>, jt@hpl.hp.com,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20020313185915.A14095@bougret.hpl.hp.com> <E16lLnM-0008E8-00@the-village.bc.nu> <20020313191159.B14095@bougret.hpl.hp.com> <3C9015D2.4060108@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C9015D2.4060108@mandrakesoft.com>
User-Agent: Mutt/1.3.27i
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

> >	2) David Gibson, maintainer of the Orinoco driver, told me
> >that he would merge my new-API orinoco patches in his driver only when
> >the new API would be in 2.4.x (as you may have noticed, he hasn't
> >updated 2.5.X for a while). Chicken and Eggs.
> >
> Does that mean orinoco updates are coming for 2.5.x?

Yes, I'll try to send some in.  When 2.5 had just started I figured
Linus was busy enough with the bio stuff and the driver updates could
wait, since then I've been busy with other things so I haven't gotten
around to sending patches.

AFAIK none of the APIs which are relevant to me have changed so it
should just be a matter of copying the files across from 2.4.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

