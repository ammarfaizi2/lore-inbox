Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129597AbQLDPiQ>; Mon, 4 Dec 2000 10:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129830AbQLDPiG>; Mon, 4 Dec 2000 10:38:06 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:60170 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S130199AbQLDPh5>; Mon, 4 Dec 2000 10:37:57 -0500
Date: Mon, 4 Dec 2000 16:05:54 +0100
From: Kurt Garloff <garloff@suse.de>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: Andre Hedrick <andre@linux-ide.org>, e.ckhard@u-code.de, marcel@mesa.nl,
        linux-kernel@vger.kernel.org
Subject: Re: IDE_TAPE problem wiht ONSTREAM DI30
Message-ID: <20001204160554.L6281@garloff.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Rogier Wolff <R.E.Wolff@BitWizard.nl>,
	Andre Hedrick <andre@linux-ide.org>, e.ckhard@u-code.de,
	marcel@mesa.nl, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10012032315100.13699-100000@master.linux-ide.org> <200012040825.JAA08264@cave.bitwizard.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="7vAdt9JsdkkzRPKN"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200012040825.JAA08264@cave.bitwizard.nl>; from R.E.Wolff@BitWizard.nl on Mon, Dec 04, 2000 at 09:25:33AM +0100
X-Operating-System: Linux 2.2.16 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TUE/NL, SuSE/FRG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7vAdt9JsdkkzRPKN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Dec 04, 2000 at 09:25:33AM +0100, Rogier Wolff wrote:
> Stay away from onstream is my advice nowadays.=20

I've been using the USB and the SCSI versions of OnStream tapes with=20
good success!

> We've been trying to get the stupid thing to work since july 8th, and
> onstream technical support has been very helpful by telling us what to
> do and such.=20

If you want a really helpful advice:
Use the osst driver and the use it with ide-scsi.
Report problems to the osst mailing list.=20
So far, I'm not aware of anybody we failed to help.
http://linux1.onstream.nl/test/

> Like downgrading to a kernel version that has known remote attacks.

Who did give such a stupid advice?

> However doing that does not solve the problems we
> report. After much ado, they promise to "escalate" the problem to=20
> people in the states, and then this does not lead to results in=20
> the month we've given them.=20

I'm afraid I do not know too much about the ide-tape support for DI-30.
Gadi Oxman is the author of it (has been paid by OnStream to write it, BTW),
but he may be short on time at the moment to help you with the problem.

> If you start using a backup program that needs to seek back and forth
> a few times, the drive loses track where it is, and doesn't recover
> from this situation.

I don't know whether this is a hard- or a software problem in your case.

> I've returned mine to my vendor, and I hope that Onstream gets the
> message in the end: They do NOT support Linux.=20

I have a completely different impression. Otherwise neither the DI-30 would
be supported by ide-tape, nor would there be the osst driver, supporting
SC-x0, DI-30 (over ide-scsi) and USB30 (usb-storage in 2.4 w/ Freecom
support).

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, FRG                               SCSI, Security

--7vAdt9JsdkkzRPKN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6K7LRxmLh6hyYd04RAmC7AJ41l/yoaaFoHQ9nBzAX3oMgbm+c+ACeOOA1
2g7b71El3/NpeKDC+7hQ2qo=
=iKEe
-----END PGP SIGNATURE-----

--7vAdt9JsdkkzRPKN--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
