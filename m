Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265653AbTIFKz1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 06:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265654AbTIFKz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 06:55:27 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:40901 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S265653AbTIFKzZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 06:55:25 -0400
Date: Sat, 6 Sep 2003 12:55:23 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] 2.6.0-test4 - PL2303 OOPS - see also 2.4.22: OOPS on disconnect PL2303 adapter
Message-ID: <20030906105523.GF14376@lug-owl.de>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>,
	linux-usb-devel@lists.sourceforge.net
References: <200309020139.08248.mhf@linuxmail.org> <20030905230852.GA18196@kroah.com> <20030906073814.GE14376@lug-owl.de> <200309061555.47065.mhf@linuxmail.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="t4h8pR5TgOYIPOP9"
Content-Disposition: inline
In-Reply-To: <200309061555.47065.mhf@linuxmail.org>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--t4h8pR5TgOYIPOP9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 2003-09-06 15:55:46 +0800, Michael Frank <mhf@linuxmail.org>
wrote in message <200309061555.47065.mhf@linuxmail.org>:
> On Saturday 06 September 2003 15:38, Jan-Benedict Glaw wrote:
> > On Fri, 2003-09-05 16:08:52 -0700, Greg KH <greg@kroah.com>
> > wrote in message <20030905230852.GA18196@kroah.com>:
> > > On Wed, Sep 03, 2003 at 02:32:16PM +0800, Michael Frank wrote:
> > > > On Wednesday 03 September 2003 07:52, Greg KH wrote:
> > > > Sep  3 12:52:15 mhfl2 kernel: ttyUSB0: 1 input overrun(s)
> > > > Sep  3 12:54:30 mhfl2 last message repeated 2 times
> > >=20
> > > Hm, what is causing this?
> > > That is probably why cu is getting confused, right?
> >=20
> > I've seen the input overrun message also (with the vanilla driver, not
> > patched).
> > It's effect is that the first bytes (maybe up to 100..300
> > bytes) are scrambled. It's like accessing a serial link with a horribly
> > wrong baud rate.
>=20
> I have seen that too, but rarely. Most the time it hangs after the first
> few hundred bytes.

I've never seen that. My impression is that this (only?) happens if
there are some bytes received from serial, but not read out from
userspace. For NMEA, this is mostly always the case because the GPS
receiver is sending data all the time:)

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--t4h8pR5TgOYIPOP9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/Wb0bHb1edYOZ4bsRAk9fAJwMkcChOYq9ScB+LXLkPi7rjIdKBgCfWh4o
0q2vy7WEmLkBLWsjJiszk3M=
=gAH7
-----END PGP SIGNATURE-----

--t4h8pR5TgOYIPOP9--
