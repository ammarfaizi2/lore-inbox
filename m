Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264121AbTEaDFC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 23:05:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264122AbTEaDFC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 23:05:02 -0400
Received: from h80ad271f.async.vt.edu ([128.173.39.31]:50050 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S264121AbTEaDFB (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 23:05:01 -0400
Message-Id: <200305310318.h4V3IDn1003598@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: margitsw@t-online.de (Margit Schubert-While)
Cc: linux-kernel@vger.kernel.org
Subject: Re: drivers/char/sysrq.c 
In-Reply-To: Your message of "Fri, 30 May 2003 18:11:49 +0200."
             <5.1.0.14.2.20030530180058.00af0290@pop.t-online.de> 
From: Valdis.Kletnieks@vt.edu
References: <5.1.0.14.2.20030530180058.00af0290@pop.t-online.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1728845192P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 30 May 2003 23:18:12 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1728845192P
Content-Type: text/plain; charset=us-ascii

On Fri, 30 May 2003 18:11:49 +0200, margitsw@t-online.de (Margit Schubert-While)  said:
> I wonder if there are other places where "&" (or "|") is coded and
> "&&" (or "||") is meant (or vice-versa) where the result is NOT semantically
> the same :-)
> It'll take a good checker to sort that one!

It shouldn't be hard at all to deal with the form:

(A compare B) op (C compare D)

The scary part would be if  the right-hand size has a side-effect - then
the choice of |, & over ||, && would definitely be bug-inducing (or possibly
bug-fixing)?

--==_Exmh_1728845192P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+2B70cC3lWbTT17ARAtx0AKDSUUapFJlJCbNLQN6MwAxo992DEgCeOz21
hltv+cEUp2ulwhpr1HXRyUg=
=Hi5X
-----END PGP SIGNATURE-----

--==_Exmh_1728845192P--
