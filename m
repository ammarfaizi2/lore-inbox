Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316586AbSIEBFe>; Wed, 4 Sep 2002 21:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316580AbSIEBFe>; Wed, 4 Sep 2002 21:05:34 -0400
Received: from [208.34.239.122] ([208.34.239.122]:15232 "EHLO
	babylon5.babcom.com") by vger.kernel.org with ESMTP
	id <S316578AbSIEBFd>; Wed, 4 Sep 2002 21:05:33 -0400
Date: Wed, 4 Sep 2002 21:11:33 -0400
From: Phil Stracchino <alaric@babcom.com>
To: Andries.Brouwer@cwi.nl, greg@kroah.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Feiya 5-in-1 Card Reader
Message-ID: <20020905011133.GA921@babylon5.babcom.com>
Mail-Followup-To: Andries.Brouwer@cwi.nl, greg@kroah.com,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-usb-devel@lists.sourceforge.net
References: <UTC200209042256.g84Mu0w15389.aeb@smtp.cwi.nl> <20020904161042.O13478@one-eyed-alien.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
In-Reply-To: <20020904161042.O13478@one-eyed-alien.net>
User-Agent: Mutt/1.4i
X-PGP-Fingerprint: 2105 C6FC 945D 2A7A 0738  9BB8 D037 CE8E EFA1 3249
X-PGP-Key-FTP-URL: ftp://ftp.babcom.com/pub/pgpkeys/alaric.asc
X-PGP-Key-HTTP-URL: http://www.babcom.com/alaric/pgp.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 04, 2002 at 04:10:42PM -0700, Matthew Dharm wrote:
> The MODE_SENSE bit is fine by me.  But it's a SCSI change, so I'm not the
> person to ask.  The fix to sddr09.c for that seems reasonable, but you put
> it all together and I haven't had time to split it up.  Of course, I fully
> expect the changes to MODE_SENSE in the SCSI layer to break other USB
> devices, but there is only one way to find out....

Speaking of sddr09 devices (of which I possess one), what's the current
state of support for the sddr09?  Last I knew, at the time when I finally
got mine working, the sddr09 was only supported read-only, since there
were not-fully-understood issues that resulted in filesystem corruption=20
if you tried to write to it.  Currently, the driver will still allow me
to mount it only as a read-only filesystem.  Can write support for the
sddr09 be expected any time soon?


--=20
  *********  Fight Back!  It may not be just YOUR life at risk.  *********
  phil stracchino   ::   alaric@babcom.com   ::   halmayne@sourceforge.net
    unix ronin     ::::   renaissance man   ::::   mystic zen biker geek
     2000 CBR929RR, 1991 VFR750F3 (foully murdered), 1986 VF500F (sold)
       Linux Now! ...because friends don't let friends use Microsoft.

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9dq9F0DfOju+hMkkRAqGAAKDVmy2Cne8CZjaNnG5UKl0NHrLJFQCgsrwJ
ALmY9bMRA9+atF2fo4LpOnU=
=SjO0
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
