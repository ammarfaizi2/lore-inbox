Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266207AbTIKHVJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 03:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266210AbTIKHVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 03:21:09 -0400
Received: from mx02.qsc.de ([213.148.130.14]:53700 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S266207AbTIKHVE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 03:21:04 -0400
Date: Thu, 11 Sep 2003 09:23:46 +0200
From: Wiktor Wodecki <wodecki@gmx.de>
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, linux-acpi <linux-acpi@intel.com>
Subject: Re: 2.6.0-test5-mm1
Message-ID: <20030911072346.GC4806@gmx.de>
References: <7F740D512C7C1046AB53446D3720017304AF36@scsmsx402.sc.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7gGkHNMELEOhSGF6"
Content-Disposition: inline
In-Reply-To: <7F740D512C7C1046AB53446D3720017304AF36@scsmsx402.sc.intel.com>
X-message-flag: Linux - choice of the GNU generation
X-Operating-System: Linux 2.6.0-test5-mm1 i686
X-PGP-KeyID: 182C9783
X-Info: X-PGP-KeyID, send an email with the subject 'public key request' to wodecki@gmx.de
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7gGkHNMELEOhSGF6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2003 at 04:01:14PM -0700, Nakajima, Jun wrote:
> Getting SCI at IRQ 7 is not a problem, but it sounds very rare.=20
>=20
> Can you please send dmesg and acpidmp to linux-acpi@intel.com?
> Or file a bug report and put them on http://bugme.osdl.org/?

I attached the information from my system to bug 905
(http://bugme.osdl.org/show_bug.cgi?id=3D905) on bugme.
Hope this helps.

>=20
> Thanks,
> Jun
>=20
> > -----Original Message-----
> > From: Wiktor Wodecki [mailto:wodecki@gmx.de]
> > Sent: Wednesday, September 10, 2003 2:18 PM
> > To: Andrew Morton
> > Cc: linux-kernel@vger.kernel.org; linux-mm@kvack.org
> > Subject: Re: 2.6.0-test5-mm1
> >=20
> > Hi,
> >=20
> > still errors with uncared irq with test5-mm1:
> >=20
> > Sep 10 21:36:13 kakerlak kernel: irq 7: nobody cared!
> > Sep 10 21:36:13 kakerlak kernel: Call Trace:
> > Sep 10 21:36:13 kakerlak kernel:  [__report_bad_irq+42/144]
> > __report_bad_irq+0x2a/0x90
> > Sep 10 21:36:13 kakerlak kernel:  [note_interrupt+108/176]
> > note_interrupt+0x6c/0xb0
> > Sep 10 21:36:13 kakerlak kernel:  [do_IRQ+288/304] do_IRQ+0x120/0x130
> > Sep 10 21:36:13 kakerlak kernel:  [common_interrupt+24/32]
> > common_interrupt+0x18/0x20
> > Sep 10 21:36:13 kakerlak kernel:  [do_softirq+64/160]
> do_softirq+0x40/0xa0
> > Sep 10 21:36:13 kakerlak kernel:  [do_IRQ+252/304] do_IRQ+0xfc/0x130
> > Sep 10 21:36:13 kakerlak kernel:  [_stext+0/96] rest_init+0x0/0x60
> > Sep 10 21:36:13 kakerlak kernel:  [common_interrupt+24/32]
> > common_interrupt+0x18/0x20
> > Sep 10 21:36:13 kakerlak kernel:  [_stext+0/96] rest_init+0x0/0x60
> > Sep 10 21:36:13 kakerlak kernel:  [acpi_processor_idle+213/455]
> > acpi_processor_idle+0xd5/0x1c7
> > Sep 10 21:36:13 kakerlak kernel:  [_stext+0/96] rest_init+0x0/0x60
> > Sep 10 21:36:13 kakerlak kernel:  [cpu_idle+44/64] cpu_idle+0x2c/0x40
> > Sep 10 21:36:13 kakerlak kernel:  [start_kernel+332/352]
> > start_kernel+0x14c/0x160
> > Sep 10 21:36:13 kakerlak kernel:  [unknown_bootoption+0/256]
> > unknown_bootoption+0x0/0x100
> > Sep 10 21:36:13 kakerlak kernel:
> > Sep 10 21:36:13 kakerlak kernel: handlers:
> > Sep 10 21:36:13 kakerlak kernel: [acpi_irq+0/22] (acpi_irq+0x0/0x16)
> > Sep 10 21:36:13 kakerlak kernel: Disabling IRQ #7
> >=20
> > kernel booted with pci=3Dnoacpi, lspci attached

--=20
Regards,

Wiktor Wodecki

--7gGkHNMELEOhSGF6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/YCMC6SNaNRgsl4MRAsnwAJ90VbSzb/11U7ONWQrzmLHWUBUHlgCfQbnm
oSL/mpvW7/4RLqPl12EGzE4=
=4tns
-----END PGP SIGNATURE-----

--7gGkHNMELEOhSGF6--
