Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030708AbWHILv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030708AbWHILv5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 07:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030711AbWHILv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 07:51:56 -0400
Received: from nigel.suspend2.net ([203.171.70.205]:24536 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1030708AbWHILv4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 07:51:56 -0400
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC][PATCH -mm 0/5] swsusp: Fix handling of highmem
Date: Wed, 9 Aug 2006 21:52:10 +1000
User-Agent: KMail/1.9.3
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>,
       Linux PM <linux-pm@osdl.org>
References: <200608091152.49094.rjw@sisk.pl> <200608092047.13493.ncunningham@linuxmail.org> <20060809113822.GQ3308@elf.ucw.cz>
In-Reply-To: <20060809113822.GQ3308@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3471784.p0Ehy8OJY2";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200608092152.11122.ncunningham@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3471784.p0Ehy8OJY2
Content-Type: text/plain;
  charset="cp 850"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 09 August 2006 21:38, Pavel Machek wrote:
> Hi!
>
> > > Comments welcome.
> >
> > Thanks for the reminder. I'd forgotten half the reason why I didn't want
> > to make Suspend2 into incremental patches! You're a brave man!
>
> Why does this serve as a reminder? No, it is not easy to merge big
> patches to mainline. But it is actually a feature.

It serves as a reminder because it shows (just the description, I mean), ho=
w=20
inter-related all the changes that are needed are.

I don't get the "it is actually a feature" bit.

> > while (1) {
> >   size=3D$RANDOM * 65536 + 1
> >   dd if=3D/dev/random bs=3D1 count=3D$size | patch -p0-b
> >   make && break
> >}
>
> Is this what you use to generate suspend2 patches? :-)))))

:) Actually, given Greg's OLS keynote, I was wondering if it was what he us=
ed=20
to generate them.

Regards,

Nigel
=2D-=20
Nigel, Michelle and Alisdair Cunningham
5 Mitchell Street
Cobden 3266
Victoria, Australia

--nextPart3471784.p0Ehy8OJY2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBE2cxrN0y+n1M3mo0RAvtYAJ9Cy74DMRUbIcffghoV6OImVsccRACeMGxq
w1oLd/pk2lkqxJxbslO/K9g=
=4T6u
-----END PGP SIGNATURE-----

--nextPart3471784.p0Ehy8OJY2--
