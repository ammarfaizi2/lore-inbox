Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbTJ2C2k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 21:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbTJ2C2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 21:28:40 -0500
Received: from h80ad2501.async.vt.edu ([128.173.37.1]:9600 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261879AbTJ2C2i (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 21:28:38 -0500
Message-Id: <200310290224.h9T2Oc43005010@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Pavel Machek <pavel@suse.cz>,
       felipe_alfaro@linuxmail.org, mochel@osdl.org, george@mvista.com,
       johnstul@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [pm] fix time after suspend-to-* 
In-Reply-To: Your message of "Wed, 29 Oct 2003 09:23:50 +1100."
             <16286.60534.924753.349385@wombat.chubb.wattle.id.au> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.44.0310271535160.13116-100000@cherise> <1067329994.861.3.camel@teapot.felipe-alfaro.com> <20031028093233.GA1253@elf.ucw.cz> <20031028224101.3220e0a6.sfr@canb.auug.org.au>
            <16286.60534.924753.349385@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1682402374P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 28 Oct 2003 21:24:37 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1682402374P
Content-Type: text/plain; charset=us-ascii

On Wed, 29 Oct 2003 09:23:50 +1100, Peter Chubb said:

> Maybe use SIGCKPT and SIGCONT?  Or even SIGSTOP and SIGCONT (after
> all, you're stopping the process, then restarting it)

Some programs do special handling of SIGSTOP (for instance, 'vi' will
drop the terminal out of raw mode) that may not be appropriate for
suspending the system.

--==_Exmh_1682402374P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/nyTlcC3lWbTT17ARAv8OAJ41H/NDM0e2Hh7aGbo4herkmGgF9gCg1Ict
bnNeRaBv+DML1dHgqzf+XHs=
=rotq
-----END PGP SIGNATURE-----

--==_Exmh_1682402374P--
