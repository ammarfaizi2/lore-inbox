Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933094AbWF0JIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933094AbWF0JIz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 05:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933074AbWF0JIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 05:08:54 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:37836 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S933094AbWF0JIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 05:08:54 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Reply-To: nigel@suspend2.net
To: Greg KH <greg@kroah.com>
Subject: Re: [Suspend2][ 0/9] Extents support.
Date: Tue, 27 Jun 2006 19:08:46 +1000
User-Agent: KMail/1.9.1
Cc: Jens Axboe <axboe@suse.de>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       linux-kernel@vger.kernel.org
References: <20060626165404.11065.91833.stgit@nigel.suspend2.net> <200606271727.39474.nigel@suspend2.net> <20060627075341.GA16347@kroah.com>
In-Reply-To: <20060627075341.GA16347@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5022062.ZpZobU4IUR";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200606271908.50599.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart5022062.ZpZobU4IUR
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Tuesday 27 June 2006 17:53, Greg KH wrote:
> Well, as your stuff does not have anything to do with "processes",
> putting it in /proc is not acceptable.
>
> sysfs is one value per file, and if that matches up to what you need,
> then it should be fine to use.

It does.

> You do need to have some kind of function for every sysfs entry, but you
> can group common ones together (as the hwmon drivers do.)

Ok. I'll take a look.

> As you will not have a backing "device" to attach your files to, you
> will probably need to deal with "raw" kobjects, and the learning curve
> for how to create files in sysfs with them is unfortunatly a bit steep.
> But there is lots of working examples in the kernel that do this (block
> devices, md, driver core, etc.), there's plenty of code to copy from to
> get it to work.
>
> And if that doesn't look like fun, you can always just use create a new
> filesystem (only 200 lines of code), or use debugfs.
>
> good luck,

Ok. I'll give it a go. Thanks for the pointers, Greg.

Regards,

Nigel
=2D-=20
See http://www.suspend2.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

--nextPart5022062.ZpZobU4IUR
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEoPWiN0y+n1M3mo0RAv8aAJ0Q1DtK0TYmRX2J4zJmvlH2JvmxtgCgjmBS
1c2FrmLxqf0KTCpZu2kDZug=
=lbZ1
-----END PGP SIGNATURE-----

--nextPart5022062.ZpZobU4IUR--
