Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131979AbQLHPFA>; Fri, 8 Dec 2000 10:05:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129841AbQLHPEu>; Fri, 8 Dec 2000 10:04:50 -0500
Received: from air.lug-owl.de ([62.52.24.190]:9232 "HELO air.lug-owl.de")
	by vger.kernel.org with SMTP id <S131979AbQLHPEh>;
	Fri, 8 Dec 2000 10:04:37 -0500
Date: Fri, 8 Dec 2000 15:34:09 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [Fwd: NTFS repair tools]
Message-ID: <20001208153408.A19802@lug-owl.de>
Reply-To: jbglaw@lug-owl.de
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3A30552D.A6BE248C@timpanogas.org> <20001207221347.R6567@cadcamlab.org> <3A3066EC.3B657570@timpanogas.org> <20001208005337.A26577@alcove.wittsend.com> <3A306994.63DB8208@timpanogas.org> <4.3.2.7.2.20001208081657.00b15220@mail.osagesoftware.com> <20001208144342.B25391@khan.acc.umu.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001208144342.B25391@khan.acc.umu.se>; from tao@acc.umu.se on Fri, Dec 08, 2000 at 02:43:42PM +0100
X-Operating-System: Linux air 2.4.0-test8-pre1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 08, 2000 at 02:43:42PM +0100, David Weinehall wrote:
> On Fri, Dec 08, 2000 at 08:19:46AM -0500, David Relson wrote:
> > At 11:54 PM 12/7/00, Jeff V. Merkey wrote:

> No amount of warnings can prevent morons from f**king up. Unix gives
> you enough rope et al. I'm not arguing for removal of any warning, but
> seriously, if we have a loud (DANGEROUS) warning in the config-system
> aaaaaand a warning in the help-text that the write-support probably will
> mess up your fs, how much more can you do? I bet that if we remove the

Well, simply insert sth. like this into ./fs/ntfs/fs.c:parse_options()

printk(KERN_EMERG "You're likely to crash your NTFS if you do any "
	"write attempts to it. NTFS write support is broken and for "
	"developers *only*. Do only use this if you're debugging it, "
	"never ever use this on data you'd like to see tomorrow "
	"again!!! Please remount in read-only mode *now* or don't "
	"complain afterwards!");

Maybe that can prevent pupils^H^H^H^H^Heople from shooting their
foots...

MfG, JBG

--=20
Fehler eingestehen, Gr=F6=DFe zeigen: Nehmt die Rechtschreibreform zur=FCck=
!!!
/* Jan-Benedict Glaw <jbglaw@lug-owl.de> -- +49-177-5601720 */
keyID=3D0x8399E1BB fingerprint=3D250D 3BCF 7127 0D8C A444 A961 1DBD 5E75 83=
99 E1BB
     "insmod vi.o and there we go..." (Alexander Viro on linux-kernel)

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.2 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjow8WAACgkQHb1edYOZ4bs7/ACgiHIz9n2tMYGp7O9DVxp/ys9r
/0gAnRb7Dd7A9g0STZBvx14to7rQY3sY
=Ru7K
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
