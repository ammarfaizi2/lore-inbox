Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263412AbTKKITX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 03:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264274AbTKKITX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 03:19:23 -0500
Received: from h80ad251e.async.vt.edu ([128.173.37.30]:58500 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263412AbTKKITV (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 03:19:21 -0500
Message-Id: <200311110819.hAB8J4A8013284@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: John Bradford <john@grabjohn.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Some thoughts about stable kernel development 
In-Reply-To: Your message of "Mon, 10 Nov 2003 08:50:44 GMT."
             <200311100850.hAA8oiIX000283@81-2-122-30.bradfords.org.uk> 
From: Valdis.Kletnieks@vt.edu
References: <m3u15de669.fsf@defiant.pm.waw.pl> <200311091950.hA9Jo01d002041@81-2-122-30.bradfords.org.uk> <200311091754.21619.rob@landley.net>
            <200311100850.hAA8oiIX000283@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1622051872P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 11 Nov 2003 03:19:04 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1622051872P
Content-Type: text/plain; charset=us-ascii

On Mon, 10 Nov 2003 08:50:44 GMT, John Bradford <john@grabjohn.com>  said:

> cause annoyance to third parties.  Given that, I think a file in the
> root of the kernel tree, saying something like, "Don't use me on an
> internet connected machine unless you know what you're doing" would be
> worth considering.

OK.. I'll bite.. :)

What *additional* level of "know what you're doing" is called for, over and
above the usual "best practices" we wish all net-connected machines implemented?

Or phrased differently - yes, there's several local-user-gets-root attacks that
aren't patched.  However, I'm sure that even a tightened down and fully-patched
system has several ways to do that without leveraging a kernel bug, so the
question becomes "balance the chances that the attacker has an exploit for the
kernel bug" against "chance attacker has exploit for set-UID program XYZ".

Or is the assumption that if you understand how "remote execution of
arbitrary code as local user" combines with "local user gets root" to
form the product "you're screwed", sufficient clue is available?


--==_Exmh_1622051872P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/sJt4cC3lWbTT17ARAo9bAKChLJrk8z1MCp9N4+JQxjAkugc5owCfUcYI
LCTa7/q+ykEIF+4PLfsqo94=
=z44y
-----END PGP SIGNATURE-----

--==_Exmh_1622051872P--
