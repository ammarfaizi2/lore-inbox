Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267099AbUBMSJC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 13:09:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267144AbUBMSJC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 13:09:02 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:50451 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S267099AbUBMSI7 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 13:08:59 -0500
Message-Id: <200402131808.i1DI8vfA020145@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: why are capabilities disabled? 
In-Reply-To: Your message of "Fri, 13 Feb 2004 18:54:53 +0100."
             <402D0F6D.7090803@upb.de> 
From: Valdis.Kletnieks@vt.edu
References: <c0iqrq$erh$1@sea.gmane.org> <200402131601.i1DG1Nsl020006@turing-police.cc.vt.edu>
            <402D0F6D.7090803@upb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-312419994P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 13 Feb 2004 13:08:57 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-312419994P
Content-Type: text/plain; charset=us-ascii

On Fri, 13 Feb 2004 18:54:53 +0100, =?ISO-8859-1?Q?Sven_K=F6hler?= said:
> everybody's talking about filesystem-capabilities etc.
> i still dream of starting a process with a certain capability.

As long as you're staying in the same domain of capabilities, there's no
really big issue.  The problem starts when you use fork(), exec(), and friends
to launch something that may have a different set of capabilities (either more
or less). Also note that exploited code can cause an exec() in a program that
doesn't even have a call to exec() in it....


--==_Exmh_-312419994P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFALRK5cC3lWbTT17ARAmnAAKColoWPt9yOeXNQzyKoatvp18oZPACg8EWI
b1LmXij6usLGRSodglK8lGA=
=aLIg
-----END PGP SIGNATURE-----

--==_Exmh_-312419994P--
