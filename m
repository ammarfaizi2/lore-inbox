Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263339AbTKKEOp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 23:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263334AbTKKEOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 23:14:44 -0500
Received: from h80ad251e.async.vt.edu ([128.173.37.30]:36738 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263339AbTKKEOn (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 23:14:43 -0500
Message-Id: <200311110414.hAB4EZA8007309@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Daniel Gryniewicz <dang@fprintf.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: OT: why no file copy() libc/syscall ?? 
In-Reply-To: Your message of "Mon, 10 Nov 2003 23:03:26 EST."
             <1068523406.4156.7.camel@localhost> 
From: Valdis.Kletnieks@vt.edu
References: <1068512710.722.161.camel@cube> <20031110205011.R10197@schatzie.adilger.int>
            <1068523406.4156.7.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_569435137P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 10 Nov 2003 23:14:35 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_569435137P
Content-Type: text/plain; charset=us-ascii

On Mon, 10 Nov 2003 23:03:26 EST, Daniel Gryniewicz said:

> Plus a sys_copy() syscall could be used as a generic way for filesystems
> to set up Copy-on-Write.  Right now, you'd need to have userspace call
> sys-reiser4 or something like that.

This is fast turning into a creeping horror of aggregation.  I defy anybody
to create an API to cover all the options mentioned so far and *not* have it
look like the process_clone horror we so roundly derided a few weeks ago.

--==_Exmh_569435137P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/sGIrcC3lWbTT17ARArjAAJ44dydC4R/Gk1TaaP9L+dePDTrpqgCgtMUv
oTqKspV+otldK1US8yVuTv0=
=HlpW
-----END PGP SIGNATURE-----

--==_Exmh_569435137P--
