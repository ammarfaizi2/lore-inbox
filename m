Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbUBVOef (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 09:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261370AbUBVOee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 09:34:34 -0500
Received: from mbox.serv4.servweb.de ([80.239.142.80]:61348 "EHLO
	serv4.servweb.de") by vger.kernel.org with ESMTP id S261359AbUBVOe2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 09:34:28 -0500
Date: Sun, 22 Feb 2004 15:36:58 +0100
From: Patrick Plattes <patrick@erdbeere.net>
To: linux-kernel@vger.kernel.org
Subject: radeonfb starts only with 640x480
Message-ID: <20040222143658.GA557@erdbeere.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hello,

i try to use the 2.6.3. and i have a problem with the radeonfb. to start
linux with my favorite resolution i use the following line:

append=3D"video=3Dradeonfb:1024x768-32@100,noaccel"

the radeonfb doesn't looks very 'impressed' by it and starts with 640x480. =
i have found some similar problems in this mailinglist, but i don't no if t=
hey are just similar or the same.

dmesg give me the following output (only the relevant part is printed
here):

PCI: Using IRQ router VIA [1106/0596] at 0000:00:07.0
radeonfb_pci_register BEGIN
radeonfb: ref_clk=3D2700, ref_div=3D12, xclk=3D16600 from BIOS
radeonfb: probed DDR SGRAM 65536k videoram
radeon_get_moninfo: bios 4 scratch =3D 2000002
radeonfb: ATI Radeon M9 Le DDR SGRAM 64 MB
radeonfb: DVI port no monitor connected
radeonfb: CRT port CRT monitor connected
radeonfb_pci_register END
Activating ISA DMA hang workarounds.
hStart =3D 664, hEnd =3D 760, hTotal =3D 800
vStart =3D 491, vEnd =3D 493, vTotal =3D 525
h_total_disp =3D 0x4f0063    hsync_strt_wid =3D 0x8c02a2
v_total_disp =3D 0x1df020c           vsync_strt_wid =3D 0x8201ea
post div =3D 0x8
fb_div =3D 0x59
ppll_div_3 =3D 0x30059
ron =3D 1096, roff =3D 23772
vclk_freq =3D 2503, per =3D 849
Console: switching to colour frame buffer device 80x30
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA Apollo MVP3 chipset
agpgart: Maximum main memory to use for agp memory: 204M
agpgart: AGP aperture is 64M @ 0xe0000000
[drm] Initialized radeon 1.9.0 20020828 on minor 0
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M


in  /var/log/debug is just one radeon relevant line (every startup):
Feb 22 15:20:39 Dragon kernel: radeon_get_moninfo: bios 4 scratch =3D
2000002


i hope this information will help you (and me of course ;) ). if you
need any further information i will send you them as fast as possible.

thank you,
patrick plattes

--=20
Das ggf. ang=E4ngende Attachment ist eine Signatur, erstellt mit GnuPG, die=
 es
erm=F6glicht die Korrektheit des Absenders zu best=E4tigen (www.gnupg.org).
Ich widerspreche der Nutzung oder =DCbermittling meiner Daten f=FCr Werbezw=
ecke=20
oder f=FCr die Markt- und Meinungsforschung. (=A728 Abs. 3 + 4 BDSG)

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAOL6KQ7Xfys5M9aQRAshhAKCfEHLhkPrTsN7LcL4fR3bFjGx8tACgrXmM
wJgpKSQETJZ+/7E0m/NEOHM=
=4Bmf
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
