Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262195AbVC2Ial@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262195AbVC2Ial (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 03:30:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262194AbVC2ILw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 03:11:52 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:62619 "EHLO
	pd4mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S262190AbVC2IH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 03:07:57 -0500
Date: Tue, 29 Mar 2005 01:07:26 -0700
From: Jeremy Nickurak <atrus@rifetech.com>
Subject: Re: Logitech MX1000 Horizontal Scrolling
In-reply-to: <20050308205210.GA3986@ucw.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Esben Stien <b0ef@esben-stien.name>, linux-kernel@vger.kernel.org
Message-id: <1112083646.12986.3.camel@localhost>
MIME-version: 1.0
X-Mailer: Evolution 2.2.1.1
Content-type: multipart/signed; boundary="=-2mpBJQjWS+bLuu2agc0l";
 protocol="application/pgp-signature"; micalg=pgp-sha1
References: <873bxfoq7g.fsf@quasar.esben-stien.name>
 <87zmylaenr.fsf@quasar.esben-stien.name> <20050204195410.GA5279@ucw.cz>
 <873bvyfsvs.fsf@quasar.esben-stien.name>
 <87zmxil0g8.fsf@quasar.esben-stien.name> <1110056942.16541.4.camel@localhost>
 <87sm37vfre.fsf@quasar.esben-stien.name>
 <87wtsjtii6.fsf@quasar.esben-stien.name> <20050308205210.GA3986@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-2mpBJQjWS+bLuu2agc0l
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-03-08 at 21:52 +0100, Vojtech Pavlik wrote:
> The problem is that the mouse really does reports all the double-button
> stuff and autorepeat, and horizontal wheel together with button press on
> wheel tilt.

Okay, I'm playing with this under 2.6.11.4 some more, and it really
seems out of whack. The vertical cruise control buttons work properly,
with the exception of the extra button press. But the horizontal buttons
are mapping to 6/7 as non-repeat buttons, and adding simulateously the
4/5 events auto-repeated for as long as the button is down. That is to
say, pressing the the horizontal scroll in a 2d scrolling area will
scroll *diagonally* one step, then vertically until the button is
released.=20

--=20
Jeremy Nickurak <atrus@rifetech.com>

--=-2mpBJQjWS+bLuu2agc0l
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCSQy+tjFmtbiy5uYRApmTAJ0VvY7SPD5CHLlS2TlKAqoitRG3RgCfXYK6
QhLFkg2242p/lI9eXUrKfxU=
=Qvyf
-----END PGP SIGNATURE-----

--=-2mpBJQjWS+bLuu2agc0l--
