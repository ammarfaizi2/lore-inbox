Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751312AbWGHWZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbWGHWZj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 18:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbWGHWZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 18:25:39 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:65510 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1751312AbWGHWZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 18:25:38 -0400
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: uswsusp history lesson [was Re: [Suspend2-devel] Re: swsusp / suspend2 reliability]
Date: Sun, 9 Jul 2006 08:25:33 +1000
User-Agent: KMail/1.9.1
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, suspend2-devel@lists.suspend2.net,
       Olivier Galibert <galibert@pobox.com>, grundig <grundig@teleline.es>,
       Avuton Olrich <avuton@gmail.com>, jan@rychter.com,
       linux-kernel@vger.kernel.org
References: <20060627133321.GB3019@elf.ucw.cz> <200607082326.18237.ncunningham@linuxmail.org> <20060708210417.GB2546@elf.ucw.cz>
In-Reply-To: <20060708210417.GB2546@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3213195.AqUoUppLxI";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200607090825.37855.ncunningham@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3213195.AqUoUppLxI
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Sunday 09 July 2006 07:04, Pavel Machek wrote:
> > Some way to go without bmapping. I'm assuming you're going to have to a=
dd
> > some kernel code to at least do the bmapping. By the way, watch out for
> > block sizes. Especially with XFS. It's the best test of whether your co=
de
> > is right because the blocksize XFS uses might not be the same as the
> > underlying block device's blocksize.
>
> Why is bmapping evil?

I didn't mean it's evil. I just mean it's complicated and potentially=20
confusing because the result of bmap needs to modified by the number of=20
blocks per sector to get the right value to pass to bio_submit. Maybe you'r=
e=20
more experienced in these things than me, so it will be simple for you, but=
=20
it took a while for me to get right.

Regards,

Nigel
=2D-=20
Nigel, Michelle and Alisdair Cunningham
5 Mitchell Street
Cobden 3266
Victoria, Australia

--nextPart3213195.AqUoUppLxI
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEsDDhN0y+n1M3mo0RAkh5AKDnjEt/szUhr2zclnc65ADI3I5tGQCg3Din
YcGhKduQUwdusVoYwjPsWWw=
=LNGN
-----END PGP SIGNATURE-----

--nextPart3213195.AqUoUppLxI--
