Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267736AbTAITZM>; Thu, 9 Jan 2003 14:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267735AbTAITZM>; Thu, 9 Jan 2003 14:25:12 -0500
Received: from adsl-67-121-154-100.dsl.pltn13.pacbell.net ([67.121.154.100]:3808
	"EHLO kanoe.ludicrus.net") by vger.kernel.org with ESMTP
	id <S267507AbTAITZD>; Thu, 9 Jan 2003 14:25:03 -0500
Date: Thu, 9 Jan 2003 11:33:31 -0800
To: jt@hpl.hp.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Wireless Extensions v16-3 - clean patches
Message-ID: <20030109193331.GA26262@kanoe.ludicrus.net>
References: <20030109043119.GA13910@kanoe.ludicrus.net> <20030109181340.GB24023@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
In-Reply-To: <20030109181340.GB24023@bougret.hpl.hp.com>
User-Agent: Mutt/1.5.3i
From: "Joshua M. Kwan" <joshk@ludicrus.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jean,

> 	For 2.5.X : my Pcmcia cards still don't work with 2.5.54, so
> I'm currently no too worried about 2.5.X at the moment.

They didn't work for me either. But I read an old LKML post from about
3 months ago which said that since 16-bit PCMCIA cards are ISA based
one must enable CONFIG_ISA to get those sort of cards working, so I
did that and now everything is working just fine.

It's weird because i thought the WaveLAN/IEEE was a 32-bit CardBus
device.

> 	Also, the current WE16-3 may not be the final version, as I'm
> waiting for feedback from driver authors. Talking of feedback, which
> part of WE16 do you need and why ?

I like the enhanced iwspy support. It is currently working just fine for
me! Basically, it allows me to check on my server whether any vagabonds
are camping on my AP (running hostap), and if my dad says 'the internet
stopped working' i can see whether his wifi card crapped out. I don't
quite remember now but I recall having some problems with earlier WE
and hostap_pci using iwspy. It might not have been the fault of WE but
of some other factors with my hostap build, and in troubleshooting I
upgraded to WE16 to see whether it was the problem.

Another reason is 'just for the hell of it.' :)

Regards
Josh

On Thu, Jan 09, 2003 at 10:13:41AM -0800, Jean Tourrilhes wrote:
> On Wed, Jan 08, 2003 at 08:31:19PM -0800, Joshua M. Kwan wrote:
> > Hi Jean,
> >=20
> > I have attached two patches that allow current 2.5.54 BK and 2.4.20
> > vanilla to patch cleanly from whatever WE they came with to WE16,
> > from your site. This is easier since the patches on your website for
> > 2.4.20 require two patches, and the 2.5.x one has a single reject
> > that was not hard to resolve (just a few line breaks here and there
> > and editing of the surrounding text confused patch.)
> >=20
> > For 2.5, the BK i diffed against was a fresh tree from today, but
> > since you're the one that makes all the changes to those files
> > anyway, it really doesn't matter until a new WE is pushed! And then
> > this patch won't be necessary at all :)
> >=20
> > Both patches should be placed in the root of the source tree and
> > applied with -p0.
> >=20
> > Hope this can benefit others who would like to easily upgrade their
> > WE :)
> >=20
> > Regards
> > Josh
>=20
> 	Thanks for the good work !
>=20
> 	For 2.4.X : 2.4.21-pre2 has WE-15, so if you get it it's only
> one patch (the one on my page).
> 	For 2.5.X : my Pcmcia cards still don't work with 2.5.54, so
> I'm currently no too worried about 2.5.X at the moment.
> 	Also, the current WE16-3 may not be the final version, as I'm
> waiting for feedback from driver authors. Talking of feedback, which
> part of WE16 do you need and why ?
>=20
> 	Have fun...
>=20
> 	Jean
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+Hc6L6TRUxq22Mx4RAp0YAJ4n9yTdVyRRoWJqhtNm4MSgvOTdPACgup51
kFsR6uO0AisEo1sIyjgX+98=
=pI7a
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
