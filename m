Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268698AbTBZKEo>; Wed, 26 Feb 2003 05:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268699AbTBZKEo>; Wed, 26 Feb 2003 05:04:44 -0500
Received: from rumms.uni-mannheim.de ([134.155.50.52]:22507 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S268698AbTBZKEn>; Wed, 26 Feb 2003 05:04:43 -0500
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: Andrew Morton <akpm@digeo.com>, Dave Jones <davej@codemonkey.org.uk>
Subject: Re: [PATCH][2.5] fix preempt-issues with smp_call_function()
Date: Wed, 26 Feb 2003 11:14:30 +0100
User-Agent: KMail/1.5
Cc: torvalds@transmeta.com, hugh@veritas.com, linux-kernel@vger.kernel.org
References: <200302251908.55097.schlicht@uni-mannheim.de> <20030226103742.GA29250@suse.de> <20030226015409.78e8e1fb.akpm@digeo.com>
In-Reply-To: <20030226015409.78e8e1fb.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_MOJX+xt+Qub5Wlt";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200302261114.36387.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_MOJX+xt+Qub5Wlt
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Description: signed data
Content-Disposition: inline

Dave Jones <davej@codemonkey.org.uk> wrote:
> Just one comment. You moved quite a few of the preempt_disable/enable
> pairs outside of the CONFIG_SMP checks.  The issue we're working against
> here is to try and prevent preemption and ending up on a different CPU.
> As this cannot happen if CONFIG_SMP=n, I don't see why you've done this.

Andrew Morton wrote:
> Just in two places.
[snip]

Yes, thanks for delivering this better patch!
My approach wanted just to be the most simple possibility... ;-)

   Thomas
--Boundary-02=_MOJX+xt+Qub5Wlt
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+XJOMYAiN+WRIZzQRAhekAJ9KkPAji4SFebt2ahvYipLcNKcvGwCgqkh4
BtOSc98n7n+Ev7u3aoBrUZ4=
=55UI
-----END PGP SIGNATURE-----

--Boundary-02=_MOJX+xt+Qub5Wlt--

