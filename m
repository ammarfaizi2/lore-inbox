Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423451AbWBBKeM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423451AbWBBKeM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 05:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423454AbWBBKeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 05:34:12 -0500
Received: from 60-240-149-171.tpgi.com.au ([60.240.149.171]:11246 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1423451AbWBBKeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 05:34:10 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [ 01/10] [Suspend2] kernel/power/modules.h
Date: Thu, 2 Feb 2006 20:30:47 +1000
User-Agent: KMail/1.9.1
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Pekka Enberg <penberg@cs.helsinki.fi>,
       linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602020931.29796.rjw@sisk.pl> <20060202093859.GA1884@elf.ucw.cz>
In-Reply-To: <20060202093859.GA1884@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart29213780.CyHCQ6Oviu";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602022030.50983.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart29213780.CyHCQ6Oviu
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Thursday 02 February 2006 19:38, Pavel Machek wrote:
> Hi!
>
> > Its limitation , however, is that it requires a lot of memory for the
> > system memory snapshot which may be impractical for systems with limited
> > RAM, and that's where your solution may be required.
>
> Actually, suspend2 has similar limitation. It still needs half a
> memory free, but it does not count caches into that as it can save
> them separately.
>
> That means that on certain small systems (32MB RAM?), suspend2 is going to
> have big advantage of responsivity after resume. But on the systems
> where [u]swsusp can't suspend (6MB RAM?), suspend2 is not going to be
> able to suspend, either. [Roughly; due to bugs and implementation
> differences there may be some system size where one works and second
> one does not, but they are pretty similar]
>
> But that's probably not a problem as it is only going to fail on
> *very* small system. Desktops with 6MB RAM are not too common these
> days, fortunately. Not even in embedded space.

=46ully agree.

Regards,

Nigel
=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart29213780.CyHCQ6Oviu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD4d9aN0y+n1M3mo0RAogKAKCrtAH1ZwusBHSvNg/tDyazCq/nUgCfc8mC
qMubao7AATTgT160v1etm9o=
=jPr3
-----END PGP SIGNATURE-----

--nextPart29213780.CyHCQ6Oviu--
