Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132541AbRCZTEx>; Mon, 26 Mar 2001 14:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132549AbRCZTEn>; Mon, 26 Mar 2001 14:04:43 -0500
Received: from client38038.atl.mediaone.net ([24.88.38.38]:760 "HELO
	whitestar.soark.net") by vger.kernel.org with SMTP
	id <S132541AbRCZTEb>; Mon, 26 Mar 2001 14:04:31 -0500
Date: Mon, 26 Mar 2001 14:03:49 -0500
From: "Zephaniah E\. Hull" <warp@whitestar.soark.net>
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Lovely crash with 2.4.2-ac24.
Message-ID: <20010326140349.D3920@whitestar.soark.net>
In-Reply-To: <20010326132833.B3920@whitestar.soark.net> <Pine.LNX.4.10.10103261030570.14541-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9l24NVCWtSuIVIod"
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.LNX.4.10.10103261030570.14541-100000@master.linux-ide.org>; from andre@linux-ide.org on Mon, Mar 26, 2001 at 10:31:17AM -0800
X-Notice-1: Unsolicited Commercial Email (Aka SPAM) to ANY systems under
X-Notice-2: our control constitutes a $US500 Administrative Fee, payable
X-Notice-3: immediately.  By sending us mail, you hereby acknowledge that
X-Notice-4: policy and agree to the fee.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9l24NVCWtSuIVIod
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 26, 2001 at 10:31:17AM -0800, Andre Hedrick wrote:
> On Mon, 26 Mar 2001, Zephaniah E. Hull wrote:
>=20
> > On Mon, Mar 26, 2001 at 09:46:54AM -0800, Andre Hedrick wrote:
> > >=20
> > > Zephaniah,
> > >=20
> > > Does this happen in a non-ac kernel?
> > > I have not updated code since around 2.4.0, but other have.
> > > You point ot a few times w/ ac18, but is there one before that which =
does
> > > not cause this to happen?
> > >=20
> > > The question is to gain isolation of the changes.
> >=20
> > I'm not sure, I did not see it on 2.4.2-ac18 until I started doing a lot
> > of X compiling, but I can't reproduce at will which makes this a little
> > harder.
> >=20
> > I could try 2.4.2 the current 2.4.3-pre kernels from Linus if that would
> > help? (Though, as I said, it seems to happen semi-randomly, though more
> > when there is heavy disk activity.)
>=20
> But hardware class and vender?

K6-2 500, the MB is a Super 7, Tyan S1590S-100.

It is a VIA Apollo 3 (MVP3) AGPset chipset, only goes up to DMA/33.

The drive is a 10G Western Digital, output from the kernel on boot up below.

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
VP_IDE: VIA vt82c586b (rev 47) IDE UDMA33 controller on pci00:07.1
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:DMA
hda: WDC WD102AA, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 20044080 sectors (10263 MB) w/2048KiB Cache, CHS=3D1247/255/63, UDMA(3=
3)

If I've left anything out just ask.

Zephaniah E. Hull.

<snip>
>=20
> Andre Hedrick
> Linux ATA Development
> ASL Kernel Development
> -------------------------------------------------------------------------=
----
> ASL, Inc.                                     Toll free: 1-877-ASL-3535
> 1757 Houret Court                             Fax: 1-408-941-2071
> Milpitas, CA 95035                            Web: www.aslab.com
>=20

--=20
 PGP EA5198D1-Zephaniah E. Hull <warp@whitestar.soark.net>-GPG E65A7801
    Keys available at http://whitestar.soark.net/~warp/public_keys.
           CCs of replies from mailing lists are encouraged.

Having been the victim of forgeries myself, I sympathise. I've still got
my nutcraker handy for the day I identify and catch the scum...
  -- Richard Gooch on l-k.

--9l24NVCWtSuIVIod
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6v5KVRFMAi+ZaeAERAs4BAJwKIcWDG/SFuFam2Kcl4EPsCv+YEgCfRMuO
ubEpBidXLgvnkTFjMqRIY6o=
=azts
-----END PGP SIGNATURE-----

--9l24NVCWtSuIVIod--
