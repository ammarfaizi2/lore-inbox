Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262449AbTJXShr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 14:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbTJXShr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 14:37:47 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:11136 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262449AbTJXShq (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 14:37:46 -0400
Message-Id: <200310241837.h9OIbjlf003495@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: "C. David Shaffer" <cdshaffer@acm.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: non-root pthread code (attached) "crashes" 2.4.20-8 on Intel...how about 2.4.22 
In-Reply-To: Your message of "Fri, 24 Oct 2003 13:44:17 EDT."
             <16281.25841.66888.498987@aslan.cs.westminster.edu> 
From: Valdis.Kletnieks@vt.edu
References: <16281.25841.66888.498987@aslan.cs.westminster.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_533209984P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 24 Oct 2003 14:37:45 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_533209984P
Content-Type: text/plain; charset=us-ascii

On Fri, 24 Oct 2003 13:44:17 EDT, "C. David Shaffer" <cdshaffer@acm.org>  said:

> Attached is an incorrect solution to a classroom problem which
> reliably crashes (more later) every linux machine that I've tried it
> on.  crash = machine becomes unresponsive to user input, no external

Two words:  "fork bomb".  Known problem since Ritchie, Kernighan, and
Thompson were coding the fork() syscall 30 years ago.

'man ulimit' and look at 'max user processes' (-u).

And before anybody flames about why this is the default value for that ulimit,
ask yourself "what value should be used by default instead?" and be prepared to
justify your answer.


--==_Exmh_533209984P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/mXF4cC3lWbTT17ARAvRWAJ9OGsf3b2GakNO4te3G4h3dPRUpJgCgrKRg
o1hKJrSojmudk5uY1Nrtkis=
=Swub
-----END PGP SIGNATURE-----

--==_Exmh_533209984P--
