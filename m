Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131009AbQJ1QGn>; Sat, 28 Oct 2000 12:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130985AbQJ1QGY>; Sat, 28 Oct 2000 12:06:24 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:49422 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S130770AbQJ1QGG>; Sat, 28 Oct 2000 12:06:06 -0400
Date: Sat, 28 Oct 2000 18:04:11 +0200
From: Kurt Garloff <garloff@suse.de>
To: Benson Chow <blc@q.dyndns.org>
Cc: linux-kernel@vger.kernel.org, Linux SCSI list <linux-scsi@vger.kernel.org>
Subject: Re: Tekram's TRM-1040S USCSI proc driver?
Message-ID: <20001028180411.A19832@garloff.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Benson Chow <blc@q.dyndns.org>, linux-kernel@vger.kernel.org,
	Linux SCSI list <linux-scsi@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0010271822330.31743-100000@q.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0010271822330.31743-100000@q.dyndns.org>; from blc@q.dyndns.org on Fri, Oct 27, 2000 at 06:25:45PM -0600
X-Operating-System: Linux 2.2.16 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TUE/NL, SuSE/FRG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Benson,

On Fri, Oct 27, 2000 at 06:25:45PM -0600, Benson Chow wrote:
> Anyone know if Tekram's DC315/DC395 SCSI driver will be incorporated
> into the kernel distribution?  I think their driver is GPL, or was there
> some other reason it wasn't incorporated?
>=20
> Their source code is on their website...

and newer sources can be found on my website as I am the maintainer of this
driver:
http://www.garloff.de/kurt/linux/dc395/
You find everyhting you need to compile a driver module (or to incorporate
it into the kernel) for 2.2 and 2.4 kernels.

> Just wonderring... (unfortunately I had a DC315 for a day but had to give
> it up... it was the worst of the AHA2940A and DC390F that I already
> had...)

As Matthias pointed out correctly: I did not ask for inclusion into the
mainstream kernel yet.

There's a reason for this:
The driver works only for 98% of the people.
Then there is one percent with weird problems that I can't understand at all
(PCI DMA errors or spontaneous reboots ...)
And one percent, where the driver ends up aborting commands, not recovering
and finally sometimes corrupting data.

It's the latter that worries me and I do not want to push the driver into
the kernel, as long as I do not understand and solved these issues.
After all, it's not a sound driver that just fails to operate, but a SCSI
driver which you entrust your data to.

Sorry!

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, FRG                               SCSI, Security

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE5+vj7xmLh6hyYd04RAuOEAKC3TSyR+AIcKtMqIiYN96bMPdtejgCbB+io
eJGKsy18EaO1jDuUPJavf2k=
=rc5p
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
