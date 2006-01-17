Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932478AbWAQNkT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478AbWAQNkT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 08:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932483AbWAQNkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 08:40:19 -0500
Received: from ozlabs.org ([203.10.76.45]:24228 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932478AbWAQNkR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 08:40:17 -0500
From: Michael Ellerman <michael@ellerman.id.au>
Reply-To: michael@ellerman.id.au
To: Dave C Boutcher <sleddog@us.ibm.com>
Subject: Re: 2.6.15-mm4 failure on power5
Date: Wed, 18 Jan 2006 00:32:43 +1100
User-Agent: KMail/1.8.3
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linuxppc64-dev@ozlabs.org, paulus@au1.ibm.com, anton@au1.ibm.com,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
References: <20060116063530.GB23399@sergelap.austin.ibm.com> <20060116153748.GA25866@sergelap.austin.ibm.com> <20060116215252.GA10538@cs.umn.edu>
In-Reply-To: <20060116215252.GA10538@cs.umn.edu>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3187557.rjtkziG21e";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200601180032.46867.michael@ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3187557.rjtkziG21e
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tue, 17 Jan 2006 08:52, Dave C Boutcher wrote:
> 2.6.15-mm4 won't boot on my power5 either.  I tracked it down to the
> following mutex patch from Ingo: kernel-kernel-cpuc-to-mutexes.patch
>
> If I revert just that patch, mm4 boots fine.  Its really not obvious to
> me at all why that patch is breaking things though...

My POWER5 (gr) LPAR seems to boot ok (3 times so far) with that patch, gues=
s=20
it's something subtle. That's with CONFIG_DEBUG_MUTEXES=3Dy. And it's just=
=20
booted once with CONFIG_DEBUG_MUTEXES=3Dn.

And now it's booted the full mm4 patch set without blinking.

cheers

=2D-=20
Michael Ellerman
IBM OzLabs

email: michael:ellerman.id.au
inmsg: mpe:jabber.org
wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--nextPart3187557.rjtkziG21e
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDzPH+dSjSd0sB4dIRApilAJ9yEZUN2DyWlAzQOujduK5GjvNWnwCgvcbC
nkvKqN1MHVXOS8DeJaMmAgQ=
=qy8v
-----END PGP SIGNATURE-----

--nextPart3187557.rjtkziG21e--
