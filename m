Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264216AbRFFWnn>; Wed, 6 Jun 2001 18:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264220AbRFFWnd>; Wed, 6 Jun 2001 18:43:33 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:16008 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S264216AbRFFWnW>; Wed, 6 Jun 2001 18:43:22 -0400
Date: Wed, 6 Jun 2001 16:42:53 -0600
Message-Id: <200106062242.f56Mgrx20007@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: "David S. Miller" <davem@redhat.com>,
        "La Monte H.P. Yarroll" <piggy@em.cig.mot.com>,
        "Matt D. Robinson" <yakker@alacritech.com>,
        linux-kernel@vger.kernel.org, sctp-developers-list@cig.mot.com
Subject: Re: [PATCH] sockreg2.4.5-05 inet[6]_create() register/unregister
 table
In-Reply-To: <Pine.GSO.4.21.0106061832220.10233-100000@weyl.math.psu.edu>
In-Reply-To: <15134.43914.98253.998655@pizda.ninka.net>
	<Pine.GSO.4.21.0106061832220.10233-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> 
> 
> On Wed, 6 Jun 2001, David S. Miller wrote:
> 
> > This allows people to make proprietary implementations of TCP under
> > Linux.  And we don't want this just as we don't want to add a way to
> > allow someone to do a proprietary Linux VM.
> 
> 	Erm... What stops those who want to do such implementations
> from using AF_PACKET and handling the whole thing in userland?

Just that their performance will suck. People are far less likely to
adopt a product (with an "embrace and extend" side effect) if said
product sucks performance.

Besides, it's better if people send patches to speed up our stack,
rather than having a proprietary product. Patches benefit all
mankind. Products benefit the vendor.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
