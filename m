Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317257AbSGCVlJ>; Wed, 3 Jul 2002 17:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317258AbSGCVlI>; Wed, 3 Jul 2002 17:41:08 -0400
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:47627 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S317257AbSGCVlI>; Wed, 3 Jul 2002 17:41:08 -0400
Date: Wed, 3 Jul 2002 14:43:29 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-usb-devel@lists.sourceforge.net, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: usb storage cleanup
Message-ID: <20020703144329.D8033@one-eyed-alien.net>
Mail-Followup-To: Manfred Spraul <manfred@colorfullife.com>,
	linux-usb-devel@lists.sourceforge.net, greg@kroah.com,
	linux-kernel@vger.kernel.org
References: <3D236950.5020307@colorfullife.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="OaZoDhBhXzo6bW1J"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D236950.5020307@colorfullife.com>; from manfred@colorfullife.com on Wed, Jul 03, 2002 at 11:14:56PM +0200
Organization: One Eyed Alien Networks
X-Copyright: (C) 2002 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OaZoDhBhXzo6bW1J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I don't understand what this patch is trying to do...

You're reverting our new state machine changes... why?

You're reverting the new mechanism to determine device state... why?

You're removing the entire bus_reset() logic... why?

This patch undoes most of the work done in the last few months.  I
_strongly_ oppose the patch without some better explanations.

About the only think I agree with is the addition of some BUG_ON() calls.

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

I need a computer?
					-- Customer
User Friendly, 2/19/1998

--OaZoDhBhXzo6bW1J
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9I3ABIjReC7bSPZARAhjmAJ4guuiPvb9E1V3fJxW5w1WHqyxjIQCgiQ6O
r0qEhSIfWu81rcVe6aD31l8=
=2iqk
-----END PGP SIGNATURE-----

--OaZoDhBhXzo6bW1J--
