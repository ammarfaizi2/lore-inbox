Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314181AbSDMCNV>; Fri, 12 Apr 2002 22:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314183AbSDMCNU>; Fri, 12 Apr 2002 22:13:20 -0400
Received: from c-66-56-74-91.atl.client2.attbi.com ([66.56.74.91]:10998 "HELO
	babylon.d2dc.net") by vger.kernel.org with SMTP id <S314181AbSDMCNT>;
	Fri, 12 Apr 2002 22:13:19 -0400
Date: Fri, 12 Apr 2002 22:13:17 -0400
From: "Zephaniah E\. Hull" <warp@mercury.d2dc.net>
To: linux-kernel@vger.kernel.org
Subject: Re: IDE Panic (2.4.19-pre3-ac3)
Message-ID: <20020413021317.GA1307@babylon.d2dc.net>
Mail-Followup-To: "Zephaniah E. Hull" <warp@babylon.d2dc.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020413011114.GA1145@babylon.d2dc.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Notice-1: Unsolicited Commercial Email (Aka SPAM) to ANY systems under
X-Notice-2: our control constitutes a $US500 Administrative Fee, payable
X-Notice-3: immediately.  By sending us mail, you hereby acknowledge that
X-Notice-4: policy and agree to the fee.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2002 at 09:11:15PM -0400, Zephaniah E. Hull wrote:
> I will try without using the ide-scsi layer and with older kernels in a
> few hours, if any additional information is needed please let me know.

Ok, using ide-cd instead of ide-scsi for it does not work perfectly,
however it also does not crash.

warp@agamemnon:~$ mount /mnt/cd0
hdc: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hdc: status error: status=3D0x58 { DriveReady SeekComplete DataRequest }
hdc: drive not ready for command
hdc: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hdc: status error: status=3D0x58 { DriveReady SeekComplete DataRequest }
hdc: drive not ready for command
warp@agamemnon:~$

warp@agamemnon:~$ ls /mnt/cd0/dosutils/
hdc: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hdc: status error: status=3D0x58 { DriveReady SeekComplete DataRequest }
hdc: drive not ready for command
README     autoboot.bat  fips15c/   gzip.exe      rawrite.exe
restorrb.exe
TRANS.TBL  copying       fips20/    loadlin.exe   rawrite3.doc
autoboot/  fips.exe      fipsdocs/  lodlin16.tgz  rdev.exe
warp@agamemnon:~$

This is clearly better, however it is obviously not ideal, any ideas?

Zephaniah E. Hull.

>=20
> Thanks.
>=20
> Zephaniah E. Hull.
> (Debian Developer.)
>=20
> P.S.: The -c2 part of the kernel version just indicates compile 2, not
> additional patches.
>=20
> --=20
> 	1024D/E65A7801 Zephaniah E. Hull <warp@babylon.d2dc.net>
> 	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
> 	    CCs of replies from mailing lists are requested.
>=20
> ...and the burnt fool's bandaged finger goes wobbling back to the fire.
>   -- The Gods of the Copybook Headings, by Kippling.

--=20
	1024D/E65A7801 Zephaniah E. Hull <warp@babylon.d2dc.net>
	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
	    CCs of replies from mailing lists are requested.

* james would be more impressed if netgod's magic powers could stop the
splits in the first place...
* netgod notes debian developers are notoriously hard to impress
        -- Seen on #Debian

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8t5Q9RFMAi+ZaeAERAqN6AJ4uqorPUVgizNKlC7o//peyVAMRhgCgwALw
v7a6aYficKgkKlW0fHs8k+c=
=8M+8
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
