Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267653AbUJGRWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267653AbUJGRWv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 13:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267607AbUJGRTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 13:19:35 -0400
Received: from mout1.freenet.de ([194.97.50.132]:34954 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S266175AbUJGRSZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 13:18:25 -0400
From: Michael Buesch <mbuesch@freenet.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [2.4] 0-order allocation failed
Date: Thu, 7 Oct 2004 19:17:30 +0200
User-Agent: KMail/1.7
References: <200410071318.21091.mbuesch@freenet.de> <20041007151518.GA14614@logos.cnet>
In-Reply-To: <20041007151518.GA14614@logos.cnet>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart11084998.4l8cs4aE8I";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200410071917.40896.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart11084998.4l8cs4aE8I
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Quoting Marcelo Tosatti <marcelo.tosatti@cyclades.com>:
> On Thu, Oct 07, 2004 at 01:18:13PM +0200, Michael Buesch wrote:
> > Hi all,
> >=20
> > I'm running 2.4.28 bk snapshot of 2004.09.03
> > The machine has an uptime of 7 days, 23:46 now.
> >=20
> > I was running several bittorrent clients inside of
> > a screen session. Suddenly they all died (including the
> > screen session).
> > dmesg sayed this:
> >=20
> > __alloc_pages: 0-order allocation failed (gfp=3D0x1f0/0)
> > __alloc_pages: 0-order allocation failed (gfp=3D0x1d2/0)
> > VM: killing process python
> > __alloc_pages: 0-order allocation failed (gfp=3D0x1d2/0)
> > __alloc_pages: 0-order allocation failed (gfp=3D0x1d2/0)
> > VM: killing process screen
> >=20
> > I already got this with kernel 2.4.27 vanilla after a
> > higher amount of uptime (I think it was over 10 days).
> > This was exactly the reason I updated to bk snapshot.
> >=20
> > What can be the reason for this? Is it OOM? (I can't
> > really believe it is).
>=20
> Can you check how much swap space is there available when
> the OOM killer trigger? I bet this is the case.

The machine doesn't have swap.

> If its not, we have a problem.
>=20
> > Is it a kernel memory leak?
> >=20
> > With 2.4.26 I never got these errors. And I ran uptimes
> > up to 50 days.
>=20
>=20

=2D-=20
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]


--nextPart11084998.4l8cs4aE8I
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBZXo0FGK1OIvVOP4RAnv+AJ40+YfqBpQcWazO9fwk6KxluFHCgQCeP5iB
x/iGQcIs4L3AfMsC9RbIIOU=
=5QLg
-----END PGP SIGNATURE-----

--nextPart11084998.4l8cs4aE8I--
