Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275085AbTHGDNB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 23:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275090AbTHGDNB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 23:13:01 -0400
Received: from h80ad2654.async.vt.edu ([128.173.38.84]:17282 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S275085AbTHGDM7 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 23:12:59 -0400
Message-Id: <200308070312.h773Ce6h004590@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Jeff Sipek <jeffpc@optonline.net>
Cc: Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][TRIVIAL] Bugzilla bug # 322 - double logical operator drivers/char/sx.c 
In-Reply-To: Your message of "Wed, 06 Aug 2003 21:26:30 EDT."
             <200308062126.37658.jeffpc@optonline.net> 
From: Valdis.Kletnieks@vt.edu
References: <200308061830.05586.jeffpc@optonline.net> <3F319EE7.8010409@techsource.com>
            <200308062126.37658.jeffpc@optonline.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1286923656P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 06 Aug 2003 23:12:38 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1286923656P
Content-Type: text/plain; charset=us-ascii

On Wed, 06 Aug 2003 21:26:30 EDT, Jeff Sipek said:

> > Can you really DO (x < y > z) and have it work as an anded pair of
> > comparisons?  Maybe this is an addition to C that I am not aware of.
> >
> > I would expect (x < y > z) to be equivalent to ((x < y) > z).
> 
> Ah, very true. I wonder what the author intended. Also, since the 'z' is 0 in
> all the cases, the statement "(i < TIMEOUT) > 0" can be reduced to "i < 
> TIMEOUT".

Of course, if the author intended (x<y) && (x > 0), you can't reduce it if
x is at all possibly negative....

--==_Exmh_-1286923656P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/McOmcC3lWbTT17ARAtFPAJ9y4h+Ynzd5dUESw9gSgX5Hnz7t3gCgvmz8
2kxjmrA2yhLs6fSMCR5F1Ho=
=cDHf
-----END PGP SIGNATURE-----

--==_Exmh_-1286923656P--
