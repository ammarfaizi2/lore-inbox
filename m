Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267505AbUIPA3H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267505AbUIPA3H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 20:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267819AbUIPA0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 20:26:34 -0400
Received: from s-utl01-nypop.stsn.com ([199.106.90.52]:50127 "HELO
	s-utl01-nypop.stsn.com") by vger.kernel.org with SMTP
	id S267505AbUIPAXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 20:23:10 -0400
Date: Wed, 15 Sep 2004 19:22:31 -0500
From: Tommy Reynolds <Tommy.Reynolds@MegaCoder.com>
To: linux-kernel@vger.kernel.org
Subject: Re: monoholitic, hybrid or not monoholitic?
Message-Id: <20040915192231.1153a0d4.Tommy.Reynolds@MegaCoder.com>
In-Reply-To: <20040915141237.GB2429@teh.ath.cx>
References: <4148271D.9050009@devilcode.de>
	<20040915141237.GB2429@teh.ath.cx>
X-Mailer: Sylpheed version 0.9.12cvs7 (GTK+ 1.2.10; i686-redhat-linux-gnu)
X-Face: Nr)Jjr<W18$]W/d|XHLW^SD-p`}1dn36lQW,d\ZWA<OQ/XI;UrUc3hmj)pX]@n%_4n{Zsg$
 t1p@38D[d"JHj~~JSE_udbw@N4Bu/@w(cY^04u#JmXEUCd]l1$;K|zeo!c.#0In"/d.y*U~/_c7lIl
 5{0^<~0pk_ET.]:MP_Aq)D@1AIQf.juXKc2u[2pSqNSi3IpsmZc\ep9!XTmHwx
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Wed__15_Sep_2004_19_22_31_-0500_rwD_=wA08hQPfSL+"
X-OriginalArrivalTime: 16 Sep 2004 00:22:58.0754 (UTC) FILETIME=[51BC6A20:01C49B83]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Wed__15_Sep_2004_19_22_31_-0500_rwD_=wA08hQPfSL+
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Uttered Matt Kavanagh <matthew@teh.ath.cx>, spake thus:

> > the kernel were mostly descripted as monoholitic. but some sources means
> > that the linux kernel is not really monoholitic because of the feature
> > of loading kernel modules.
> I'd tend towards monolithic because the modules (as mentioned) run in kernel
> space.

These discussions are taking the wrong viewpoint.  The difference
between "monolithic" and "modular" kernels refers to their *internal*
organization, not a cosmetic *packaging* decision.

Linux is a monolithic kernel because one kernel routine can call
another directly, without intervention of any message passing
overhead.

Linux modules are simply packaging exercises that allow some code
_not_ originally linked into the kernel image to be grafted into an
executing kernel image.  Once installed, kernel modules can reference
other kernel resources with, again, a straight subroutine reference
without any message passing intervention.

All else is quibbling about the color of the ribbon used to wrap up
the module code ;-)

HTH.
-- 
-- 
.---------------------------------+----------------------------------------.
| Tommy Reynolds                  | Email: <Tommy.Reynolds@MegaCoder.com>  |
| P O Box 62                      | Phone: +1.256.227.1839                 |
| Danville, AL 35619 USA          | Fax:   +1.256.350.5099                 |
| Sr. Software Devel/RHCE         | IM:    HisDivShadow                    |
+---------------------------------+----------------------------------------+
|                     Ask MegaCoder.com For Answers!                       |
'--------------------------------------------------------------------------'
-- 
-- 
.---------------------------------+----------------------------------------.
| Tommy Reynolds                  | Email: <Tommy.Reynolds@MegaCoder.com>  |
| P O Box 62                      | Phone: +1.256.227.1839                 |
| Danville, AL 35619 USA          | Fax:   +1.256.350.5099                 |
| Sr. Software Devel/RHCE         | IM:    HisDivShadow                    |
+---------------------------------+----------------------------------------+
|                     Ask MegaCoder.com For Answers!                       |
'--------------------------------------------------------------------------'

--Signature=_Wed__15_Sep_2004_19_22_31_-0500_rwD_=wA08hQPfSL+
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBSNzY/0ydqkQDlQERAqFtAJ0aXO8Oii1MVoda1hQHFkpf5mNY5gCgtgdb
HTgVkfpre/lbFSutDEvcwvs=
=KsBi
-----END PGP SIGNATURE-----

--Signature=_Wed__15_Sep_2004_19_22_31_-0500_rwD_=wA08hQPfSL+--
