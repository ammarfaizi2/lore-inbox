Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265153AbTL2UCA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 15:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265130AbTL2UBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 15:01:20 -0500
Received: from viriato2.servicios.retecal.es ([212.89.0.45]:9904 "EHLO
	viriato2.servicios.retecal.es") by vger.kernel.org with ESMTP
	id S265146AbTL2T7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 14:59:09 -0500
Subject: Re: 2.6.0-mm2
From: Ramon Rey Vicente <rrey@ranty.pantax.net>
Reply-To: ramon.rey@hispalinux.es
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
In-Reply-To: <20031229013223.75c531ed.akpm@osdl.org>
References: <20031229013223.75c531ed.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-mqh/lLg6YG3ZU+C4aHP1"
Message-Id: <1072727943.1064.15.camel@debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 29 Dec 2003 20:59:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-mqh/lLg6YG3ZU+C4aHP1
Content-Type: multipart/mixed; boundary="=-tWjbdLgcBKH4xXvCnV7A"


--=-tWjbdLgcBKH4xXvCnV7A
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

El lun, 29-12-2003 a las 10:32, Andrew Morton escribi=C3=B3:

> +atapi-mo-support-update.patch
> +atapi-mo-support-timeout-fix.patch
>=20
>  ATAPI CDROM fixups.

This happen with 2.6.0-mm1 and -mm2. With 2.6.0 all is OK.

rrey@debian:~$ cdrecord cdrom-1.iso
Cdrecord-Clone 2.01a19 (i686-pc-linux-gnu) Copyright (C) 1995-2003 J=C3=B6r=
g
Schilling
scsidev: '/udev/hdc'
devname: '/udev/hdc'
scsibus: -2 target: -2 lun: -2
Warning: Open by 'devname' is unintentional and not supported.
cdrecord.mmap: No such file or directory. Cannot open '/udev/hdc'.
Cannot open SCSI driver.
cdrecord.mmap: For possible targets try 'cdrecord -scanbus'. Make sure
you are root.
cdrecord.mmap: For possible transport specifiers try 'cdrecord
dev=3Dhelp'.
cdrecord.mmap: Also make sure that you have loaded the sg driver and the
driver for
cdrecord.mmap: SCSI hardware, eg. ide-scsi if you run IDE/ATAPI drives
over
cdrecord.mmap: ide-scsi emulation. For more information, install the
cdrtools-doc
cdrecord.mmap: package and read
/usr/share/doc/cdrecord/README.ATAPI.setup .

The /udev/hdc have=20
brw-rw-rw-    1 root     cdrw      22,   0 2003-12-29 20:52 /udev/hdc

and my user is "cdrw" group. As superuser, the same problem.

The /proc/ide/hdc/ files attached.=20
--=20
Ram=C3=B3n Rey Vicente       <ramon dot rey at hispalinux dot es>
        jabber ID       <rreylinux at jabber dot org>
GPG public key ID 	0xBEBD71D5 -> http://pgp.escomposlinux.org/

--=-tWjbdLgcBKH4xXvCnV7A
Content-Description: 
Content-Disposition: inline; filename=proc_hdc.cfg
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

aWRlLWRlZmF1bHQgdmVyc2lvbiAwLjkubmV3aWRlDQo4NWMwIDAwMDAgMDAwMCAwMDAwIDAwMDAg
MDAwMCAwMDAwIDAwMDANCjAwMDAgMDAwMCAzMjMwIDMwMzAgMmYzMCAzNzJmIDMyMzcgMjAyMA0K
MjAyMCAyMDIwIDIwMjAgMjAyMCA2NTY1IDY1NjUgMDAwMCAzMTJlDQozMDM2IDIwMjAgMjAyMCA0
YzQ3IDIwNDMgNDQyZCA1MjU3IDIwNDMNCjQ1NDQgMmQzOCAzMDM4IDMwNDIgMjAyMCAyMDIwIDIw
MjAgMjAyMA0KMjAyMCAyMDIwIDIwMjAgMjAyMCAyMDIwIDIwMjAgMjAyMCAwMDAwDQowMDAwIDBm
MDAgMDAwMCAwNDAwIDAyMDAgMDAwMiAwMDAwIDAwMDANCjAwMDAgMDAwMCAwMDAwIDAwMDAgMDAw
MCAwMDAwIDAwMDcgMDQwNw0KMDAwMyAwMDc4IDAwNzggMDA3OCAwMDc4IDAwMDAgMDAwMCAwMDAw
DQowMDAwIDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAwIDAwMDANCjAwMDAgMDAwMCAwMDAw
IDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMA0KMDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAwIDAwMDAg
MDAwMCAwMDAwDQowMDAwIDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAwIDAwMDANCjAwMDAg
MDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMA0KMDAwMCAwMDAwIDAwMDAgMDAwMCAw
MDAwIDAwMDAgMDAwMCAwMDAwDQowMDAwIDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAwIDAw
MDANCjAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMA0KMDAwMCAwMDAwIDAw
MDAgMDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAwDQowMDAwIDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAw
MCAwMDAwIDAwMDANCjAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMA0KMDAw
MCAwMDAwIDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAwDQowMDAwIDAwMDAgMDAwMCAwMDAw
IDAwMDAgMDAwMCAwMDAwIDAwMDANCjAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAwIDAwMDAg
MDAwMA0KMDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAwDQowMDAwIDAwMDAg
MDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAwIDAwMDANCjAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMCAw
MDAwIDAwMDAgMDAwMA0KMDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAwDQow
MDAwIDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAwIDAwMDANCjAwMDAgMDAwMCAwMDAwIDAw
MDAgMDAwMCAwMDAwIDAwMDAgMDAwMA0KMDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAw
MCAwMDAwDQowMDAwIDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMCAwMDAwIDAwMDANCjAwMDAgMDAw
MCAwMDAwIDAwMDAgMDAwMCAwMDAwIDAwMDAgMDAwMA0KY2Ryb20NCkxHIENELVJXIENFRC04MDgw
Qg0KbmFtZQkJCXZhbHVlCQltaW4JCW1heAkJbW9kZQ0KLS0tLQkJCS0tLS0tCQktLS0JCS0tLQkJ
LS0tLQ0KY3VycmVudF9zcGVlZCAgICAgICAgICAgMzQgICAgICAgICAgICAgIDAgICAgICAgICAg
ICAgICA3MCAgICAgICAgICAgICAgcncNCmlkZS1zY3NpICAgICAgICAgICAgICAgIDAgICAgICAg
ICAgICAgICAwICAgICAgICAgICAgICAgMSAgICAgICAgICAgICAgIHJ3DQppbml0X3NwZWVkICAg
ICAgICAgICAgICAxMiAgICAgICAgICAgICAgMCAgICAgICAgICAgICAgIDcwICAgICAgICAgICAg
ICBydw0KaW9fMzJiaXQgICAgICAgICAgICAgICAgMSAgICAgICAgICAgICAgIDAgICAgICAgICAg
ICAgICAzICAgICAgICAgICAgICAgcncNCmtlZXBzZXR0aW5ncyAgICAgICAgICAgIDAgICAgICAg
ICAgICAgICAwICAgICAgICAgICAgICAgMSAgICAgICAgICAgICAgIHJ3DQpuaWNlMSAgICAgICAg
ICAgICAgICAgICAxICAgICAgICAgICAgICAgMCAgICAgICAgICAgICAgIDEgICAgICAgICAgICAg
ICBydw0KbnVtYmVyICAgICAgICAgICAgICAgICAgMiAgICAgICAgICAgICAgIDAgICAgICAgICAg
ICAgICAzICAgICAgICAgICAgICAgcncNCnBpb19tb2RlICAgICAgICAgICAgICAgIHdyaXRlLW9u
bHkgICAgICAwICAgICAgICAgICAgICAgMjU1ICAgICAgICAgICAgIHcNCnNsb3cgICAgICAgICAg
ICAgICAgICAgIDAgICAgICAgICAgICAgICAwICAgICAgICAgICAgICAgMSAgICAgICAgICAgICAg
IHJ3DQp1bm1hc2tpcnEgICAgICAgICAgICAgICAxICAgICAgICAgICAgICAgMCAgICAgICAgICAg
ICAgIDEgICAgICAgICAgICAgICBydw0KdXNpbmdfZG1hICAgICAgICAgICAgICAgMSAgICAgICAg
ICAgICAgIDAgICAgICAgICAgICAgICAxICAgICAgICAgICAgICAgcncNCg==

--=-tWjbdLgcBKH4xXvCnV7A--

--=-mqh/lLg6YG3ZU+C4aHP1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/8IeFRGk68b69cdURAmcrAJ0RopQjSmsyT9khuo4cyH6S+M4yYACeP1Ap
hYOj/jDUVaYmCXzkRBPWTPw=
=RuDl
-----END PGP SIGNATURE-----

--=-mqh/lLg6YG3ZU+C4aHP1--

