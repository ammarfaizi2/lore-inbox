Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262441AbVCaCBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262441AbVCaCBm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 21:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262477AbVCaCBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 21:01:42 -0500
Received: from downeast.net ([204.176.212.2]:17645 "EHLO downeast.net")
	by vger.kernel.org with ESMTP id S262441AbVCaCBe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 21:01:34 -0500
From: Patrick McFarland <pmcfarland@downeast.net>
To: Olivier Galibert <galibert@pobox.com>
Subject: Re: Do not misuse Coverity please
Date: Wed, 30 Mar 2005 21:01:27 -0500
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <200503300125.j2U1PFQ9005082@laptop11.inf.utfsm.cl> <d2er4p$qp$1@sea.gmane.org> <20050330185531.GA6210@dspnet.fr.eu.org>
In-Reply-To: <20050330185531.GA6210@dspnet.fr.eu.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart7570070.pY6m33Wmuz";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200503302101.32755.pmcfarland@downeast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart7570070.pY6m33Wmuz
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 30 March 2005 01:55 pm, Olivier Galibert wrote:
> Actually it is.  Dereferencing a null pointer is either undefined or
> implementation-dependant in the standard (don't remember which), and
> as such the compiler can do whatever it wants, be it starting nethack

Can this be configured to start slashem instead? ;)

> or not doing the dereference in the first place.

What scares me is, "Is there any code in the kernel that does this, or=20
something similarly stupid?". I regard the linux kernel as mostly sane, and=
=20
I'd rather not have that illusion of safety broken* any time soon. Sure, it=
s=20
great for an app to randomly segfault, but having the kernel oops randomly =
is=20
not much fun.

To quote a sig I once saw on usenet: "Why Linux is better than Windows, Rea=
son=20
#325: No needing to reboot every 15 seconds; or every 3 seconds during full=
=20
moons."



* I am by no means an expert on kernel programing

=2D-=20
Patrick "Diablo-D3" McFarland || pmcfarland@downeast.net
"Computer games don't affect kids; I mean if Pac-Man affected us as kids, w=
e'd=20
all be running around in darkened rooms, munching magic pills and listening=
 to
repetitive electronic music." -- Kristian Wilson, Nintendo, Inc, 1989

--nextPart7570070.pY6m33Wmuz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCS1n88Gvouk7G1cURAs5yAJ4qRcwPtaYJgmCNPYe8/U7BDLJ2TwCgoM70
Y5S2Pju1xBWMfNsktetC+J8=
=pGWG
-----END PGP SIGNATURE-----

--nextPart7570070.pY6m33Wmuz--
