Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262652AbTLFAzc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 19:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264938AbTLFAzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 19:55:31 -0500
Received: from c-130372d5.012-136-6c756e2.cust.bredbandsbolaget.se ([213.114.3.19]:40335
	"EHLO pomac.netswarm.net") by vger.kernel.org with ESMTP
	id S262652AbTLFAzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 19:55:11 -0500
Subject: Re: Catching NForce2 lockup with NMI watchdog - found?
From: Ian Kumlien <pomac@vapor.com>
To: linux-kernel@vger.kernel.org
Cc: cbradney@zip.com.au, prakashpublic@gmx.de, cheuche+lkml@free.fr
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-CyTghudFEoIEjFShsfc+"
Message-Id: <1070672114.2759.8.camel@big.pomac.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 06 Dec 2003 01:55:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-CyTghudFEoIEjFShsfc+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Craig Bradney wrote:
> Sounds great.. maybe you have come across something. Yes, the CPU
> Disconnect function arrived in your BIOS in revision of 2003/03/27
> "6.Adds"CPU Disconnect Function" to adjust C1 disconnects. The Chipset
> does not support C2 disconnect; thus, disable C2 function."

I doubt thats related, i run ACPI with powersave anyways...=20

> For me though.. Im on an ASUS A7N8X Deluxe v2 BIOS 1007. From what I can
> see the CPU Disconnect isnt even in the Uber BIOS 1007 for this ASUS
> that has been discussed.

I don't have it either...=20

I'm more hopeful about the patch from Mathieu <cheuche+lkml () free ! fr>..=
.

           CPU0
  0:     267486    IO-APIC-edge  timer
  1:       9654    IO-APIC-edge  keyboard
  2:          0          XT-PIC  cascade
  8:          1    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 14:      28252    IO-APIC-edge  ide0
 15:        103    IO-APIC-edge  ide1
 16:     251712   IO-APIC-level  eth0
 17:      90632   IO-APIC-level  EMU10K1
 19:     415529   IO-APIC-level  nvidia
 20:          0   IO-APIC-level  usb-ohci
 21:        153   IO-APIC-level  ehci_hcd
 22:      58257   IO-APIC-level  usb-ohci
NMI:        479
LOC:     265875
ERR:          0
MIS:          0

this far and it feels like a closer match to what windows does from what
i have read on the ml.=20

I haven't even come close to testing this yet, I've only been up 45 mins
but i'll leave it running and do what i usually do when it hangs... =3D)

I'll get back to you about how it goes...=20

--=20
Ian Kumlien <pomac@vapor.com>

--=-CyTghudFEoIEjFShsfc+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/0Sjy7F3Euyc51N8RAiigAKCIM7EAmtdzaNzyGUFnmi+wH8DQ2gCfUONi
S2k0hr4/ICd5ISpPD1QpK+Y=
=Eg5R
-----END PGP SIGNATURE-----

--=-CyTghudFEoIEjFShsfc+--

