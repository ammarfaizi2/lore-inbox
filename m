Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbUDOTNQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 15:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbUDOTNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 15:13:16 -0400
Received: from smtp1.adl2.internode.on.net ([203.16.214.181]:57618 "EHLO
	smtp1.adl2.internode.on.net") by vger.kernel.org with ESMTP
	id S261498AbUDOTNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 15:13:14 -0400
Subject: Re: [PATCH][RFC] highpmd for arch i386 PAE
From: Antony Suter <suterant@users.sourceforge.net>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: List LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20040415182815.GB743@holomorphy.com>
References: <1082048738.8544.25.camel@hikaru.lan>
	 <20040415182815.GB743@holomorphy.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-urd2nPslC5uv948CLKBL"
Message-Id: <1082056377.8544.32.camel@hikaru.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 16 Apr 2004 05:12:57 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-urd2nPslC5uv948CLKBL
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-04-16 at 04:28, William Lee Irwin III wrote:
> On Fri, Apr 16, 2004 at 03:05:38AM +1000, Antony Suter wrote:
> > This patch places middle level pagetables into highmem, on PAE machines=
.
> > It is relevant to arch/i386 machines running many processes on 4 to 64
> > GB of RAM.
> > This is simply a resync to the current kernel of a patch released by
> > William Lee Irwin III about 4 months ago. WLI's comments on the patch
> > are:
>=20
> I'll be damned. This is one of the many pieces people never said much
> about. Looks relatively thorough.
>=20
> I did a few things to keep pmd caching around that look like they got
> dropped, but I suppose for a standalone mainline port that's the only
> option.

Did you have a more recent version than the one from
linux-2.6.0-test11-wli-1.tar.bz2 ? Perhaps patch-2.6.0-test11-wli-3.bz2
included it, but you didn't break them out into a tarball?

> I'm really astounded ppl are going through the trouble of resurrecting
> all this stuff. I suppose that means it was valuable to someone.

Well i'm starting at number 01... :)

--=20
- Antony Suter  (suterant users sourceforge net)  "Bonta"
- "...through shadows falling, out of memory and time..."

--=-urd2nPslC5uv948CLKBL
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAft64Zu6XKGV+xxoRAhYbAJ0STgYglu0E+zYpxK5LDbJmAiajzgCfU6tS
jWz7ZKQxUDJEXni6e2R13XE=
=Wktc
-----END PGP SIGNATURE-----

--=-urd2nPslC5uv948CLKBL--

