Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129597AbQLXLYi>; Sun, 24 Dec 2000 06:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129706AbQLXLY3>; Sun, 24 Dec 2000 06:24:29 -0500
Received: from air.lug-owl.de ([62.52.24.190]:16659 "HELO air.lug-owl.de")
	by vger.kernel.org with SMTP id <S129597AbQLXLYT>;
	Sun, 24 Dec 2000 06:24:19 -0500
Date: Sun, 24 Dec 2000 11:53:48 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: sparc 10 w/512 megs hangs during boot
Message-ID: <20001224115348.A25473@lug-owl.de>
Reply-To: jbglaw@lug-owl.de
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20001224075721.26703.qmail@web1002.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001224075721.26703.qmail@web1002.mail.yahoo.com>; from ronnnyc@yahoo.com on Sat, Dec 23, 2000 at 11:57:21PM -0800
X-Operating-System: Linux air 2.4.0-test8-pre1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 23, 2000 at 11:57:21PM -0800, Ron Calderon wrote:
> My sparc 10 seems to hang with any 2.4.0-test12+
> kernel

=2E..but 2.4.0-test11-X kernels are fine? Well, good info;)

> if I add mem=3D128M it boots fine, but anything above
> 128M wont boot it just hangs. Is there something I've
> missed? here is screen output.

I see this as well (SS10 dual with 128MB RAM). However, if
slightly older kernel are okay, then it's quite easy to look
through the patches. Which is your last-known-to-be-good kernel?

> Uncompressing image...
> PROMLIB: obio_ranges 5
> bootmem_init: Scan sp_banks,=20
> init_bootmem(spfn[1c9],bpfn[1c9],mlpfn[c000])
> free_bootmem: base[0] size[c000000]
> reserve_bootmem: base[0] size[1c9000]
> reserve_bootmem: base[1c9000] size[1800]
>=20
> then it just hangs here....

I additionally get "Unexpected Level 15 Interrupt" und "Program
terminated" ;-)

MfG, JBG

--=20
Fehler eingestehen, Gr=F6=DFe zeigen: Nehmt die Rechtschreibreform zur=FCck=
!!!
/* Jan-Benedict Glaw <jbglaw@lug-owl.de> -- +49-177-5601720 */
keyID=3D0x8399E1BB fingerprint=3D250D 3BCF 7127 0D8C A444 A961 1DBD 5E75 83=
99 E1BB
     "insmod vi.o and there we go..." (Alexander Viro on linux-kernel)

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.2 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjpF1bwACgkQHb1edYOZ4btyiACfYhQGoTLNcPp94zmY8h1MXr3E
QbMAnRBB/LmzmKLwlIc+m/bAisFBdyit
=Hq1z
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
