Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267464AbUHSWNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267464AbUHSWNK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 18:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267465AbUHSWNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 18:13:10 -0400
Received: from nwkea-mail-1.sun.com ([192.18.42.13]:34234 "EHLO
	nwkea-mail-1.sun.com") by vger.kernel.org with ESMTP
	id S267464AbUHSWND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 18:13:03 -0400
Date: Thu, 19 Aug 2004 15:13:00 -0700
From: Thomas Duffy <Thomas.Duffy.99@alumni.brown.edu>
Subject: oops on 2.6.8.1-mm2
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Message-id: <1092953580.31347.45.camel@duffman>
MIME-version: 1.0
X-Mailer: Evolution 1.5.93 (1.5.93-2)
Content-type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="=-+VQu6LtKrVJfruXZcEwT"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+VQu6LtKrVJfruXZcEwT
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

This is on a dual Opteron with nvidia CK804.

CPU 0
Modules linked in: ehci_hcd button battery asus_acpi ac xfs qla2322 qla2xxx=
 scsi_transport_fc sd_mod scsi_mod
Pid: 507, comm: modprobe Not tainted 2.6.8.1-mm2
RIP: 0010:[<ffffffff8048eb81>] <ffffffff8048eb81>{add_pin_to_irq+1}
RSP: 0018:00000100cf245d00  EFLAGS: 00000212
RAX: 0000000000000089 RBX: 0000000000000017 RCX: 0000000000000080
RDX: 0000000000000017 RSI: 0000000000000000 RDI: 0000000000000017
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000000 R14: 0000000000000017 R15: 0000000000000000
FS:  0000002a9557b4c0(0000) GS:ffffffff8047ef80(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000420f30 CR3: 0000000000101000 CR4: 00000000000006e0
Process modprobe (pid: 507, threadinfo 00000100cf244000, task 000001007f0ce=
ee0)
Stack: ffffffff80120778 0000000000000000 0000000000000000 0000000000000000
       0100000000018900 0000000000000000 ffffffff80219834 0000000000000017
       0000000000000001 0000000000000000
Call Trace:<ffffffff80120778>{io_apic_set_pci_routing+152} <ffffffff8021983=
4>{acpi_pci_link_allocate+266}
       <ffffffff8011c7e8>{acpi_register_gsi+104} <ffffffff80219db8>{acpi_pc=
i_irq_lookup+59}
       <ffffffff80219f95>{acpi_pci_irq_enable+265} <ffffffff802bcee6>{pcibi=
os_enable_device+22}
       <ffffffff801f7746>{pci_enable_device_bars+38} <ffffffff801f7775>{pci=
_enable_device+21}
       <ffffffff8029eb26>{usb_hcd_pci_probe+70} <ffffffff801bde59>{sysfs_ma=
ke_dirent+41}
       <ffffffff801f8dfd>{pci_device_probe_static+61} <ffffffff801f8e59>{__=
pci_device_probe+41}
       <ffffffff801f8eb0>{pci_device_probe+48} <ffffffff80245d97>{bus_match=
+71}
       <ffffffff80245eb6>{driver_attach+70} <ffffffff80246385>{bus_add_driv=
er+133}
       <ffffffff801f9179>{pci_register_driver+121} <ffffffffa00fd01d>{:ehci=
_hcd:init+29}
       <ffffffff80154c1e>{sys_init_module+270} <ffffffff8011194a>{system_ca=
ll+126}
       =20


--=-+VQu6LtKrVJfruXZcEwT
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBJSXsdY502zjzwbwRAv4nAJ9ePD7d1OzOY9Ywp8mccUZBPwkO3QCeI9FT
DFVRUN2Fl/6O67PgUp6XGEM=
=VFte
-----END PGP SIGNATURE-----

--=-+VQu6LtKrVJfruXZcEwT--

