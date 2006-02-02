Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932347AbWBBWYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbWBBWYG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 17:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbWBBWYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 17:24:06 -0500
Received: from smtp06.auna.com ([62.81.186.16]:19642 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S932347AbWBBWYF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 17:24:05 -0500
Date: Thu, 2 Feb 2006 23:28:58 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1-mm4
Message-ID: <20060202232858.0c5d5e9a@werewolf.auna.net>
In-Reply-To: <20060129144533.128af741.akpm@osdl.org>
References: <20060129144533.128af741.akpm@osdl.org>
X-Mailer: Sylpheed-Claws 2.0.0cvs9 (GTK+ 2.8.11; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_P3/7LUr1PizhwMQ6tz4HuTW";
 protocol="application/pgp-signature"; micalg=PGP-SHA1
X-Auth-Info: Auth:LOGIN IP:[83.138.209.184] Login:jamagallon@able.es Fecha:Thu, 2 Feb 2006 23:24:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_P3/7LUr1PizhwMQ6tz4HuTW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sun, 29 Jan 2006 14:45:33 -0800, Andrew Morton <akpm@osdl.org> wrote:

>=20
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc1/=
2.6.16-rc1-mm4/
>=20
>

I have problems with ide-floppy.
Do not know if they are specific to this latest release, as I did not use
my ZIP drive since long ago...Now I tried to make a boot zip with grub.

I inserted a mac floppy, partitioned it as hdb1, and as soon as fdisk wrote
the partition table and forced a reread, the system began to scan the
zip like crazy, and nothing appears on /proc/partitions ...

Ejected the disk, rmmod ide-floppy, insert the disk and everything is quiet.
As soon as insmod ide-floppy, the party starts on syslog:

ide-floppy driver 0.99.newide
hdb: 244766kB, 489532 blocks, 512 sector size
hdb: 244736kB, 239/64/32 CHS, 4096 kBps, 512 sector size, 2941 rpm
hdb: The disk reports a capacity of 250640384 bytes, but the drive only han=
dles 250609664
hdb: The disk reports a capacity of 250640384 bytes, but the drive only han=
dles 250609664
hdb: hdb1

<last 3 messages repeated forever>

Funny...
Some truncation error anywhere ?

TIA

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandriva Linux release 2006.1 (Cooker) for i586
Linux 2.6.15-jam7 (gcc 4.0.2 (4.0.2-1mdk for Mandriva Linux release 2006.1))

--Sig_P3/7LUr1PizhwMQ6tz4HuTW
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD4oeqRlIHNEGnKMMRAlNuAJ9a/TlXSePnVqYkmV0CTRGfEnnuaACeM4mz
mLaaaxEhz3cCrh0guCwVqTY=
=SktU
-----END PGP SIGNATURE-----

--Sig_P3/7LUr1PizhwMQ6tz4HuTW--
