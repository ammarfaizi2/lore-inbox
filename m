Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267334AbTAGHvq>; Tue, 7 Jan 2003 02:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267335AbTAGHvq>; Tue, 7 Jan 2003 02:51:46 -0500
Received: from h80ad273a.async.vt.edu ([128.173.39.58]:35458 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S267334AbTAGHvp>; Tue, 7 Jan 2003 02:51:45 -0500
Message-Id: <200301070800.h0780ECR005255@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: Werner Almesberger <wa@almesberger.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux iSCSI Initiator, OpenSource (fwd) (Re: Gauntlet Set NOW!) 
In-Reply-To: Your message of "Tue, 07 Jan 2003 04:08:29 -0300."
             <20030107040829.E1406@almesberger.net> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.10.10301051924140.421-100000@master.linux-ide.org> <3E19B401.7A9E47D5@linux-m68k.org> <17360000.1041899978@localhost.localdomain> <20030107042045.GA10045@waste.org> <200301070538.h075cICR004033@turing-police.cc.vt.edu> <20030107031638.D1406@almesberger.net> <200301070643.h076hWCR004411@turing-police.cc.vt.edu>
            <20030107040829.E1406@almesberger.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-758498996P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 07 Jan 2003 03:00:14 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-758498996P
Content-Type: text/plain; charset=us-ascii

On Tue, 07 Jan 2003 04:08:29 -0300, Werner Almesberger said:
> Valdis.Kletnieks@vt.edu wrote:

> > it takes *hours* without a
> > packet drop to get the window open *all* the way
> 
> Or did you mean "after" instead of "without" ? Or maybe "into
> equilibrium" instead of "the window open ..." ? (After all, the
> window isn't only open, but it's been blown off its hinges.)

"without".  Let's say it takes 4 hours to recover from a drop, and
you have another one 3 hours into recovery - it will now take more than
one more hour to recover.

"into equilibrium fully open".  It's easy enough to see it in equilibrium
(more or less) not fully open.. ;)

> In any case, your statement accurately describes a somewhat
> surprising quirk in Linux TCP performance as of only a bit more
> than six years ago :)

OK, I tuned in late - are you saying that the 6-year-old Linux quirk
happened to have the same symptoms as Floyd's current work, or that
the slow-start tweaks were designed in 6 years ago, or that a fix for
the quirk accidentally did the same thing as Floyd's stuff?

The whole slow-start/ack/retransmit has been chewed over so many times in the
last 20 years that it's hard to keep track of which vendors picked up which
tweaks when, and which vendors accidentally invented them again, and which
vendors invented the tweaks independently and didn't publicize them more....

/Valdis


--==_Exmh_-758498996P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+GokOcC3lWbTT17ARAvkUAJ4jloX6kjzGF6l7Nv69Y4ZzgJu7RwCg5Hjm
eUWl8a4IF66Fbq4RbT7JveI=
=OtON
-----END PGP SIGNATURE-----

--==_Exmh_-758498996P--
