Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261967AbVEDRT7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbVEDRT7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 13:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261671AbVEDRSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 13:18:13 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:32780 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261845AbVEDRQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 13:16:41 -0400
Message-Id: <200505041716.j44HGPbV016851@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] update SubmittingPatches to clarify attachment policy 
In-Reply-To: Your message of "Wed, 04 May 2005 10:01:56 PDT."
             <20050504170156.87F67CE5@kernel.beaverton.ibm.com> 
From: Valdis.Kletnieks@vt.edu
References: <20050504170156.87F67CE5@kernel.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1115226984_4721P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 04 May 2005 13:16:25 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1115226984_4721P
Content-Type: text/plain; charset=us-ascii

On Wed, 04 May 2005 10:01:56 PDT, Dave Hansen said:

> -6) No MIME, no links, no compression, no attachments.  Just plain text.
> +6) No MIME, no links, no compression.  Just plain text.

Logically buggy.  You can't have an attachment without the MIME markup that
*says* it's an attachment.  I think what you meant was "No Content-Type-Encoding":
i.e. 'none' is acceptable, but 'quoted-printable' (which causes all the
spurious =20 and =3D you sometimes see) and 'base64' (uuencode on steroids)
aren't....

--==_Exmh_1115226984_4721P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCeQNocC3lWbTT17ARAtC6AJ9OAttjU1/6L/UJM4PMS/2gV2y/aACgs63w
qt2GmGK4c7pUR6GLDmHN4Lg=
=cGIJ
-----END PGP SIGNATURE-----

--==_Exmh_1115226984_4721P--
