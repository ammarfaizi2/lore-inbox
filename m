Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266034AbUAFAIm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 19:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266050AbUAFAIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 19:08:41 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:35458 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S266034AbUAEX6i (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 18:58:38 -0500
Message-Id: <200401052358.i05NwWIe010594@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mremap() bug IMHO not in 2.2 
In-Reply-To: Your message of "Mon, 05 Jan 2004 15:36:41 PST."
             <Pine.LNX.4.58.0401051532510.5737@home.osdl.org> 
From: Valdis.Kletnieks@vt.edu
References: <20040105145421.GC2247@rdlg.net> <Pine.LNX.4.58L.0401051323520.1188@logos.cnet> <20040105181053.6560e1e3.grundig@teleline.es> <20040105182607.GB2093@pasky.ji.cz> <20040105225508.GM2093@pasky.ji.cz>
            <Pine.LNX.4.58.0401051532510.5737@home.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-2090502632P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 05 Jan 2004 18:58:32 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-2090502632P
Content-Type: text/plain; charset=us-ascii

On Mon, 05 Jan 2004 15:36:41 PST, Linus Torvalds said:

> So yes, it creates some confusion in the VM layer, but it all seems 
> benign. It's clearly a bug, but where does the security problem come in?

Just guessing, but would a zero-length vma be rounded up to a page, and
thus give the attacker scribble permission on a page he shouldn't have had?


--==_Exmh_-2090502632P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/+foocC3lWbTT17ARAuKWAJ9bAZ20RvLncXpP0KIdcqAOWfYUKgCfWnYa
Jlp+VFeBwO9CzbPchjVLxDQ=
=Zic0
-----END PGP SIGNATURE-----

--==_Exmh_-2090502632P--
