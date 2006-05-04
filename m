Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751395AbWEDWoI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbWEDWoI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 18:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbWEDWoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 18:44:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:54501 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751395AbWEDWoG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 18:44:06 -0400
X-Authenticated: #24128601
Date: Fri, 5 May 2006 00:43:59 +0200
From: Sebastian Kemper <sebastian_ml@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Mouse light (still) stays on after shutdown
Message-ID: <20060504224359.GA12505@section_eight.darkstar.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
X-PGP-Key: http://www-users.rwth-aachen.de/sebastian.kemper/sebastian_ml_pubkey.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

I reported this issue at the kernel bugzilla some time in the past.
I'd like to know if there's a solution yet.

http://bugzilla.kernel.org/show_bug.cgi?id=3D5410

This is what I get: Shutting down my computer my mouse light stays on.
It's a 7=E2=82=AC Logitech USB mouse. Alexey Starikovskiy suggested in my
bugreport that it might be an USB issue.

Up to 2.6.13-rc2 this didn't happen. Since 2.6.13-rc3 the light stays
on.

I tried unloading the usb modules before shutdown, but I couldn't get
rid of usbcore. rmmod said it's still in use, though it didn't mention
by what.

Module                  Size  Used by=20
usbcore               107136  1=20

Right now I'm using 2.6.16.13 and the light stays on. I'm on a NForce2
Shuttle AN35N with a Sempron 2400+ and 512MB RAM. I'm using ehci and
ohci.

Please CC me in your answers. I'd be glad to help though I'm not a
kernel hacker.

sk@section_eight /usr/src/linux/scripts $ ./ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux section_eight 2.6.16.13 #3 Thu May 4 13:28:12 CEST 2006 i686 AMD
Sempron(tm)   2400+ GNU/Linux

Gnu C                  3.4.5
Gnu make               3.80
binutils               2.16.1
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.1
e2fsprogs              1.38
reiserfsprogs          line
reiser4progs           line
Linux C Library        2.3.6
Dynamic linker (ldd)   2.3.6
Procps                 3.2.6
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.94
udev                   087
Modules Loaded         wlan_tkip wlan_scan_sta ath_pci ath_rate_sample
wlan ath_hal dvb_ttpci l64781 saa7146_vv video_buf saa7146 ves1820
stv0299 dvb_core tda8083 stv0297 sp8870 ves1x93 ttpci_eeprom lirc_serial
lirc_dev

(I usually have the USB drivers compiled statically, not as modules).

Sincerely

Sebastian

--=20
"When the going gets weird, the weird turn pro." (HST)

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEWoOvTWouIrjrWo4RAm5dAKCKGd6FF3+U0wcM97Xo4m/XK+NCZgCbBS+C
XMYhTit405Vo9jUazgrG9c4=
=dSGD
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--

