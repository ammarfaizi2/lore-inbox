Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129289AbQLSMWO>; Tue, 19 Dec 2000 07:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129370AbQLSMWF>; Tue, 19 Dec 2000 07:22:05 -0500
Received: from Cantor.suse.de ([194.112.123.193]:13573 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129289AbQLSMVy>;
	Tue, 19 Dec 2000 07:21:54 -0500
Date: Tue, 19 Dec 2000 12:49:48 +0100
From: Kurt Garloff <garloff@suse.de>
To: "Theodore Y. Ts'o" <tytso@MIT.EDU>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: /dev/random: really secure?
Message-ID: <20001219124948.P17777@garloff.suse.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	"Theodore Y. Ts'o" <tytso@MIT.EDU>,
	Linux kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20001218213801.A19903@pcep-jamie.cern.ch> <200012182133.QAA02136@tsx-prime.MIT.EDU>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="v9g2r9e2kvGs7M7R"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200012182133.QAA02136@tsx-prime.MIT.EDU>; from tytso@MIT.EDU on Mon, Dec 18, 2000 at 04:33:13PM -0500
X-Operating-System: Linux 2.2.16 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TUE/NL, SuSE/FRG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--v9g2r9e2kvGs7M7R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2000 at 04:33:13PM -0500, Theodore Y. Ts'o wrote:
> Note that writing to /dev/random does *not* update the entropy estimate,
> for this very reason.  The assumption is that inputs to the entropy
> estimator have to be trusted, and since /dev/random is typically
> world-writeable, it is not so trusted.

It should not be world-writeable, IMHO. So the only one who can feed entropy
there is root, who should know aht (s)he's doing ...
Here (SuSE Linux 7.x), it is 644:
crw-r--r--    1 root     root       1,   8 Dec 17 22:41 /dev/random
crw-r--r--    1 root     root       1,   9 Dec 17 22:41 /dev/urandom

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, FRG                               SCSI, Security

--v9g2r9e2kvGs7M7R
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6P0tcxmLh6hyYd04RArQPAJwKN0vILGrjo6ErCKw+IW7KEBKVvwCgonFp
/6GKWMDwG0LOAURneb+no70=
=L/AB
-----END PGP SIGNATURE-----

--v9g2r9e2kvGs7M7R--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
