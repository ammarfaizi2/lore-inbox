Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267416AbTAQHVb>; Fri, 17 Jan 2003 02:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267417AbTAQHVb>; Fri, 17 Jan 2003 02:21:31 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:39400 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S267416AbTAQHVa>; Fri, 17 Jan 2003 02:21:30 -0500
Date: Fri, 17 Jan 2003 08:30:27 +0100
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: jsimmons@infradead.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.59
Message-Id: <20030117083027.6410d4b0.us15@os.inf.tu-dresden.de>
In-Reply-To: <20030117081516.357ee146.us15@os.inf.tu-dresden.de>
References: <Pine.LNX.4.44.0301161826430.8879-100000@penguin.transmeta.com>
	<20030117081516.357ee146.us15@os.inf.tu-dresden.de>
Organization: Disorganized
X-Mailer: Sylpheed version 0.8.8claws22 (GTK+ 1.2.10; Linux 2.5.59)
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.Ok'yxHc3rcW3gx"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.Ok'yxHc3rcW3gx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Hi James,

Here's some other info from boot messages that suggests something is going wrong.

rivafb: nVidia device/chipset 10DE0150
rivafb: RIVA MTRR set to ON
rivafb: PCI nVidia NV10 framebuffer ver 0.9.5b (nVidiaGeForce2-G, 32MB @ 0xC8000000)
Badness in kobject_register at lib/kobject.c:152
Call Trace:
 [<c0209ef8>] kobject_register+0x58/0x70
 [<c024532b>] bus_add_driver+0x5b/0xe0
 [<c024579f>] driver_register+0x2f/0x40
 [<c0176208>] create_proc_entry+0x88/0xd0
 [<c020fe37>] pci_register_driver+0x47/0x60
 [<c010507a>] init+0x3a/0x160
 [<c0105040>] init+0x0/0x160
 [<c010713d>] kernel_thread_helper+0x5/0x18

Console: switching to colour frame buffer device 144x54


Regards,
-Udo.

--=.Ok'yxHc3rcW3gx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.3.1 (GNU/Linux)

iD8DBQE+J7ETnhRzXSM7nSkRAuQIAJ9+OAItTQn+wE2E7NLJ6JmMykXTcgCfTiEh
bkGHUTHhraef4GIbzWiSDkk=
=C88d
-----END PGP SIGNATURE-----

--=.Ok'yxHc3rcW3gx--
