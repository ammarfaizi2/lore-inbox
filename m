Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264456AbTLCArM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 19:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264457AbTLCArM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 19:47:12 -0500
Received: from c-130372d5.012-136-6c756e2.cust.bredbandsbolaget.se ([213.114.3.19]:3715
	"EHLO pomac.netswarm.net") by vger.kernel.org with ESMTP
	id S264456AbTLCArH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 19:47:07 -0500
Subject: Re: NForce2 pseudoscience stability testing (2.6.0-test11)
From: Ian Kumlien <pomac@vapor.com>
To: b@netzentry.com
Cc: ross.alexander@uk.neceur.com, s0348365@sms.ed.ac.uk,
       linux-kernel@vger.kernel.org, cbradney@zip.com.au, forming@charter.net
In-Reply-To: <3FCD21E1.5080300@netzentry.com>
References: <3FCD21E1.5080300@netzentry.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-UPDlzzGfOlqRsr8hyUnK"
Message-Id: <1070412425.1767.19.camel@big.pomac.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 03 Dec 2003 01:47:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-UPDlzzGfOlqRsr8hyUnK
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-12-03 at 00:36, b@netzentry.com wrote:
> Right now I can't even afford to test 2.6.0.test11 in terms
> of time but very similar problems exist in 2.4, suggesting
> something fundamental?

2.6.0-test11 deadlocked after less than a hour here.

> About the IDE, it seems to be the easiest way to promote the
> problem but time seems to be the biggest factor. Some have
> suggested wrt this NFORCE2 problem that idle time makes it
> worse, but I've seen the hang under both conditions.

Well, IDE is what i'd blame. My original experience about lost
interrupts leads me to ide. Since i never loose interrupts without
io-apic.

Also, i tried to get it running with the ide cable that came with the
board but that caused my 60 gig Quantum and my 80 gig Seagate disks to
show up as 8mb disks with garbled names so i skipped that =3D)
(2.6 also mentions something about cable info bits not set properly)

I use USB 2.0 and 1.1. I have also disabled audio and lan.
A7N8X-X Bios 1007 (Nforce2-400).

> The Linux APIC code generically works on most other hardware. Something=20
> specific to the NFORCE2 chips and its interaction with Linux's APIC code=20
> causes the hard hangs. The Windows 2000's APIC code was made before the=20
> NFORCE2 existed, and it seems to run fine there.

Well, IO-APIC without the amd/nvidia driver works, although a lost
interrupt stalls the machine for a annoying-ammount-of-time.

> - About that Uber BIOS bios for the Asus Deluxe board, Anyone running=20
> this: a) do you really want to run a hacked bios when other OS run fine=20
> on the unhacked BIOS b) do you believe that any of the un-hidden=20
> settings the uber bios or settings you may have changed helps solve this=20
> problem?

Yeah, anyone that has checked the changes?

--=20
Ian Kumlien <pomac@vapor.com>

--=-UPDlzzGfOlqRsr8hyUnK
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/zTKI7F3Euyc51N8RAgnxAJ9fL+ouP1gJ1dFvEKLMPPFhhS1AmgCfaBsQ
4b8gyG3O6h7Of/X9R7Jk0zA=
=tbjA
-----END PGP SIGNATURE-----

--=-UPDlzzGfOlqRsr8hyUnK--

