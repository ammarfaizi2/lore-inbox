Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262859AbTKJEXl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 23:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262862AbTKJEXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 23:23:41 -0500
Received: from adsl-67-124-156-138.dsl.pltn13.pacbell.net ([67.124.156.138]:1760
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id S262859AbTKJEXj (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 23:23:39 -0500
Date: Sun, 9 Nov 2003 20:23:38 -0800
To: Linux-kernel@vger.kernel.org
Subject: Re: slab corruption in test9 (NFS related?)
Message-ID: <20031110042338.GI956@triplehelix.org>
Mail-Followup-To: joshk@triplehelix.org, Linux-kernel@vger.kernel.org
References: <16303.131.838605.661991@notabene.cse.unsw.edu.au> <Pine.LNX.4.44.0311092007451.3002-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TdkiTnkLhLQllcMS"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311092007451.3002-100000@home.osdl.org>
User-Agent: Mutt/1.5.4i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TdkiTnkLhLQllcMS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 09, 2003 at 08:09:40PM -0800, Linus Torvalds wrote:
> In other words, your patch certainly looks obviously correct, but it also
> looks _so_ obviously correct that my alarm bells are going off. If the
> code was quite that broken at counting dentries, how the hell did it ever
> work AT ALL?

=46rom Jargon File (4.3.0, 30 APR 2001) [jargon]:

  schroedinbug /shroh'din-buhg/ n. [MIT: from the Schroedinger's Cat
     thought-experiment in quantum physics] A design or implementation bug =
in
     a program that doesn't manifest until someone reading source or using
     the program in an unusual way notices that it never should have worked,
     at which point the program promptly stops working for everybody until
     fixed. Though (like {bit rot}) this sounds impossible, it happens; some
     programs have harbored latent schroedinbugs for years. Compare
     {heisenbug}, {Bohr bug}, {mandelbug}.

Hold on to your horses everyone? :)

--=20
Joshua Kwan

--TdkiTnkLhLQllcMS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iQIVAwUBP68SyKOILr94RG8mAQIP8RAAv2VbF7nglCYBfaO/Rl6Ge6RIvRc89Bmo
jTjJSmHpynd2jYEYX+plI3odoJUJx+SvHKn8Bs/5p2m4sypxn7DKmL0fmMf3C/RZ
9+mNzcmWNHMNWOpTBCCQ5gGbgXOuqkt2b4heOGUj6n58C+406J/Fw/g6Mh2IxzK7
7SVtbANMNUuNja1x1L2UU6/XbAO3Pqueaf7xsbGBJwxnw8oXdWUfgo0pUaBqTxbd
9PmFezOd3sO3OBkE6VkdIjohmmZJ6TZrF7c/tK7sAyb6RqxA+oXDTdigazeTABwV
bY+4p1m5gigWpoz4VHvnw7Dq66AJiZQpRhA3CkFT4yklxsgIp8CSb5+HNLusrcFb
WhQe5YPQKv1EnYSbkpc70eT5dm2TgE62hF7PBdr8gGIIKYLyTEfNW2dm4XAIqTeq
zNEasAlNvIwo0nqMLP3Oiz4zT7g0yrfYOcmftInFa7EVSsydFL4E4cvXrq3cL09i
8GqQqEV98ssOaTJqNSUFnV7tfM88OMtY+1WZ+/w+rKyApWH2eKW/x6sYyL50qmia
fxii/HPBpjnvuAiWGCivM7cBliGfWILPktJFseWcpu4n+rehxoM0blDYX+IUtwEn
w8QBPx9dCLT4xJP5sszlrRXeDjbTrLu0YpfVF45j9wY9A/ty5scJlQGOHxRfiygW
duQagPE/MC4=
=DTXh
-----END PGP SIGNATURE-----

--TdkiTnkLhLQllcMS--
