Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751748AbWIBX0b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751748AbWIBX0b (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 19:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751749AbWIBX0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 19:26:31 -0400
Received: from hentges.net ([81.169.178.128]:30849 "EHLO
	h6563.serverkompetenz.net") by vger.kernel.org with ESMTP
	id S1751747AbWIBX0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 19:26:30 -0400
Subject: Re: sky2 hangs on me again: This time 200 kb/s IPv4 traffic, not
	easily reproducable
From: Matthias Hentges <oe@hentges.net>
To: shogunx <shogunx@sleekfreak.ath.cx>
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       Stephen Hemminger <shemminger@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0609021908320.28542-100000@sleekfreak.ath.cx>
References: <Pine.LNX.4.44.0609021908320.28542-100000@sleekfreak.ath.cx>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-g82TI2sUdctKACQ1Ozwo"
Date: Sun, 03 Sep 2006 01:27:20 +0200
Message-Id: <1157239640.18988.10.camel@mhcln03>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-g82TI2sUdctKACQ1Ozwo
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Samstag, den 02.09.2006, 19:11 -0400 schrieb shogunx:
> On Sat, 2 Sep 2006, Matthias Hentges wrote:

> > Well, it just crapped out on me again :(
> >
> > Sep  2 23:36:13 localhost kernel: NETDEV WATCHDOG: eth2: transmit timed
> > out
> > Sep  2 23:36:13 localhost kernel: sky2 hardware hung? flushing
> >
> > Only a rmmod / modprobe cycle helps at this point.
>=20
> Really?  What is the error condition causing it?  On my friends lap, whic=
h
> has an integrated sky2, his drops out with a full sustained TX...
> uploading to another box for example, at about 4-8MB of transfer.  The
> fix in his case is ifdown eth0 && ifup eth0.  I have
> yet to see the error occur at all on my ExpressCard device, either with
> 2.6.18-rc5 or 2.6.17.5.  I built the rc5 as a preemptive measure, but I
> cannot get it to fail under any conditions.
>=20

I have yet to find a reproduceable way to trigger the bug but I'll try a
few things tomorrow.
Currently it appears to be completely ranom. I've loaded the driver w/
debug=3D10, maybe it'll give some clues.
--=20
Matthias 'CoreDump' Hentges=20

Webmaster of hentges.net and OpenZaurus developer.
You can reach me in #openzaurus on Freenode.

My OS: Debian SID. Geek by Nature, Linux by Choice

--=-g82TI2sUdctKACQ1Ozwo
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBE+hNYAq2P5eLUP5IRAublAKDXGzLWJQavGfCBxC/yUANB3kEPRQCfZMLH
zufegKsUvqNFHmRCRe+baQA=
=qKkh
-----END PGP SIGNATURE-----

--=-g82TI2sUdctKACQ1Ozwo--


-- 
VGER BF report: U 0.5
