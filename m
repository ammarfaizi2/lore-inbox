Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284509AbRLZJu4>; Wed, 26 Dec 2001 04:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284522AbRLZJuq>; Wed, 26 Dec 2001 04:50:46 -0500
Received: from fysh.org ([212.47.68.126]:10758 "EHLO bowl.fysh.org")
	by vger.kernel.org with ESMTP id <S284509AbRLZJue>;
	Wed, 26 Dec 2001 04:50:34 -0500
Date: Wed, 26 Dec 2001 09:50:33 +0000
From: Athanasius <Athanasius@gurus.tf>
To: linux-kernel@vger.kernel.org
Subject: Re: CDROM stop's working 15mins after being mounted
Message-ID: <20011226095033.GG4633@gurus.tf>
Mail-Followup-To: Athanasius <Athanasius@gurus.tf>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011226034203.5889d583.rj@open-net.org> <Pine.LNX.4.33.0112261013330.27733-100000@unicef.org.yu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fCcDWlUEdh43YKr8"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0112261013330.27733-100000@unicef.org.yu>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fCcDWlUEdh43YKr8
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 26, 2001 at 10:22:28AM +0100, Davidovac Zoran wrote:
> I have no problem with  using scsi cdrom emulation ,
> using teac 58E RW and ide-scsi emulation.

   Mitsumi CR-4804TE here, also no problems with 2.4.15 (with the second
cut of Viro's iput() patch, more or less making it 2.4.16), and a few other
'random' 2.4.x's, 2.4.13 and .14 spring to mind.

> Only problem I found is when writing TOC (within cdrecord)
> I have to wait until it finished (I cannot even change console)

   Ah, I'm not the only one seeing this then.  During the 'fixating'
stage of burning I see what you describe.  I THINK it's more to do with
it hogging the bus (for whatever reason), and nothing being able to be
swapped in.  Could be a total interrupt hog?

> to be more strange, I have that problem only at work
> PIII 500Mhz with TEAC 58E but on
> PII 633Mhz with TEAC 54E and PPRO 200Mhz with TEAC 58E I haven't
> that problem. Note that was for 2.4.14-17

   PII-400 here, on:

	Gigabyte 686BX motherboard (IDE interface: Intel Corp. 82371AB
	PIIX4 IDE (rev 01)) ->
	http://www.gigabyte.com.tw/products/ga686bx.htm

	the aforementioned Mitsumi CR-4804TE CD-R/RW on hdb (my actual
	system is on hda, only a pure data drive is on hdc, no hdd)

	Cdrecord 1.10 (i686-pc-linux-gnu) Copyright (C) 1995-2001 J=F6rg
	Schilling

> With kernel 2.2.19 there is no such behaviur.

   I don't recall this with the various 2.2.x kernels I ran until
switching to 2.4.8 either.

-Ath
--=20
- Athanasius =3D Athanasius(at)gurus.tf / http://www.clan-lovely.org/~athan/
                  Finger athan(at)fysh.org for PGP key
	   "And it's me who is my enemy. Me who beats me up.
Me who makes the monsters. Me who strips my confidence." Paula Cole - ME

--fCcDWlUEdh43YKr8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjwpnWkACgkQzbc+I5XfxKcUaACfZIQR3MhvQh2kQFEiYs/FGefI
PlgAnRUyhIwRT57/rZI3PSY08rxxN3ml
=QNyZ
-----END PGP SIGNATURE-----

--fCcDWlUEdh43YKr8--
