Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270082AbTGMD0P (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 23:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270083AbTGMD0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 23:26:15 -0400
Received: from mailc.telia.com ([194.22.190.4]:7389 "EHLO mailc.telia.com")
	by vger.kernel.org with ESMTP id S270082AbTGMD0N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 23:26:13 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] SCHED_ISO for interactivity
From: Christian Axelsson <smiler@lanil.mine.nu>
Reply-To: smiler@lanil.mine.nu
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, phillips@arcor.de
In-Reply-To: <200307131226.29452.kernel@kolivas.org>
References: <200307112053.55880.kernel@kolivas.org>
	 <200307130139.45477.kernel@kolivas.org>
	 <1058027317.4363.8.camel@sm-wks1.lan.irkk.nu>
	 <200307131226.29452.kernel@kolivas.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-+aYK6wr7FzTNWHm3A38Y"
Organization: LANIL
Message-Id: <1058067630.12248.33.camel@sm-wks1.lan.irkk.nu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 13 Jul 2003 05:40:31 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+aYK6wr7FzTNWHm3A38Y
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-07-13 at 04:26, Con Kolivas wrote:
> On Sun, 13 Jul 2003 02:28, Christian Axelsson wrote:
> > On Sat, 2003-07-12 at 17:39, Con Kolivas wrote:
> > > On Sat, 12 Jul 2003 10:13, Con Kolivas wrote:
> > > > On Sat, 12 Jul 2003 09:37, Christian Axelsson wrote:
> > > > > On Fri, 2003-07-11 at 16:30, Con Kolivas wrote:
> > > > > > On Fri, 11 Jul 2003 22:48, Christian Axelsson wrote:
> > >
> > > snip snip snip
> > >
> > > Mike G suggested expiring tasks which use up too much cpu
> > > time like in Davide's softrr patch which is a much better
> > > solution to the forever reinserted into the active array concern.
> > >
> > > patch-SI-0307130021 is also available at
> > > http://kernel.kolivas.org/2.5
> >
> > Problem seems to be gone (cant be 100% sure as I aint really sure WHAT
> > trigged this behavior).
>=20
> I'm as close to sure as I can be since this addressed it. Thanks to your=20
> feedback I would not have been able to figure it out or even know it was =
an=20
> issue.=20
>=20
> Surprisingly noone has said whether this patch does any good for their se=
tup=20
> though.

I do feel an improvement, I get less of those annoying
alsa-bufferunderrun messages popping up from xmms while doing stuff but
it do still happen every now and then, mostly when working with
evolution or mozilla-firebird.=20
I actually this has more with memory to do as if I leave computer idle
for a few hours stuff tends to get swapped out. IE 126mb of X is swapped
out and over 100mb of vmware and even almost 100% of firebird.

--=20
Christian Axelsson
smiler@lanil.mine.nu

--=-+aYK6wr7FzTNWHm3A38Y
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/ENStyqbmAWw8VdkRAi8/AJ94G2lmd9ZfjgXno8NnORpLQFw5FACeOXf8
ZU/sgzXpTbg5oF+k5+5goCE=
=JNwK
-----END PGP SIGNATURE-----

--=-+aYK6wr7FzTNWHm3A38Y--

