Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265379AbTIJRlp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 13:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265383AbTIJRlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 13:41:45 -0400
Received: from D720c.pppool.de ([80.184.114.12]:33508 "EHLO
	karin.de.interearth.com") by vger.kernel.org with ESMTP
	id S265379AbTIJRlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 13:41:42 -0400
Subject: Re: [PATCH] 2.4.23-pre3 ACPI fixes series (1/3)
From: Daniel Egger <degger@fhm.edu>
To: Andrew de Quincey <adq_dvb@lidskialf.net>
Cc: Jeff Garzik <jgarzik@pobox.com>, torvalds@osdl.org,
       lkml <linux-kernel@vger.kernel.org>, acpi-devel@lists.sourceforge.net,
       linux-acpi@intel.com
In-Reply-To: <200309060115.24340.adq_dvb@lidskialf.net>
References: <200309051958.02818.adq_dvb@lidskialf.net>
	 <200309060016.16545.adq_dvb@lidskialf.net> <3F590E28.6090101@pobox.com>
	 <200309060115.24340.adq_dvb@lidskialf.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-KeEGG+OvUDx0iu/mawmN"
Message-Id: <1063207880.7657.1.camel@sonja>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 10 Sep 2003 17:31:21 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-KeEGG+OvUDx0iu/mawmN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Sam, 2003-09-06 um 02.15 schrieb Andrew de Quincey:

> This patch allows ACPI to drop back to PIC mode if ACPI mode setup fails.

Those patches work miracles for me. Finally I can use my ECS L7VTA with
KT400 chipset with IO-APIC in ACPI mode.

egger@alex:/proc$ cat /proc/interrupts
           CPU0
  0:     119774    IO-APIC-edge  timer
  1:        881    IO-APIC-edge  keyboard
  2:          0          XT-PIC  cascade
  8:          1    IO-APIC-edge  rtc
  9:          0    IO-APIC-edge  acpi
 14:          7    IO-APIC-edge  ide0
 15:         39    IO-APIC-edge  ide1
 16:         57   IO-APIC-level  ohci1394
 17:          0   IO-APIC-level  eth1
 19:          2   IO-APIC-level  ymfpci
 21:          0   IO-APIC-level  usb-uhci, usb-uhci, usb-uhci, ehci_hcd
 23:     253525   IO-APIC-level  eth0
NMI:          0
LOC:     119715
ERR:          0
MIS:          0

--=20
Servus,
       Daniel

--=-KeEGG+OvUDx0iu/mawmN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/X0PIchlzsq9KoIYRAsHyAJ9WSEkn9d3InzndOoziHL25O242DACgynpk
GUQ01q1oYmD40Ak2x6Im+c0=
=2CHn
-----END PGP SIGNATURE-----

--=-KeEGG+OvUDx0iu/mawmN--

