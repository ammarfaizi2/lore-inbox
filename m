Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752437AbWAFQ0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752437AbWAFQ0Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 11:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752274AbWAFQ0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 11:26:23 -0500
Received: from sipsolutions.net ([66.160.135.76]:30731 "EHLO sipsolutions.net")
	by vger.kernel.org with ESMTP id S1752259AbWAFQ0W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 11:26:22 -0500
Subject: Re: [Bcm43xx-dev] [Fwd: State of the Union: Wireless]
From: Johannes Berg <johannes@sipsolutions.net>
To: Feyd <feyd@seznam.cz>
Cc: bcm43xx-dev@lists.berlios.de, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <43BE96DA.1020107@seznam.cz>
References: <1136541243.4037.18.camel@localhost>
	 <200601061200.59376.mbuesch@freenet.de>
	 <1136547494.7429.72.camel@localhost>
	 <200601061245.55978.mbuesch@freenet.de>  <43BE96DA.1020107@seznam.cz>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-hamO6lsAZSD37aeQaqD0"
Date: Fri, 06 Jan 2006 17:25:51 +0100
Message-Id: <1136564751.29313.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-hamO6lsAZSD37aeQaqD0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-01-06 at 17:12 +0100, Feyd wrote:
> Michael Buesch wrote:
> > The _real_ main point I wanted to make was to _not_ use a net_device fo=
r
> > the master device. What else should be used for master device, let it
> > be a device node or a netlink socket, is rather unimportant at
> > this stage.
>=20
> If the only purpose of the master device was configuration, then it
> would be beter to use something other then a net_device, but you may
> want to send/receive raw 802.11 packets from userspace, most logicaly
> over a master interface.

We thought about that for a while, but it may not be feasible. Certain
hardware that manages more stuff than others in firmware/hardware may
not allow sending raw frames without going into some special mode, which
is better handled by adding some kind of raw virtual device.

johannes

--=-hamO6lsAZSD37aeQaqD0
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (SIP Solutions)

iQIVAwUAQ76aDaVg1VMiehFYAQIe+w/+OmlQW2vcIsDarSgRIajUQUpS+U2liQzH
6G5OpCtUCSbzZdckMRsMkh6rIwKFXDWoz6lPxjaAD2sZkZAYulzShSHfTgibvVni
WISgBseGMwvuhLW7ljmz8NCzzDvr6UzHtJb0E1IoWipf/cBZqood+yYziV6NS/PX
qGpS/FmReIpkEUvLiEsX0jWJYutAQAuA7hm+WVSTeNJM3BeDVax9EAN8dEwT0baa
XfETuXpgYwGbUtF9vyuGeMMnxBsz7y82LliEIvjmrpNdy3xwxSg6oz51dDS19xml
vi/6X/u7IQHx27YjvacTcCpzXhvJ49fNPft4+MuLDgFunD64vjiwfLLJr4C9h+IL
iDp8BNa0Sd0glvCyul30n3vp7iU4+UE/krF6r7+TgvbrHWs9N2zmV7WPNKJQ1gIy
bYF2g2LRUiIsE/mlu8V/dqNTspsGzZ5xAixhyoU6Wa5+i7zp+m3FDSFk1bb63MrA
OobGDtLOMQI8XVWvk9FIebK4bgVjbjOKyPJ7EvqOtrMwq6nMNKg4j1iSwWVtnORJ
tGB46DFhpKlT1AmE6mkTT1/ejN/j+PuAI/I0K2D9nKxy6OuH/cDkMzdMB6K4R1Cz
tg3lHxHzC6BxXI5Ih6FIvIxNT9POpQNsDVOk1I/3ZD+5NXFJ4aX+cLH3igWaYRFo
CjcbhDJrTtQ=
=4W0e
-----END PGP SIGNATURE-----

--=-hamO6lsAZSD37aeQaqD0--

