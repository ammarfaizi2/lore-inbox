Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318758AbSHBJJE>; Fri, 2 Aug 2002 05:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318766AbSHBJJE>; Fri, 2 Aug 2002 05:09:04 -0400
Received: from [213.69.232.58] ([213.69.232.58]:27656 "HELO schottelius.org")
	by vger.kernel.org with SMTP id <S318758AbSHBJJD>;
	Fri, 2 Aug 2002 05:09:03 -0400
Date: Fri, 2 Aug 2002 05:40:28 +0200
From: Nico Schottelius <nico-mutt@schottelius.org>
To: Anton Altaparmakov <aia21@cantab.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Bugs in 2.5.28 [scsi/framebuffer/devfs/floppy/ntfs/trident]
Message-ID: <20020802034028.GD2236@schottelius.org>
References: <5.1.0.14.2.20020730172158.02014160@pop.cus.cam.ac.uk> <20020731175743.GB1249@schottelius.org> <5.1.0.14.2.20020730172158.02014160@pop.cus.cam.ac.uk> <5.1.0.14.2.20020801134624.00aabec0@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FEz7ebHBGB6b2e8X"
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20020801134624.00aabec0@pop.cus.cam.ac.uk>
User-Agent: Mutt/1.4i
X-MSMail-Priority: Is not really needed
X-Mailer: Yam on Linux ?
X-Operating-System: Linux flapp 2.5.29
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FEz7ebHBGB6b2e8X
Content-Type: multipart/mixed; boundary="2Z2K0IlrPCVsbNpk"
Content-Disposition: inline


--2Z2K0IlrPCVsbNpk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Anton Altaparmakov [Thu, Aug 01, 2002 at 02:02:00PM +0100]:
> >It has never been an oops and actually 2.5.29 does _not_ hangup anymore!
> >Still it stops to copy the files and aborts.
> >I am currently retrying with debug enabled...
> >
> >> Also it may be useful to have the debug output from ntfs (depending on=
=20
> >what
> >> the errors/oops say - they may be sufficient to pinpoint the problem),=
=20
> >i.e.
> >> enable debugging when configuring the kernel, and then as root do: ech=
o=20
> >1 >
> >> /proc/sys/fs/ntfs-debug. Note this will absolutely flood you with debug
> >> output so the system will run slow as hell... So it is best to only=20
> >enable
> >> debug messages just before the error occurs if that is possible.
> >
> >oops. forget that above. Oh yes, ntfs is really reporting much.
> >You can find the output at ftp.schottelius.org:/pub/tmp, it's about
> >600k compressed.
>=20
> Where is it? It doesn't appear - I just looked...

I though i just cp'ed it...but I forget to move it from my home..
now you'll find it.


Nico

Btw, ntfs does not compile in 2.5.30 anymore. Neither with or without debug.

--=20
Changing mail address: please forget all known @pcsystems.de addresses.

Please send your messages pgp-signed and/or pgp-encrypted (don't encrypt ma=
ils
to mailing list!). If you don't know what pgp is visit www.gnupg.org.
(public pgp key: ftp.schottelius.org/pub/familiy/nico/pgp-key)

--2Z2K0IlrPCVsbNpk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.5.30-compile-errors"
Content-Transfer-Encoding: quoted-printable

<M> NTFS file system support (read only)=20
   [*]   NTFS debugging support=20

make[3]: Entering directory `/usr/src/linux-2.5.30/fs/partitions'
gcc -Wp,-MD,./.check.o.d -D__KERNEL__ -I/usr/src/linux-2.5.30/include -Wall=
 -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-al=
iasing -fno-common -pipe -mpreferred-stack-boundary=3D2 -march=3Di686 -nost=
dinc -iwithprefix include    -DKBUILD_BASENAME=3Dcheck -DEXPORT_SYMTAB  -c =
-o check.o check.c
check.c: In function `devfs_register_partitions':
check.c:470: array subscript is not an integer


--2Z2K0IlrPCVsbNpk--

--FEz7ebHBGB6b2e8X
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9Sf8stnlUggLJsX0RAv6rAKCDM0LTTnMv5FEOOrulNg29YpC+vACfSQwV
dOEqgKHbHyNkn7ZiRRMu0t0=
=bVbQ
-----END PGP SIGNATURE-----

--FEz7ebHBGB6b2e8X--
