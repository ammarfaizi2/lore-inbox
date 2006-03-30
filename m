Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751419AbWC3BXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbWC3BXk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 20:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbWC3BXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 20:23:40 -0500
Received: from 63.15.233.220.exetel.com.au ([220.233.15.63]:13242 "EHLO
	hufpuf.lan1.hme1.samad.com.au") by vger.kernel.org with ESMTP
	id S1751419AbWC3BXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 20:23:39 -0500
Date: Thu, 30 Mar 2006 11:23:41 +1000
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][INCOMPLETE] sata_nv: merge ADMA support
Message-ID: <20060330012340.GC7785@hufpuf.lan1.hme1.samad.com.au>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20060317232339.GA5674@ti64.telemetry-investments.com> <20060327160845.GG9411@ti64.telemetry-investments.com> <200603271646.55317.lkml@lpbproductions.com> <200603271700.53641.lkml@lpbproductions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="adJ1OR3c6QgCpb/j"
Content-Disposition: inline
In-Reply-To: <200603271700.53641.lkml@lpbproductions.com>
User-Agent: Mutt/1.5.11+cvs20060126
From: Alexander Samad <alex@samad.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--adJ1OR3c6QgCpb/j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi

I was wondering if the patch for sata_nv to hanlde the lost interrupts
has been submitted for inclussion in the kernel.

I have sort of been  following this thread, were it seems that the
interrupt problem has been fixed, but they were also going to fix the
adma problem as well.

I did a quick check of 2.6.16 changelog and see no mention for sata_nv.

I seem to suffere from this issue quite often - doing dvd burns across a
network.....

Thanks

On Mon, Mar 27, 2006 at 05:00:53PM -0500, Matt Heler wrote:
> I forgot to include this.. but here's my bios version=20
>=20
>         Vendor: Phoenix Technologies, LTD
>         Version: 6.00 PG
>         Release Date: 06/23/2005
>=20
> On Monday 27 March 2006 4:46 pm, Matt Heler wrote:
> > Hey Bill,
> >
> > I spoke abit to soon though regarding that stability.. After booting up=
 X
> > and running Azerues and kde, my system stalled and locked. However it
> > lasted much longer then Jeff's version.
> >
> > I'm running the DFI Lanparty with an Athlon 4400. I also have the follo=
wing
> > setup
> >
> > 2x300gb seagate drives 7200.8 in a raid0 format with ext3
> > 2x400gb seagate drives 7200.9 again in a raid0 format with ext3
> >
> > and lspci gives me the following ::
> >
> > 00:06.0 IDE interface: nVidia Corporation CK804 IDE (rev a2)
> > 00:07.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller (=
rev
> > a3) 00:08.0 IDE interface: nVidia Corporation CK804 Serial ATA Controll=
er
> > (rev a3)
> >
> > On Monday 27 March 2006 11:08 am, Bill Rugolsky Jr. wrote:
> > > On Sun, Mar 26, 2006 at 08:14:35PM -0500, Matt Heler wrote:
> > > > Using Bill's original patch I was able to boot up perfectly with ad=
ma
> > > > support enabled on my workstation. Even after several stress tests (
> > > > tar -cf /dev/null . , and dd if=3D/dev/sda of=3D/dev/null ), everyt=
hing
> > > > seems to be a-ok. However when I tried the sata_nv.c file that you =
sent
> > > > to Bill, I kept on getting hardlocks, and thus was unable to stress
> > > > test your version.
> > > >
> > > > Also for note, I heve not received any of the timeout problems repo=
rted
> > > > by Bill. Nor have I had any latency problems with adma enabled.
> > >
> > > Matt,
> > >
> > > Nice to see some value falling out of this sata_nv thread.  Did you s=
ee
> > > latency problems before enabling ADMA?
> > >
> > > Would you provide some specifics on your setup?
> > >
> > > Which motherboard, #CPUs, BIOS revision, kernel, MD/LVM2/fs?
> > >
> > > On two of my Tyan S2895 machines, including the one that I'm using for
> > > testing, lspci says:
> > >
> > > 00:06.0 IDE interface: nVidia Corporation CK804 IDE (rev f2)
> > > 00:07.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller
> > > (rev f3) 00:08.0 IDE interface: nVidia Corporation CK804 Serial ATA
> > > Controller (rev f3)
> > >
> > > and dmidecode says:
> > >
> > > BIOS Information
> > >         Vendor: Phoenix Technologies Ltd.
> > >         Version: 2004Q3
> > >         Release Date: 10/12/2005
> > >
> > > The other, where I first had lost tick problems, says:
> > >
> > > 00:06.0 IDE interface: nVidia Corporation CK804 IDE (rev a2)
> > > 00:07.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller
> > > (rev a3) 00:08.0 IDE interface: nVidia Corporation CK804 Serial ATA
> > > Controller (rev a3)
> > >
> > > BIOS Information
> > > 	Vendor: Phoenix Technologies Ltd.
> > > 	Version: 2004Q3
> > > 	Release Date: 06/07/2005
> > >
> > >
> > > Thanks,
> > >
> > > 	Bill
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20

--adJ1OR3c6QgCpb/j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEKzMckZz88chpJ2MRAtVlAJ9hfWB4sNimWf3dB23umzxixyr7mwCg71p0
H1qXxZSibOIH/nA5ogi8omY=
=HtMy
-----END PGP SIGNATURE-----

--adJ1OR3c6QgCpb/j--
