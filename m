Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263590AbTDWTjH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 15:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263568AbTDWTiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 15:38:18 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:61824 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263570AbTDWThL (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 15:37:11 -0400
Message-Id: <200304231949.h3NJnI3j003336@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Chris Wright <chris@wirex.com>
Cc: lkml <linux-kernel@vger.kernel.org>, lsm <linux-security-module@wirex.com>
Subject: Re: [PATCH] Extended Attributes for Security Modules against 2.5.68 
In-Reply-To: Your message of "Wed, 23 Apr 2003 12:40:51 PDT."
             <20030423124051.D15094@figure1.int.wirex.com> 
From: Valdis.Kletnieks@vt.edu
References: <1051120322.14761.95.camel@moss-huskers.epoch.ncsc.mil> <20030423191749.A4244@infradead.org> <20030423112548.B15094@figure1.int.wirex.com> <20030423125452.I26054@schatzie.adilger.int> <20030423121517.C15094@figure1.int.wirex.com> <200304231928.h3NJS73j002919@turing-police.cc.vt.edu>
            <20030423124051.D15094@figure1.int.wirex.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_302633892P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 23 Apr 2003 15:49:18 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_302633892P
Content-Type: text/plain; charset=us-ascii

On Wed, 23 Apr 2003 12:40:51 PDT, Chris Wright said:
> * Valdis.Kletnieks@vt.edu (Valdis.Kletnieks@vt.edu) wrote:
> > 
> > The requirement that things like ls, find, cp and so on know where to look
> > for these things trumps any "purity of labels" arguments.
> 
> Sorry, I don't follow you.

Wrong Chris.  I meant Christoph Hellig's argument that each module should have
its own unique xattr, where other modules/tools wouldn't necessarily have
a reason to look, so you end up having to do a 'foreach xattr { guess if
this is really what we're looking for}' loop.

--==_Exmh_302633892P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+pu4+cC3lWbTT17ARAjk9AJ9Awa9dQ1B2O6wRgwjeh23OZS6n2ACfbg0y
HmX7yrNlOuAobQbm1vInXDQ=
=BToW
-----END PGP SIGNATURE-----

--==_Exmh_302633892P--
