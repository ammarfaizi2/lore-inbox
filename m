Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266955AbTBTUVM>; Thu, 20 Feb 2003 15:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264931AbTBTUVM>; Thu, 20 Feb 2003 15:21:12 -0500
Received: from rumms.uni-mannheim.de ([134.155.50.52]:19958 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S266955AbTBTUVL>; Thu, 20 Feb 2003 15:21:11 -0500
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: Dave Jones <davej@codemonkey.org.uk>
Subject: Re: [PATCH][2.5] replace flush_map() in arch/i386/mm/pageattr.c with flush_tlb_all()
Date: Thu, 20 Feb 2003 21:30:55 +0100
User-Agent: KMail/1.5
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <200302202002.h1KK2YZ00018@rumms.uni-mannheim.de> <20030220203619.GA26583@codemonkey.org.uk>
In-Reply-To: <20030220203619.GA26583@codemonkey.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_MsTV+oKpNBWm1lj";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200302202131.08663.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_MsTV+oKpNBWm1lj
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: signed data
Content-Disposition: inline

On Thu, Feb 20, 2003 at 21:36, Dave Jones wrote:
> This looks bogus. You're killing the wbinvd() in flush_kernel_map() which
> is needed.

I must admit I don't exactly know the wbinvd() command, but as the comment=
=20
says:
  /* Could use CLFLUSH here if the CPU supports it (Hammer,P4) */

I thought it is not NEEDED, just a COULD...

  Thomas
--Boundary-02=_MsTV+oKpNBWm1lj
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+VTsMYAiN+WRIZzQRAgieAJ9C1lF+qj7YR76e+b5U8OBhDiZOIwCfdpC9
/S/HrpA3zLKhkft+gfvXMBk=
=IKX0
-----END PGP SIGNATURE-----

--Boundary-02=_MsTV+oKpNBWm1lj--

