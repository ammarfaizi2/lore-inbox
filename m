Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268001AbTAMSHn>; Mon, 13 Jan 2003 13:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268140AbTAMSHn>; Mon, 13 Jan 2003 13:07:43 -0500
Received: from dialin-145-254-148-171.arcor-ip.net ([145.254.148.171]:2688
	"HELO schottelius.net") by vger.kernel.org with SMTP
	id <S268001AbTAMSHm>; Mon, 13 Jan 2003 13:07:42 -0500
Date: Mon, 13 Jan 2003 10:02:00 +0100
From: Nico Schottelius <schottelius@wdt.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [2.5.56] (partial known) bugs/compile errors
Message-ID: <20030113090200.GA1096@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux flapp 2.5.54
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

compile problems:

drivers/message/i2o/i2o_lan.c:
   contains undeclared run_i2o_post_buckets_task
   problems with a structure (line 1406)

module problems: (already known ?)

WARNING: /lib/modules/2.5.56/kernel/sound/soundcore.ko needs unknown symbol=
 errno

errno missing ?

WARNING: /lib/modules/2.5.56/kernel/drivers/scsi/pcmcia/aha152x_cs.ko needs=
 unknown symbol aha152x_driver_template
WARNING: /lib/modules/2.5.56/kernel/drivers/scsi/pcmcia/fdomain_cs.ko needs=
 unknown symbol fdomain_driver_template
WARNING: /lib/modules/2.5.56/kernel/drivers/scsi/pcmcia/fdomain_cs.ko needs=
 unknown symbol fdomain_16x0_reset
WARNING: /lib/modules/2.5.56/kernel/drivers/scsi/pcmcia/fdomain_cs.ko needs=
 unknown symbol fdomain_setup
WARNING: /lib/modules/2.5.56/kernel/drivers/message/i2o/i2o_pci.ko needs un=
known symbol i2o_sys_init
WARNING: /lib/modules/2.5.56/kernel/security/root_plug.ko needs unknown sym=
bol usb_bus_list_lock
WARNING: /lib/modules/2.5.56/kernel/security/root_plug.ko needs unknown sym=
bol usb_bus_list
WARNING: /lib/modules/2.5.56/kernel/fs/nfsd/nfsd.ko needs unknown symbol ha=
sh_mem
WARNING: /lib/modules/2.5.56/kernel/arch/i386/kernel/microcode.ko needs unk=
nown symbol devfs_set_file_size


Greetings,

Nico

--=20
Please send your messages pgp-signed and/or pgp-encrypted (don't encrypt ma=
ils
to mailing list!). If you don't know what pgp is visit www.gnupg.org.
(public pgp key: ftp.schottelius.org/pub/familiy/nico/pgp-key)

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE+IoCItnlUggLJsX0RAthCAKCHxDbHz0kOfQRY392w+i7KfPnP1wCffGkL
HwHvDzGCU6nY2G0STyVFbH4=
=JJtl
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
