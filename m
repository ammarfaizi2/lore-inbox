Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932330AbWBGBJH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbWBGBJH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 20:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbWBGBJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 20:09:06 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:39894 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932330AbWBGBJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 20:09:05 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Tue, 7 Feb 2006 11:05:41 +1000
User-Agent: KMail/1.9.1
Cc: Bojan Smojver <bojan@rexursive.com>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       suspend2-devel@lists.suspend2.net
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060207113159.nyjixl5eokookcsw@imp.rexursive.com> <20060207004448.GC1575@elf.ucw.cz>
In-Reply-To: <20060207004448.GC1575@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1522520.yzXN01S4C1";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602071105.45688.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1522520.yzXN01S4C1
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Pavel.

On Tuesday 07 February 2006 10:44, Pavel Machek wrote:
> Are you Max Dubois, second incarnation or what?
>
> > Well, given that the kernel suspend is going to be kept for a while,
> > wouldn't it be better if it was feature full? How would the users be
> > at
>
>                                               =20
> ~~~~~~~~~~~~~~~~~~~~~~~~~
>
> > a disadvantage if they had better kernel based suspend for a while,
>
> ~~~~~~~~~~~~~~~~
>
> > followed by u-beaut-cooks-cleans-and-washes uswsusp? That's the part I
> > don't get...
>
> *Users* would not be at disadvantage, but, surprise, there's one thing
> more important than users. Thats developers, and I can guarantee you
> that merging 14K lines of code just to delete them half a year later
> would drive them crazy.

It would more be an ever-changing interface that would drive them crazy. So=
=20
why don't we come up with an agreed method of starting a suspend and=20
starting a resume that they can use, without worrying about whether=20
they're getting swsusp, uswsusp or Suspend2? /sys/power/state seems the=20
obvious choice for this. An additional /sys entry could perhaps be used to=
=20
modify which implementation is used when you echo disk > /sys/power/state=20
=2D something like

# cat /sys/power/disk_method
swsusp uswsusp suspend2
# echo uswsusp > /sys/power/disk_method
# echo > /sys/power/state

Is there a big problem with that, which I've missed?

Regards,

Nigel

=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart1522520.yzXN01S4C1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD5/JpN0y+n1M3mo0RAs1EAKDCU/0OCPJ5XcLF4j23kfnBl8IphACgyjJp
AFlEXsp5apLWI3OnkU+7d48=
=fxnz
-----END PGP SIGNATURE-----

--nextPart1522520.yzXN01S4C1--
