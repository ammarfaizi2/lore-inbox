Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161005AbWF0H1o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161005AbWF0H1o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 03:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932616AbWF0H1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 03:27:43 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:47034 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S932612AbWF0H1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 03:27:42 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Reply-To: nigel@suspend2.net
To: Greg KH <greg@kroah.com>
Subject: Re: [Suspend2][ 0/9] Extents support.
Date: Tue, 27 Jun 2006 17:27:30 +1000
User-Agent: KMail/1.9.1
Cc: Jens Axboe <axboe@suse.de>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       linux-kernel@vger.kernel.org
References: <20060626165404.11065.91833.stgit@nigel.suspend2.net> <200606271539.29540.nigel@suspend2.net> <20060627070609.GA28730@kroah.com>
In-Reply-To: <20060627070609.GA28730@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1367378.toASXl0fYx";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200606271727.39474.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1367378.toASXl0fYx
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Tuesday 27 June 2006 17:06, Greg KH wrote:
> Oh, and as a meta-comment, why /proc?  You know that's not acceptable,
> right?

Partly because when I did consider switching to /sys, I found it to be=20
incomprehensible (even with the LWN articles and Documentation/ files).=20
Jonathan's articles and LCA presentation did help me start to get a better=
=20
grip, but then it just didn't seem to be worth the effort. I have two simpl=
e=20
relatively simple routines that handle all my proc entries at the moment, s=
o=20
that adding a new entry is just a matter of adding an element in an array o=
f=20
structs (saying what variable is being read/written, what type, min/max=20
values and side effect routines, eg). It looked to me like changing to sysf=
s=20
was going to require me to have a separate routine for every sysfs entry,=20
even though they'd all have those some basic features. Maybe I'm just=20
ignorant. Please tell me I am and point me in the right direction.

Regards,

Nigel
=2D-=20
See http://www.suspend2.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

--nextPart1367378.toASXl0fYx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEoN3rN0y+n1M3mo0RAjJpAKDr8a9WKY/zZLpcJRNFb/dHJ6IM0ACeLAGA
9TkuVLfEsHRjjojI7IJBja0=
=aGnm
-----END PGP SIGNATURE-----

--nextPart1367378.toASXl0fYx--
