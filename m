Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751190AbVHQSBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbVHQSBV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 14:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbVHQSBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 14:01:21 -0400
Received: from imf23aec.mail.bellsouth.net ([205.152.59.71]:30657 "EHLO
	imf23aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S1751190AbVHQSBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 14:01:21 -0400
Date: Wed, 17 Aug 2005 13:00:35 -0500
From: Tommy Reynolds <Tommy.Reynolds@MegaCoder.com>
To: Adam Litke <agl@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, agl@us.ibm.com
Subject: Re: [RFC] Cleanup line-wrapping in pgtable.h
Message-Id: <20050817130035.4341592e.Tommy.Reynolds@MegaCoder.com>
In-Reply-To: <1124300739.3139.16.camel@localhost.localdomain>
References: <1124300739.3139.16.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.1.0 (GTK+ 2.6.4; i686-redhat-linux-gnu)
X-Face: Nr)Jjr<W18$]W/d|XHLW^SD-p`}1dn36lQW,d\ZWA<OQ/XI;UrUc3hmj)pX]@n%_4n{Zsg$
 t1p@38D[d"JHj~~JSE_udbw@N4Bu/@w(cY^04u#JmXEUCd]l1$;K|zeo!c.#0In"/d.y*U~/_c7lIl
 5{0^<~0pk_ET.]:MP_Aq)D@1AIQf.juXKc2u[2pSqNSi3IpsmZc\ep9!XTmHwx
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__17_Aug_2005_13_00_35_-0500_c2pN1xf0F9RhIepM"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Wed__17_Aug_2005_13_00_35_-0500_c2pN1xf0F9RhIepM
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Uttered Adam Litke <agl@us.ibm.com>, spake thus:

> The line-wrapping in most of the include/asm/pgtable.h pte test/set
> macros looks horrible in my 80 column terminal.  The following "test the
> waters" patch is how I would like to see them laid out.  I realize that
> the braces don't adhere to CodingStyle but the advantage is (when taking
> wrapping into account) that the code takes up no additional space.  How
> do people feel about making this change?  Any better suggestions?  I
> personally wouldn't like a lone closing brace like normal functions
> because of the extra lines eaten.  I volunteer to patch up the other
> architectures if we reach a consensus.

Congratulations for keeping your 80-column display.  The coding
standard assumes that and 8-character tabs for carefully thought-out
software development reasons -- they are functional, not traditional.

Since these are inline procedures, make them follow the coding
standard; that's why we have one.

Cheers

--Signature=_Wed__17_Aug_2005_13_00_35_-0500_c2pN1xf0F9RhIepM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFDA3tD/0ydqkQDlQERAq+nAJ9Fey7ikgA18YNQDJm3SRmo9IZ3lACffVED
REvOfQUyTqyAcupGl38dOQA=
=tuQj
-----END PGP SIGNATURE-----

--Signature=_Wed__17_Aug_2005_13_00_35_-0500_c2pN1xf0F9RhIepM--
