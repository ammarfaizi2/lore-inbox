Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269179AbRHBWPc>; Thu, 2 Aug 2001 18:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269178AbRHBWPM>; Thu, 2 Aug 2001 18:15:12 -0400
Received: from h24-76-184-93.vs.shawcable.net ([24.76.184.93]:57513 "HELO
	md5.ca") by vger.kernel.org with SMTP id <S269177AbRHBWPK>;
	Thu, 2 Aug 2001 18:15:10 -0400
Date: Thu, 2 Aug 2001 15:15:06 -0700
From: Pavel Zaitsev <pavel@md5.ca>
To: "Jeffrey W. Baker" <jwbaker@acm.org>
Cc: Jakob =?iso-8859-1?Q?=D8stergaard?= <jakob@unthought.net>,
        linux-kernel@vger.kernel.org
Subject: Re: Ongoing 2.4 VM suckage
Message-ID: <20010802151506.A30906@md5.ca>
Reply-To: pavel@md5.ca
In-Reply-To: <20010802234434.E7650@unthought.net> <Pine.LNX.4.33.0108021448400.21298-100000@heat.gghcwest.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.LNX.4.33.0108021448400.21298-100000@heat.gghcwest.com>; from jwbaker@acm.org on Thu, Aug 02, 2001 at 02:52:11PM -0700
X-Arbitrary-Number-Of-The-Day: 42
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Jeffrey W. Baker(jwbaker@acm.org)@Thu, Aug 02, 2001 at 02:52:11PM -0700:
> Gosh, here's an idea: if there is no memory left and someone malloc()s
> some more, have malloc() fail?  Kill the process that required the memory?
> I can't believe the attitude I am hearing.  Userland processes should be
> able to go around doing whaever the fuck they want and the box should stay
> alive.  Currently, if a userland process runs amok, the kernel goes into
> self-fucking mode for the rest of the week.

Userland process shall be suspended after it reaches certain rate of
swaps per second. It may resume after short while. Userland process,
if written properly will see that malloc is failing and inform user.
If its being bad, then it will be suspended.
p.

--=20
Take out your recursive cannons and shoot!
110461387
http://gpg.md5.ca
http://perlpimp.com

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7adDqEhbFhd1U3E0RAgJ8AKDQP6TLLKgWoaUvzHg6RpTp0Q8aQwCghSl8
Wzts4Kx/aHaMsvwBau5z0Dg=
=FO8y
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
