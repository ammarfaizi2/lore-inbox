Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263980AbUFBT5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263980AbUFBT5j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 15:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264019AbUFBT5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 15:57:39 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:55510 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263980AbUFBT5Y (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 15:57:24 -0400
Message-Id: <200406021955.i52JtZ7E006537@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Davide Libenzi <davidel@xmailserver.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Pavel Machek <pavel@suse.cz>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@redhat.com>,
       Ingo Molnar <mingo@elte.hu>, Andrea Arcangeli <andrea@suse.de>,
       Rik van Riel <riel@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] explicitly mark recursion count 
In-Reply-To: Your message of "Wed, 02 Jun 2004 20:37:20 BST."
             <20040602193720.GQ12308@parcelfarce.linux.theplanet.co.uk> 
From: Valdis.Kletnieks@vt.edu
References: <200406011929.i51JTjGO006174@eeyore.valparaiso.cl> <Pine.LNX.4.58.0406011255070.14095@ppc970.osdl.org> <20040602131623.GA23017@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0406020712180.3403@ppc970.osdl.org> <Pine.LNX.4.58.0406020724040.22204@bigblue.dev.mdolabs.com> <20040602182019.GC30427@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0406021124310.22742@bigblue.dev.mdolabs.com> <20040602185832.GA2874@wohnheim.fh-wedel.de>
            <20040602193720.GQ12308@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1408578314P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 02 Jun 2004 15:55:35 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1408578314P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Wed, 02 Jun 2004 20:37:20 BST, viro@parcelfarce.linux.theplanet.co.uk =
said:

> Wrong.  They are often passed as arguments to generic helpers, without
> being ever put into any structures.

At least those can *hopefully* be automatically detected by looking at th=
e
function's definition.  Are there any known cases where they're "passed
through" from caller to generic_a to generic_b which ends up calling the
function via pointer, or is it restricted to caller, generic_a, *(pointer=
)?


--==_Exmh_1408578314P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAvjC3cC3lWbTT17ARAsmwAKCMKM7GTu8adyDE/ERiMH7rqw93jQCg77PX
hcYyUNo9ioByNymYXgLbbvA=
=uIfb
-----END PGP SIGNATURE-----

--==_Exmh_1408578314P--
