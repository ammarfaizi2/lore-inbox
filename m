Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423629AbWJaUyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423629AbWJaUyP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 15:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423630AbWJaUyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 15:54:15 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:37323 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1423629AbWJaUyP (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 15:54:15 -0500
Message-Id: <200610312053.k9VKr0Fm007201@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: ray-gmail@madrabbit.org
Cc: "Martin J. Bligh" <mbligh@google.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
Subject: Re: Linux 2.6.19-rc4
In-Reply-To: Your message of "Tue, 31 Oct 2006 08:34:23 PST."
             <2c0942db0610310834i6244c0abm10c81e984565ed8a@mail.gmail.com>
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org> <20061030213454.8266fcb6.akpm@osdl.org> <Pine.LNX.4.64.0610310737000.25218@g5.osdl.org> <45477668.4070801@google.com>
            <2c0942db0610310834i6244c0abm10c81e984565ed8a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1162327980_3142P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 31 Oct 2006 15:53:00 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1162327980_3142P
Content-Type: text/plain; charset=us-ascii

On Tue, 31 Oct 2006 08:34:23 PST, Ray Lee said:
> On 10/31/06, Martin J. Bligh <mbligh@google.com> wrote:
> > > At some point we should get rid of all the "politeness" warnings, just
> > > because they can end up hiding the _real_ ones.
> >
> > Yay! Couldn't agree more. Does this mean you'll take patches for all the
> > uninitialized variable crap from gcc 4.x ?
> 
> What would be useful in the short term is a tool that shows only the
> new warnings that didn't exist in the last point release.

Harder to do than you might think - it has to deal with the fact that
2.6.N might have a warning about 'used unintialized on line 430', and
in 2.6.N+1 you get two warnings, one on line 420 and one on 440.  Which
one is new and which one just moved 10 lines up or down?  Or did a patch
fix the one on 430 and add 2 new ones?

--==_Exmh_1162327980_3142P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFR7escC3lWbTT17ARAiwMAJ4g4ykd8dXsQi6udiYCVFlTrHVcJACdH8lE
N5O6OfQWD5lxF260agLj9NI=
=g/jf
-----END PGP SIGNATURE-----

--==_Exmh_1162327980_3142P--
