Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267558AbUHJQrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267558AbUHJQrT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 12:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267552AbUHJQoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 12:44:54 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:33154 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S267592AbUHJQ3w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 12:29:52 -0400
Date: Tue, 10 Aug 2004 18:29:51 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040810162951.GC1127@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200408101427.i7AERDld014134@burner.fokus.fraunhofer.de> <20040810164947.7f363529.skraw@ithnet.com> <20040810152458.GA1127@lug-owl.de> <20040810153333.GF13369@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Sr1nOIr3CvdE5hEN"
Content-Disposition: inline
In-Reply-To: <20040810153333.GF13369@suse.de>
X-Operating-System: Linux mail 2.6.8-rc4 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Sr1nOIr3CvdE5hEN
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-08-10 17:33:34 +0200, Jens Axboe <axboe@suse.de>
wrote in message <20040810153333.GF13369@suse.de>:

> Don't be naive. How do you discuss changes with him? The one patch I did
> create against the SUSE cdrecord for the one shipped with SL9.1 adds a
> note to use ATA over ATAPI since that is preferred, and it kills the
> silly open-by-devname warnings that are extremely confusing to users. I
> did send that back to Joerg, to no avail.

Look at lkml. For sure, you'll find a good number of examples of really
small (and not really intrusive/important/...) changes that took more
than a dozen emails to discuss (and probably to not come to an end at
all).  Right, I think distro's people should go through all that for
every single change, even while continueing to work on that. Patch
resync isn't an easy thing (even for "single" projects like the Linux
kernel) and nearly an endless game if you bring in something of the
scale of a whole distro. ...and then, there exist several of them.

So I think IFF you (as a distro) attempt to do any changes (be it adding
a well-selling feature like DVD toasting), you *will* somewhen reach a
critical mass: the point of no return (of good patches).

Seems we're slowly reaching there. (I'm just waiting to see a giant Arch
repo of a single, unified Linux distro because of that.)

> > While they (and any other distro's people and anybody else) may
> > actually hack the code to no end, I consider it being good habit to
>=20
> By far the largest modification is dvd support, which we of course need
> to ship. The rest is really minor stuff.

What's more important to whom? First ship the feature, or first getting
consens with the initial author? Exactly--there are two answers:(

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Irak! =
  O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--Sr1nOIr3CvdE5hEN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBGPf/Hb1edYOZ4bsRAnEAAJ0RGJvRmj/caUQnFy/Bt2sTYzFcVQCgh9Rb
WdKLP5zeYBTYQUq+W7U01js=
=9m1a
-----END PGP SIGNATURE-----

--Sr1nOIr3CvdE5hEN--
