Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129768AbQKBKfy>; Thu, 2 Nov 2000 05:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129801AbQKBKfe>; Thu, 2 Nov 2000 05:35:34 -0500
Received: from air.lug-owl.de ([62.52.24.190]:5136 "HELO air.lug-owl.de")
	by vger.kernel.org with SMTP id <S129768AbQKBKf3>;
	Thu, 2 Nov 2000 05:35:29 -0500
Date: Thu, 2 Nov 2000 11:35:23 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: vesafb doesn't work in 240t10?
Message-ID: <20001102113522.B14851@lug-owl.de>
Reply-To: jbglaw@lug-owl.de
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.02.10011021050140.10126-100000@prins.externet.hu> <3A01408D.6DBE85F9@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f0KYrhQ4vYSV2aJu"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A01408D.6DBE85F9@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Thu, Nov 02, 2000 at 05:23:09AM -0500
X-Operating-System: Linux air 2.4.0-test8-pre1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--f0KYrhQ4vYSV2aJu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 02, 2000 at 05:23:09AM -0500, Jeff Garzik wrote:
> Narancs 1 wrote:
> > I used to start vesafb like this:
> > /etc/lilo.conf:
> > vga=3D317
> vga takes a decimal number, but the number in vesafb.txt is
> hexidecimal.  Let us convert 0x317 to decimal:

> So, use "vga=3D791" in your lilo.conf.

lilo accepts hex values as well, AFAIK, so lets do:

	vga =3D 0x317

MfG, JBG

--=20
Fehler eingestehen, Gr=F6=DFe zeigen: Nehmt die Rechtschreibreform zur=FCck=
!!!
/* Jan-Benedict Glaw <jbglaw@lug-owl.de> -- +49-177-5601720 */
keyID=3D0x8399E1BB fingerprint=3D250D 3BCF 7127 0D8C A444 A961 1DBD 5E75 83=
99 E1BB
     "insmod vi.o and there we go..." (Alexander Viro on linux-kernel)

--f0KYrhQ4vYSV2aJu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.2 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjoBQ2oACgkQHb1edYOZ4bt8JACdF6dRWLtC9rrDRVQY8Hlzy9is
tcgAnRGyzV0GZ8dW5Ovmh+4WAZsG4dkU
=32/q
-----END PGP SIGNATURE-----

--f0KYrhQ4vYSV2aJu--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
