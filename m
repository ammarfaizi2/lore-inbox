Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751926AbWCAWrl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751926AbWCAWrl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 17:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751929AbWCAWrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 17:47:41 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:48001 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751926AbWCAWrk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 17:47:40 -0500
Subject: Re: [PATCH] leave APIC code inactive by default on i386
From: "Darrick J. Wong" <djwong@us.ibm.com>
Reply-To: "Darrick J. Wong" <djwong@us.ibm.com>
To: Dave Jones <davej@redhat.com>
Cc: Michael Ellerman <michael@ellerman.id.au>, linux-kernel@vger.kernel.org,
       Chris McDermott <lcm@us.ibm.com>
In-Reply-To: <20060301221404.GA1440@redhat.com>
References: <43D03AF0.3040703@us.ibm.com>
	 <dc1166600602281957h4158c07od19d0e5200d21659@mail.gmail.com>
	 <20060301043353.GJ28434@redhat.com>
	 <1141248546.30185.44.camel@localhost.localdomain>
	 <20060301221404.GA1440@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-eu/xchPdNV4N2bsSPPCV"
Date: Wed, 01 Mar 2006 14:47:38 -0800
Message-Id: <1141253258.30185.60.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-eu/xchPdNV4N2bsSPPCV
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-03-01 at 17:14 -0500, Dave Jones wrote:

> In light of Matthew's comments in this thread though, I'm also wondering
> if we can now get by without this diff, and just enable it by default now
> that the kernel respects that the BIOS and leaves it alone if it's been
> disabled.

Actually, it seems that there are Lenovo ThinkCenter P4 machines with
buggy BIOSes that tell us that we can enable the APIC ... but doing so
eventually causes the system to hang.  Granted, the Google-recommended
fixes are "noapic" or "Update the BIOS", but perhaps it would be best to
leave it off _except_ for the few cases where we know that we need it.

(Then again, the correct solution in this case is to fix the BIOS...)

--D

--=-eu/xchPdNV4N2bsSPPCV
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQBEBiSKa6vRYYgWQuURAkVtAJkBNLWJHVQXaHRYZkwzo0BzwIo1WACfetHX
M4DCKYRzUONKBilZB3evd2s=
=yVwg
-----END PGP SIGNATURE-----

--=-eu/xchPdNV4N2bsSPPCV--

