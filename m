Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318974AbSHNJJh>; Wed, 14 Aug 2002 05:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319015AbSHNJJg>; Wed, 14 Aug 2002 05:09:36 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:11176 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S318974AbSHNJJg>; Wed, 14 Aug 2002 05:09:36 -0400
Date: Wed, 14 Aug 2002 10:14:39 +0100
From: Tim Waugh <twaugh@redhat.com>
To: Marek Michalkiewicz <marekm@amelek.gda.pl>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: parport_serial / serial init order wrong?
Message-ID: <20020814091439.GN2218@redhat.com>
References: <20020805225805.C16793@flint.arm.linux.org.uk> <E17euC0-0000Bs-00@alf.amelek.gda.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Tl2A+1bu5ZCdBkzL"
Content-Disposition: inline
In-Reply-To: <E17euC0-0000Bs-00@alf.amelek.gda.pl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Tl2A+1bu5ZCdBkzL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 14, 2002 at 11:11:52AM +0200, Marek Michalkiewicz wrote:

> How about making register_serial() initialize the serial driver by
> calling rs_init(), if it was not initialized yet?  Works for me -
> see below.  Do you see any problems with this?

What are the bad effects of having rs_init called twice during
boot-up?

Tim.
*/

--Tl2A+1bu5ZCdBkzL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9Wh9+yaXy9qA00+cRAmyMAKCw+6iR8fWXs+y9yFfZQio02yOGhACbBITs
6knp1VRmfRnAQSQ7J13zZxs=
=VIHk
-----END PGP SIGNATURE-----

--Tl2A+1bu5ZCdBkzL--
