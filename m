Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265603AbTA1OQC>; Tue, 28 Jan 2003 09:16:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265587AbTA1OQC>; Tue, 28 Jan 2003 09:16:02 -0500
Received: from 24-216-100-96.charter.com ([24.216.100.96]:13975 "EHLO
	wally.rdlg.net") by vger.kernel.org with ESMTP id <S265603AbTA1OP6>;
	Tue, 28 Jan 2003 09:15:58 -0500
Date: Tue, 28 Jan 2003 09:25:15 -0500
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 3ware error?  WTF is this?
Message-ID: <20030128142515.GF13105@rdlg.net>
Mail-Followup-To: Andre Hedrick <andre@linux-ide.org>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
References: <20030128140103.GE13105@rdlg.net> <Pine.LNX.4.10.10301280602050.9272-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Rgf3q3z9SdmXC6oT"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10301280602050.9272-100000@master.linux-ide.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Rgf3q3z9SdmXC6oT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



Sorry, Firmware is also 7.5.2 per the web page (try to keep driver and
firmware in sync so I forget to specify that sometimes).  The
configuration is 8 drives being software raid'd into 2 4drive raid5's.
When this was built we went this route as we were told that the raid5
implementation for the 3ware was slower than the software.  We didn't
have alot of time to test this theory and prove it wrong unfortunately.
We need the space of raid5 more than the reduancancy of mirroring. =20

What else can I tell you?

Robert


Thus spake Andre Hedrick (andre@linux-ide.org):

>=20
> Robert,
>=20
> Could you give us a little more meat to chew on?
> "Kernel 2.4.19 with 3ware driver 7.5.2 from their web page", firmware ??
> The driver has a version string like "1.02.00.025".
> "PCI Parity Error" is more or less a mainboard error, or a barrier commit
> error.  I see you are doing that favorite "jbod" thing with "md" has your
> raid wrapper.  Best guess, who knows but more data is useful and required.
>=20
> Cheers,
>=20
> Andre Hedrick
> LAD Storage Consulting Group
>=20
>=20
> On Tue, 28 Jan 2003, Robert L. Harris wrote:
>=20
> >=20
> >=20
> > Guys, I've got a machine generating all kinds of wierd errors.  It
> > failed 4 out of 8 drives on a 3ware card.  A reboot cleared all but 1
> > up, I've had alot of lag while the card is spitting errors etc.  I'm
> > about to launch this thing into the nearest highway I can find.
> >=20
> > This morning I got this:
> >=20
> > 3w-xxxx: scsi1: PCI Parity Error: clearing.
> > EXT3-fs error (device md(9,2)): ext3_add_entry: bad entry in directory
> > #65: rec_len % 4 !=3D 0 - offset=3D552, inode=3D93, rec_len=3D21, name_=
len=3D11
> > 3w-xxxx: scsi2: PCI Parity Error: clearing.
> >=20
> >=20
> > Can I get an educated "oh, your card is bad" or "hmm, bad driver maybe?"
> > or something I can poke with a stick?  It's a brand new box with brand
> > new drives and controllers.  It was running great until last week.
> > Kernel 2.4.19 with 3ware driver 7.5.2 from their web page.
> >=20
> > Robert
> >=20
> >=20
> > :wq!
> > -----------------------------------------------------------------------=
----
> > Robert L. Harris                     | PGP Key ID: FC96D405
> >                               =20
> > DISCLAIMER:
> >       These are MY OPINIONS ALONE.  I speak for no-one else.
> > FYI:
> >  perl -e 'print $i=3Dpack(c5,(41*2),sqrt(7056),(unpack(c,H)-2),oct(115)=
,10);'
> >=20
> >=20



:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | PGP Key ID: FC96D405
                              =20
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.
FYI:
 perl -e 'print $i=3Dpack(c5,(41*2),sqrt(7056),(unpack(c,H)-2),oct(115),10)=
;'


--Rgf3q3z9SdmXC6oT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+NpLLPvY/pfyW1AURAmv1AJ9IXZf8iM9IusEFW2CwgXx/kPbiSwCgpPLw
LcK1rbGhW0lIO/w4wUW9UTk=
=5k+l
-----END PGP SIGNATURE-----

--Rgf3q3z9SdmXC6oT--
