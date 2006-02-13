Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751002AbWBMAuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbWBMAuP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 19:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751077AbWBMAuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 19:50:14 -0500
Received: from 63.15.233.220.exetel.com.au ([220.233.15.63]:46225 "EHLO
	sydlxfw01.samad.com.au") by vger.kernel.org with ESMTP
	id S1751002AbWBMAuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 19:50:13 -0500
Date: Mon, 13 Feb 2006 11:50:02 +1100
To: Joerg Schilling <schilling@fokus.fraunhofer.de>, mj@ucw.cz,
       peter.read@gmail.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
       jengelh@linux01.gwdg.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060213005002.GK26235@samad.com.au>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	mj@ucw.cz, peter.read@gmail.com, matthias.andree@gmx.de,
	linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
	jengelh@linux01.gwdg.de
References: <43EA1D26.nail40E11SL53@burner> <20060208165330.GB17534@voodoo> <43EB0DEB.nail52A1LVGUO@burner> <Pine.LNX.4.61.0602091729560.30108@yvahk01.tjqt.qr> <43EB7210.nailIDH2JUBZE@burner> <Pine.LNX.4.61.0602091813260.30108@yvahk01.tjqt.qr> <43EB7BBA.nailIFG412CGY@burner> <mj+md-20060209.173519.1949.atrey@ucw.cz> <43EC71FB.nailISD31LRCB@burner> <20060210114930.GC2750@DervishD>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcXnUX77nabWBLF4"
Content-Disposition: inline
In-Reply-To: <20060210114930.GC2750@DervishD>
User-Agent: Mutt/1.5.11
From: Alexander Samad <alex@samad.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HcXnUX77nabWBLF4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 10, 2006 at 12:49:30PM +0100, DervishD wrote:
>     Hi Joerg :)
>=20
>  * Joerg Schilling <schilling@fokus.fraunhofer.de> dixit:
> > Martin Mares <mj@ucw.cz> wrote:
> > > > This is why the mapping engine is in the Linux adoption part of
> > > > libscg. It maps the non-stable device <-> /dev/sg* relation to a
> > > > stable b,t,l address.
> > >
> > > Nonsense. The b,t,l addresses are NOT stable (at least for transports
> >=20
> > Dou you like to verify that you have no clue on SCSI?
>=20
>     My system is clueless, too! If I write a CD before plugging my
> USB storage device, my CD writer is on 0,0,0. If I plug my USB
> storage device *before* doing any access, my cdwriter is on 1,0,0.
> Pretty stable.

Had exactly the same problem with firewire and usb devices, depending on
the order of the loading of the kernel modules it all changes!

>=20
>     But of course, I could made all of the above stable by using
> udev. But then the /dev/sg mapping will be stable, too. I can't see
> why the three random numbers are more stable than /dev/sg. By the
> way, I don't have any SCSI host adapter in my system.
>=20
>     And please, Joerg, be more respectful when answering. It doesn't
> cost money and people will likely respect you, too.
>=20
>     Ra?l N??ez de Arenas Coronado
>=20
> --=20
> Linux Registered User 88736 | http://www.dervishd.net
> http://www.pleyades.net & http://www.gotesdelluna.net
> It's my PC and I'll cry if I want to... RAmen!
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20

--HcXnUX77nabWBLF4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD79e6kZz88chpJ2MRArR8AKDYYp32r4eYDEK+hL1XCzq75jqoPACgsihD
Q1jvSChHldF8cuYgzDkuJPc=
=Xbn/
-----END PGP SIGNATURE-----

--HcXnUX77nabWBLF4--
