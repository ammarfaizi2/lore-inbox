Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269679AbUHZV3R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269679AbUHZV3R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 17:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269690AbUHZV1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 17:27:16 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:50393 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S269697AbUHZVXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 17:23:08 -0400
Message-Id: <200408262122.i7QLMwH4000966@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 07/26/2004 with nmh-1.1-RC3
To: Kees Cook <kees@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch] TIOCCONS security 
In-Reply-To: Your message of "Wed, 25 Aug 2004 14:03:41 PDT."
             <pan.2004.08.25.21.03.41.684647@osdl.org> 
From: Valdis.Kletnieks@vt.edu
References: <20040825151106.GA21687@suse.de> <20040825161504.A8896@infradead.org> <20040825161630.B8896@infradead.org> <20040825161837.GB21687@suse.de>
            <pan.2004.08.25.21.03.41.684647@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1637107237P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 26 Aug 2004 17:22:58 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1637107237P
Content-Type: text/plain; charset=us-ascii

On Wed, 25 Aug 2004 14:03:41 PDT, Kees Cook said:

> Confirmed.  If you run the following code as a regular user, you can see
> messages.  (BTW: don't do a "tail -f /dev/console".  For reasons I don't
> understand, it writes endless CRs to which ever tty you happen to have
> open):

It's probably a bananana problem.  The tail -f writes something, which ends in
a \n.  Then the tail -f reads the last thing written, which was a \n, and
writes it out, and..... 


--==_Exmh_-1637107237P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBLlSxcC3lWbTT17ARAuqhAJ43sVdhJ+yaDOSqamcuaw1KF5BkYACeOsje
QP5/ls+FZzkSsBT6tipPecU=
=xxWh
-----END PGP SIGNATURE-----

--==_Exmh_-1637107237P--
