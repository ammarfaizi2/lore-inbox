Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030277AbWGaRcm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030277AbWGaRcm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 13:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030278AbWGaRcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 13:32:42 -0400
Received: from lug-owl.de ([195.71.106.12]:2523 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1030277AbWGaRcl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 13:32:41 -0400
Date: Mon, 31 Jul 2006 19:32:39 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Rudy Zijlstra <rudy@edsons.demon.nl>
Cc: Adrian Ulrich <reiser4@blinkenlights.ch>,
       Matthias Andree <matthias.andree@gmx.de>, vonbrand@inf.utfsm.cl,
       ipso@snappymail.ca, reiser@namesys.com, lkml@lpbproductions.com,
       jeff@garzik.org, tytso@mit.edu, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion
Message-ID: <20060731173239.GO31121@lug-owl.de>
Mail-Followup-To: Rudy Zijlstra <rudy@edsons.demon.nl>,
	Adrian Ulrich <reiser4@blinkenlights.ch>,
	Matthias Andree <matthias.andree@gmx.de>, vonbrand@inf.utfsm.cl,
	ipso@snappymail.ca, reiser@namesys.com, lkml@lpbproductions.com,
	jeff@garzik.org, tytso@mit.edu, linux-kernel@vger.kernel.org,
	reiserfs-list@namesys.com
References: <1153760245.5735.47.camel@ipso.snappymail.ca> <200607241806.k6OI6uWY006324@laptop13.inf.utfsm.cl> <20060731125846.aafa9c7c.reiser4@blinkenlights.ch> <20060731144736.GA1389@merlin.emma.line.org> <20060731175958.1626513b.reiser4@blinkenlights.ch> <20060731162224.GJ31121@lug-owl.de> <Pine.LNX.4.64.0607311842120.13492@nedra.edsons.demon.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xNm6VWMD3PcA105u"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607311842120.13492@nedra.edsons.demon.nl>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xNm6VWMD3PcA105u
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-07-31 18:44:33 +0200, Rudy Zijlstra <rudy@edsons.demon.nl> wro=
te:
> On Mon, 31 Jul 2006, Jan-Benedict Glaw wrote:
> > On Mon, 2006-07-31 17:59:58 +0200, Adrian Ulrich=20
> > <reiser4@blinkenlights.ch> wrote:
> > > A colleague of mine happened to create a ~300gb filesystem and started
> > > to migrate Mailboxes (Maildir-style format =3D many small files (1-3k=
b))
> > > to the new LUN. At about 70% the filesystem ran out of inodes; Not a
> >
> > So preparation work wasn't done.
>=20
> Of course you are right. Preparation work was not fully done. And using=
=20
> ext1 would also have been possible. I suspect you are still using ext1,=
=20
> cause with proper preparation it is perfectly usable.

Oh, and before people start laughing at me, here are some personal or
friend's experiences with different filesystems:

  * reiser3: A HDD containing a reiser3 filesystem was tried to be
    booted on a machine that fucked up DMA writes. Fortunately, it
    crashed really soon (right after going for read-write.)  After
    rebooting the HDD on a sane PeeCee, it refused to boot. Starting
    off some rescue system showed an _empty_ root filesystem.

  * A friend's XFS data partition (portable USB/FireWire HDD) once
    crashed due to being hot-unplugged off the USB.  The in-kernel XFS
    driver refused to mount that thing again, and the tools also
    refused to fix any errors. (Don't ask, no details at my hands...)

  * JFS just always worked for me. Though I've never ever had a broken
    HDD where it (or it's tools) could have shown how well-done they
    were, so from a crash-recovery point of view, it's untested.

  * Being a regular ext3 user, I had lots of broken HDDs containing
    ext3 filesystems. For every single case, it has been easy fixing
    the filesystem after cloning. Just _once_, fsck wasn't able to fix
    something, so I did it manually with some disk editor. This worked
    well because the on-disk data structures are actually as simple as
    they are.

ext3 always worked well for me, so why should I abandon it?

MfG, JBG

--=20
       Jan-Benedict Glaw       jbglaw@lug-owl.de                +49-172-760=
8481
 Signature of:                               If it doesn't work, force it.
 the second  :                      If it breaks, it needed replacing anywa=
y.

--xNm6VWMD3PcA105u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEzj63Hb1edYOZ4bsRAqJ5AJ47ER7VgMV07l/8ohUX9UVIafYOgwCfS5yn
0yy/GU+pE2fU22CZ0l9z65E=
=dtHL
-----END PGP SIGNATURE-----

--xNm6VWMD3PcA105u--
