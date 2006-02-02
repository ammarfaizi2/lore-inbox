Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423413AbWBBJZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423413AbWBBJZm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 04:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423411AbWBBJZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 04:25:42 -0500
Received: from 60-240-149-171.tpgi.com.au ([60.240.149.171]:35005 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1423413AbWBBJZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 04:25:41 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [ 01/10] [Suspend2] kernel/power/modules.h
Date: Thu, 2 Feb 2006 19:22:06 +1000
User-Agent: KMail/1.9.1
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@suse.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602020855.12392.nigel@suspend2.net> <200602020931.29796.rjw@sisk.pl>
In-Reply-To: <200602020931.29796.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1802504.qIIoneOH77";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602021922.11100.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1802504.qIIoneOH77
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Rafael.

On Thursday 02 February 2006 18:31, Rafael J. Wysocki wrote:
> > Well, I'd love that to be true, but I don't believe Pavel's going to ro=
ll
> > over and say "Ok Nigel. You've got a better implementation. I'll submit
> > patches to remove mine." I might be wrong, and I hope I will be, but I
> > fear they're going to coexist for a while.
>
> First, your code introduces many changes in many parts of the kernel,
> so to merge it you'll have to ask many people for acceptance.

I really must work harder to get rid of that perception. It used to be the=
=20
case, but isn't nowadays. Just about all of suspend2's changes are new file=
s=20
in kernel/power and include/<arch>/suspend2.h. The remainder are misc fixes=
,=20
and enhancements like Christoph's todo list.

> Second, swsusp is actively developed, not only by Pavel, and you know tha=
t,
> so you could be nicer. ;-)

It was hardly touched for a long time, but that has certainly been changing=
 in=20
the last few months. I wasn't meaning to be uncharitable. Sorry for giving=
=20
that impression.

> Still our approach is quite different to yours.  We are focused on keepei=
ng
> the code possibly simple and non-intrusive wrt the other parts of the
> kernel, whereas you seem to concentrate on features (which is not wrong,
> IMO, it's just a different point of view).  We're moving towards the
> implementation of the features like the system image compression and
> encryption,
> graphical progress meters etc. in the user space, which has some
> advantages, and I think this approach is correct for a laptop/desktop
> system.
>
> Its limitation , however, is that it requires a lot of memory for the
> system memory snapshot which may be impractical for systems with limited
> RAM, and that's where your solution may be required.

I'm more concerned about the security implications. I'll freely admit that =
I=20
haven't spent any real time looking at your code, but I'm concerned that th=
e=20
additional functionality made available could be used by viruses and the=20
like. I'm sure you'd have to be root to do anything, but how could the=20
interfaces be misused?

> In conclusion, I see the room for both, as long as the do not conflict, so
> could we please bury the hatched and start working _together_?

I didn't realise I was holding one :). I'm not sure that I agree that there=
's=20
a need for both, but I have no desire whatsoever to act an any sort of nast=
y=20
way. All I want is to help provide Linux users with stable, reliable,=20
flexible and fast suspend-to-disk functionality.

Regards,

Nigel
=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart1802504.qIIoneOH77
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD4c9DN0y+n1M3mo0RAqQiAJ9lIHGTjsjlQK2V4maLrOcanRYa1QCdHLZX
cIfBIBjadLIewAjl3MR2xc0=
=FQNB
-----END PGP SIGNATURE-----

--nextPart1802504.qIIoneOH77--
