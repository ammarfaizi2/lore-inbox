Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030251AbWCWPjQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030251AbWCWPjQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 10:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030252AbWCWPjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 10:39:16 -0500
Received: from mx1.mm.pl ([217.172.224.151]:47754 "EHLO mx1.mm.pl")
	by vger.kernel.org with ESMTP id S1030251AbWCWPjP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 10:39:15 -0500
From: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
To: ck@vds.kolivas.org
Subject: Re: [ck] swap prefetching merge plans
Date: Thu, 23 Mar 2006 16:34:44 +0100
User-Agent: KMail/1.9.1
Cc: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20060322205305.0604f49b.akpm@osdl.org> <200603231804.36334.kernel@kolivas.org>
In-Reply-To: <200603231804.36334.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1226761.OkYWkOkD0d";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603231634.53067.astralstorm@gorzow.mm.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1226761.OkYWkOkD0d
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 23 March 2006 08:04, Con Kolivas wrote yet:
> On Thu, 23 Mar 2006 03:53 pm, Andrew Morton wrote:
> > A look at the -mm lineup for 2.6.17:
> >
> > mm-implement-swap-prefetching.patch
> > mm-implement-swap-prefetching-fix.patch
> > mm-implement-swap-prefetching-tweaks.patch
> >
> >   Still don't have a compelling argument for this, IMO.
>
> For those users who feel they do have a compelling argument for it, please
> speak now or I'll end up maintaining this in -ck only forever.  I've come
> to depend on it with my workloads now so I'm never dropping it. There's no
> point me explaining how it is useful yet again, though, because I just end
> up looking like I'm handwaving. It seems a shame for it not to be availab=
le
> to all linux users.
>

A compelling argument? Launch UT2004 and some applications in the backgroun=
d.
They'll get swapped out. Shock horror when you wait x seconds before system=
=20
gets responsive and applications are swapped in. (especially the new manual=
=20
option helps)

Same applies to any large compile. (KDE with --enable-final springs to mind=
,=20
but Firefox should also be large enough)
Even 0,5G of memory is not enough for those and a few apps.

Another boon is retaining swapped-out data.
Saves a lot of time when I keep large applications in background and only u=
se=20
them sporadically. (OpenOffice springs to mind)

=2D-=20
GPG Key id:  0xD1F10BA2
=46ingerprint: 96E2 304A B9C4 949A 10A0  9105 9543 0453 D1F1 0BA2

AstralStorm

--nextPart1226761.OkYWkOkD0d
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQBEIsAdlUMEU9HxC6IRAqHeAKCH2eAtFRS4LEzpHJNhETxcPjlYLACdF3x0
L9l5vs0jFT61/71ma/M/IMQ=
=aHj/
-----END PGP SIGNATURE-----

--nextPart1226761.OkYWkOkD0d--
