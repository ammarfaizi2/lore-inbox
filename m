Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261653AbTCPXex>; Sun, 16 Mar 2003 18:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261665AbTCPXex>; Sun, 16 Mar 2003 18:34:53 -0500
Received: from B51f4.pppool.de ([213.7.81.244]:1470 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S261653AbTCPXes>; Sun, 16 Mar 2003 18:34:48 -0500
Subject: Re: IDE won't compile as module in 2.5.64
From: Daniel Egger <degger@fhm.edu>
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <1047857872.5494.21.camel@sonja>
References: <1047857872.5494.21.camel@sonja>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-NyjRQ+R7mTW7YnnSJVtw"
Organization: 
Message-Id: <1047858285.5495.27.camel@sonja>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 17 Mar 2003 00:44:46 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-NyjRQ+R7mTW7YnnSJVtw
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Mon, 2003-03-17 um 00.37 schrieb Daniel Egger:

> I tried to figure out what's wrong and it seems that the make machinery
> is not up-to-date since none of the code in question is dependent on
> the definition of MODULE or alike.

Being a big fan of quoting myself; the above statement is not entirely
accurate. This is the error I get when

"ATA/ATAPI/MFM/RLL device support" is built in and
"Enhanced IDE/MFM/RLL disk/cdrom/tape/floppy support" built as module

In case both are built as module I get:
*** Warning: "ide_pci_unregister_driver" [drivers/ide/pci/sis5513.ko] undef=
ined!
*** Warning: "ide_pci_register_driver" [drivers/ide/pci/sis5513.ko] undefin=
ed!
*** Warning: "ide_setup_pci_device" [drivers/ide/pci/sis5513.ko] undefined!
*** Warning: "ide_setup_dma" [drivers/ide/pci/sis5513.ko] undefined!
*** Warning: "ide_pci_register_host_proc" [drivers/ide/pci/sis5513.ko] unde=
fined!
*** Warning: "proc_ide_destroy" [drivers/ide/ide.ko] undefined!
*** Warning: "ide_remove_proc_entries" [drivers/ide/ide.ko] undefined!
*** Warning: "ide_add_proc_entries" [drivers/ide/ide.ko] undefined!
*** Warning: "proc_ide_create" [drivers/ide/ide.ko] undefined!
*** Warning: "ide_scan_pcibus" [drivers/ide/ide.ko] undefined!
*** Warning: "create_proc_ide_interfaces" [drivers/ide/ide.ko] undefined!
*** Warning: "ide_release_dma" [drivers/ide/ide.ko] undefined!
*** Warning: "destroy_proc_ide_drives" [drivers/ide/ide.ko] undefined!
*** Warning: "proc_ide_read_capacity" [drivers/ide/ide.ko] undefined!
*** Warning: "ide_xlate_1024" [drivers/ide/ide-probe.ko] undefined!
*** Warning: "create_proc_ide_interfaces" [drivers/ide/ide-probe.ko] undefi=
ned!
*** Warning: "ide_bus_type" [drivers/ide/ide-probe.ko] undefined!
*** Warning: "ide_add_generic_settings" [drivers/ide/ide-probe.ko] undefine=
d!
*** Warning: "do_ide_request" [drivers/ide/ide-probe.ko] undefined!
*** Warning: "proc_ide_read_geometry" [drivers/ide/ide-disk.ko] undefined!

Is there a reason that no entries of "IDE, ATA and ATAPI Block devices"
are not being merged into "ATA/ATAPI/MFM/RLL device support"?

--=20
Servus,
       Daniel


--=-NyjRQ+R7mTW7YnnSJVtw
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+dQxtchlzsq9KoIYRArQlAJwL4CC+WiDg71TIogKEdGFig+cNgACg0vlx
HFcX7+3IThGAqGyIztF/q+I=
=omvg
-----END PGP SIGNATURE-----

--=-NyjRQ+R7mTW7YnnSJVtw--

