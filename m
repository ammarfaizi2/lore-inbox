Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261637AbUJ3BCf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261637AbUJ3BCf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 21:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263730AbUJ3A7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 20:59:06 -0400
Received: from hostmaster.org ([212.186.110.32]:39606 "EHLO hostmaster.org")
	by vger.kernel.org with ESMTP id S262045AbUJ3Axp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 20:53:45 -0400
Subject: Re: status of DRM_MGA on x86_64
From: Thomas Zehetbauer <thomasz@hostmaster.org>
To: Ian Romanick <idr@us.ibm.com>
Cc: linux-kernel@vger.kernel.org,
       "DRI developer's list" <dri-devel@lists.sourceforge.net>
In-Reply-To: <41829E39.1000909@us.ibm.com>
References: <1099052450.11282.72.camel@hostmaster.org>
	 <1099061384.11918.4.camel@hostmaster.org>  <41829E39.1000909@us.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-sW/huqUvCHD8Hq45abbF"
Date: Sat, 30 Oct 2004 02:53:36 +0200
Message-Id: <1099097616.11918.26.camel@hostmaster.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-sW/huqUvCHD8Hq45abbF
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fre, 2004-10-29 at 12:47 -0700, Ian Romanick wrote:
> The problem, which exists with most (all?) DRM drivers, is that data=20
> types are used in the kernel/user interface that have different sizes on=20
> LP32 and LP64.  If your kernel is 64-bit, you will have problems with=20
> 32-bit applications.

Then either all or no DRM drivers should be enabled on x86_64, the
DRM_TDFX, DRM_R128, DRM_RADEON and DRM_SIS are not currently disabled. I
vote for enabling all drivers that work with 64-bit applications.

I wonder if this should be the first and only place where different
kernel/userland bitness causes problems. How has this been solved
elsewhere?

Tom

--=20
  T h o m a s   Z e h e t b a u e r   ( TZ251 )
  PGP encrypted mail preferred - KeyID 96FFCB89
      finger thomasz@hostmaster.org for key

Chemists don't die, they just stop to react.




--=-sW/huqUvCHD8Hq45abbF
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iQEVAwUAQYLmEGD1OYqW/8uJAQL3pAf+JAjch7OKlqaPUFIh6anGlWsJjXWsCWzw
5kK4Ukwcn876Myfs80904a+tunqaXnkYLGc2RTzzfKB+Mp0SQbsEiE1htp2285ni
4HXXZ+uJpWCQTYeuMW1eNNoFJUD626SwJJYC4TAlKPxAHRPTF9oyALxDYFa730f+
YyBRnTB0ktvBp64/QfhjfNplzg2f9ry4NqYDP6UdyaqJppgPubTtR9ibae6+ZgCt
mjl5dmxaVO5ESmVbb4BKGCm7eIfPUz0vmZtQbKl+npLUv7tss+nW3rw/kE9VPUeE
YGOKP8DbgOqpNLijoY/Sphn25XaAXBBeh3Vj59TCjmNOXaKmCEfYEw==
=qx4S
-----END PGP SIGNATURE-----

--=-sW/huqUvCHD8Hq45abbF--

