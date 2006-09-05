Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751344AbWIELVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbWIELVL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 07:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWIELVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 07:21:11 -0400
Received: from agent.admingilde.org ([213.95.21.5]:9196 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP
	id S1751323AbWIELVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 07:21:09 -0400
Date: Tue, 5 Sep 2006 13:20:57 +0200
From: Martin Waitz <tali@admingilde.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [RFC][PATCH 3/9] actual generic PAGE_SIZE infrastructure
Message-ID: <20060905112056.GJ17042@admingilde.org>
Mail-Followup-To: Dave Hansen <haveblue@us.ibm.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
References: <20060830221604.E7320C0F@localhost.localdomain> <20060830221606.40937644@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVh9lyqKgK19OcEf"
Content-Disposition: inline
In-Reply-To: <20060830221606.40937644@localhost.localdomain>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EVh9lyqKgK19OcEf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Wed, Aug 30, 2006 at 03:16:06PM -0700, Dave Hansen wrote:
> * Define ASM_CONST() macro to help using constants in both assembly
>   and C code.  Several architectures have some form of this, and
>   they will be consolidated around this one.

arm uses UL() for this and I think this is much more readable than
ASM_CONST().  Can we please change the name of this macro?

--=20
Martin Waitz

--EVh9lyqKgK19OcEf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFE/V2Yj/Eaxd/oD7IRAlW5AJwOaK27o73iX/riP1NB2LyQjw9uxACffAu8
r+mLEYn/BZ3UAWoHDopViS8=
=WfbZ
-----END PGP SIGNATURE-----

--EVh9lyqKgK19OcEf--
