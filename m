Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262306AbTJAOaS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 10:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262307AbTJAOaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 10:30:18 -0400
Received: from h80ad24ae.async.vt.edu ([128.173.36.174]:14994 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262306AbTJAOaM (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 10:30:12 -0400
Message-Id: <200310011429.h91ETtcG009923@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Dave Jones <davej@redhat.com>
Cc: Matthew Wilcox <willy@debian.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CONFIG_* In Comments Considered Harmful 
In-Reply-To: Your message of "Wed, 01 Oct 2003 15:19:52 BST."
             <20031001141950.GA13115@redhat.com> 
From: Valdis.Kletnieks@vt.edu
References: <20031001132619.GL24824@parcelfarce.linux.theplanet.co.uk>
            <20031001141950.GA13115@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1485680385P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 01 Oct 2003 10:29:55 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1485680385P
Content-Type: text/plain; charset="us-ascii"
Content-Id: <9912.1065018595.1@turing-police.cc.vt.edu>

On Wed, 01 Oct 2003 15:19:52 BST, Dave Jones said:

> Maybe it should be taught to parse comments? There are zillions of
> #endif /* CONFIG_FOO */
> braces in the tree. Why is this one special ?

I think it's because it looked like:

#ifdef CONFIG_FOO
....
#endif /* CONFIG_FOO or CONFIG_BAR */

and it concluded there was a dependency on BAR.

--==_Exmh_1485680385P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/euTjcC3lWbTT17ARAsW4AJ437enC5P+kvnWC8jbH8lApEBC9eQCgoREO
KAUzPU6bTyiRlGktQJplYG0=
=Jl+J
-----END PGP SIGNATURE-----

--==_Exmh_1485680385P--
