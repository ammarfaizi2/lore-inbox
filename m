Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271051AbTGPTSJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 15:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271033AbTGPTSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 15:18:08 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:15489 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S271051AbTGPTSF (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 15:18:05 -0400
Message-Id: <200307161932.h6GJWgup001735@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>, nuno.monteiro@ptnix.com,
       linux-kernel@vger.kernel.org
Subject: Re: woes with 2.6.0-test1 and xscreensaver/xlock 
In-Reply-To: Your message of "Wed, 16 Jul 2003 12:16:27 PDT."
             <20030716121627.0ac0d238.rddunlap@osdl.org> 
From: Valdis.Kletnieks@vt.edu
References: <20030716172758.GA1792@hobbes.itsari.int> <Pine.LNX.4.53.0307161454180.32541@montezuma.mastecende.com>
            <20030716121627.0ac0d238.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-863299688P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 16 Jul 2003 15:32:42 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-863299688P
Content-Type: text/plain; charset=us-ascii

On Wed, 16 Jul 2003 12:16:27 PDT, "Randy.Dunlap" said:

> Alan says that it's fixed in RH 9 IIRC, but no details about the
> problem or the fix.... ?  Sounds a little like a userspace (library
> or syscall) issue.  Someone mentioned PAM also.
 
I suspect it's the same bug that wedged PAM when the "child runs first"
patch made its appearance:

* Mon Apr 23 2001 Nalin Dahyabhai <nalin@redhat.com>

- merge up to 0.75
- pam_unix: temporarily ignore SIGCHLD while running the helper
- pam_pwdb: temporarily ignore SIGCHLD while running the helper
- pam_dispatch: default to uncached behavior if the cached chain is empty



--==_Exmh_-863299688P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/FahacC3lWbTT17ARApfjAJ9Keg4JbYR+V1w2lRCb6asopa98xwCeMycV
zWTQJYZtfODPR/H9snM99dk=
=eAiA
-----END PGP SIGNATURE-----

--==_Exmh_-863299688P--
