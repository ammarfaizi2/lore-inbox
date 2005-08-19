Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964773AbVHSAuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbVHSAuM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 20:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932545AbVHSAuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 20:50:11 -0400
Received: from ciistr1.ist.utl.pt ([193.136.128.1]:28331 "EHLO
	ciistr1.ist.utl.pt") by vger.kernel.org with ESMTP id S932544AbVHSAuK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 20:50:10 -0400
From: "Pedro Venda (SYSADM)" <pjvenda@rnl.ist.utl.pt>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux under 8MB
Date: Fri, 19 Aug 2005 01:47:15 +0000
User-Agent: KMail/1.8.2
Cc: Imanpreet Arora <imanpreet@gmail.com>
References: <c26b9592050818151154ff1a89@mail.gmail.com>
In-Reply-To: <c26b9592050818151154ff1a89@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2289894.Ess3iG5Ucu";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200508190147.18207.pjvenda@rnl.ist.utl.pt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2289894.Ess3iG5Ucu
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 18 August 2005 22:11, Imanpreet Arora wrote:
> Hi all,
>
>               For the last couple of days, I have been trying to set
> up linux kernel under 8MB. So far I have set up a linux 2.4.31, which
> just works under 8MB. However, I would be grateful if someone could
> help with the following queries

hi,

what do you mean 8MB? RAM or storage space? what do you intend to acomplish=
=20
with such project?

I've been working on something simillar. I've been able to create a micro=20
distro which runs from a floppy disk (kernel+initrd.gz+bootloader<=3D1.44MB=
)=20
and boots well with as low as 5MB of RAM (tested with qemu). The kernel I'v=
e=20
used was 2.6.9, but 2.6.12 should work as well.

> a)          Is linux2.4 just the right option? What about linux 2.0.x?
> Or for that matter even <2.0

2.6 has serious advantage over others when considering embedded environment=
s=20
(not sure if it applies to you)

> b)          What are the specific issues that are to be considered
> while compiling an old kernel on a newer setup? I ask this because I
> compiled my current setup on a 2.6.11 machine and while doing "make
> modules_install", I got errors from depmod[%], complaining about
> depmod.old.  I had to kludge my way through by setting up a link from
> depmod.old to depmod.

I did use uClibc and busybox (crosso compiled and linked to uClibc) to keep=
=20
the distro as small as possible. (see buildroot from the maker of uClibc an=
d=20
busybox)

regards,
=2D-=20

Pedro Jo=E3o Lopes Venda
email: pjvenda < at > rnl.ist.utl.pt
http://arrakis.dhis.org

--nextPart2289894.Ess3iG5Ucu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDBTomeRy7HWZxjWERAot1AJ9yIOg8wUYEc2q89tPAHL/onVof7gCff/YU
QfBLWLKhgz+DWS0C4yo0+Aw=
=aRwv
-----END PGP SIGNATURE-----

--nextPart2289894.Ess3iG5Ucu--
