Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbUCaFsB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 00:48:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbUCaFr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 00:47:59 -0500
Received: from turing-police.cirt.vt.edu ([128.173.54.129]:60041 "EHLO
	turing-police.cirt.vt.edu") by vger.kernel.org with ESMTP
	id S261752AbUCaFrn (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 00:47:43 -0500
Message-Id: <200403310547.i2V5lYae027457@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Humberto Massa <humberto.massa@almg.gov.br>
Cc: debian-devel@lists.debian.org, debian-legal@lists.debian.org,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: POSSIVEL SPAM-- Re: Binary-only firmware covered by the GPL? 
In-Reply-To: Your message of "Tue, 30 Mar 2004 14:44:32 -0300."
             <4069B200.8010309@almg.gov.br> 
From: Valdis.Kletnieks@vt.edu
References: <YBtoCC.A.e-C.5maaAB@murphy>
            <4069B200.8010309@almg.gov.br>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_887855632P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 31 Mar 2004 00:47:34 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_887855632P
Content-Type: text/plain; charset=us-ascii

On Tue, 30 Mar 2004 14:44:32 -0300, Humberto Massa said:

> There is another fail in your reasons here: as I said before, it just 
> _happens_ to happen that fw[] = {} *is* the source code. What we must 
> decide is what to do in the cases where *we don't know*.
> 
> After all, what happens is somebody *actually* prefers the binary blob 
> for modification? And, what happens if _the copyright holder_ actually 
> prefers the binary blob for modification? No inconsistency here.

In fact, I was going to suggest that quite possibly, there really *is* no other
option for source, because the target hardware doesn't have a functional enough
toolchain, so hand-assembly really *is* the most reasonable thing.

That file isn't any worse than my early '80s Compiler Design class project
(done the last year before lex/yacc became available for the class) - one file
was a large 247x139x3 (or thereabouts) array of integers, encoding all the
shift/reduce productions for a compiler for a Pascal subset that actually
generated working (though painfully ugly) code for the IBM S/370 architecture.
(The assignment was "Pascal subset plus your choice of one extension" - my
teammate and I made the mistake of choosing "Fortran-style mixed-mode
arithmetic", that array was literally 1/4 the size before we started that.)

"You are lost in a maze of tiny little shift/reduce productions, all nearly
alike"

And yes, the two of us generated the whole table by hand.  I admit we did
finally break down and write some tools to verify that each line of the table
did in fact have the right number of entries, and to add a column of zeros when
the number of productions went up.

*Preferred* source format?  lex/yacc input files.  Did the source ever actually
*exist* in that format?  Nope... :)


--==_Exmh_887855632P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAalt2cC3lWbTT17ARAngbAKD1rHOWsuRC1AX080achgALrIXSnACgpBrO
yacVOCZP7G1idpYk06cctgg=
=hqEX
-----END PGP SIGNATURE-----

--==_Exmh_887855632P--
