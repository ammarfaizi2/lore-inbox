Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752261AbWKLSUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752261AbWKLSUG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 13:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752285AbWKLSUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 13:20:06 -0500
Received: from pool-72-66-199-5.ronkva.east.verizon.net ([72.66.199.5]:31939
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1752280AbWKLSUE (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 13:20:04 -0500
Message-Id: <200611121818.kACIIlGZ032051@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC - 2.6.19-rc5-mm1 Documentation/Changes cleanup
In-Reply-To: Your message of "Sun, 12 Nov 2006 19:06:40 +0100."
             <20061112180640.GF3382@stusta.de>
From: Valdis.Kletnieks@vt.edu
References: <200611121735.kACHZ9SX030881@turing-police.cc.vt.edu>
            <20061112180640.GF3382@stusta.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1163355526_6400P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 12 Nov 2006 13:18:46 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1163355526_6400P
Content-Type: text/plain; charset=us-ascii

On Sun, 12 Nov 2006 19:06:40 +0100, Adrian Bunk said:

> >  o  util-linux             2.10o                   # fdformat --version
> > +o  mount                  ???                     # mount --version
> 
> mount is part of util-linux.

Yeah, I know, but ver_linux reports both for some reason.

> >  o  pcmciautils            004                     # pccardctl -V
> > +o  pcmcia-cs              ???                     # cardmgr -V
> 
> This was just removed - pcmcia-cs support was scheduled to be removed 
> in November 2005 (sic), and I hope it won't take too long until it will 
> finally be removed.

And I *just* submitted a patch to actually report pcmciautils version. :)
If ver_linux was only reporting pcmcia-cs version, it probably should be
mentioned here.  Once we actually nuke it, we can certainly remove this
line and the related check in ver_linux.

> > +o  Linuc C Library        ???                     # ldd /bin/sh
> > +o  Dynamic linker (ldd)   ???                     # ldd -v or ldd --version
> > +o  Linux C++ Library      ???                     # ls -l /usr/lib/libstd++.so
> >...
> 
> I don't think these make much sense.

I was particularly mystified by the C++ reference in ver_linux.  But apparently
somebody felt it was important enough to report, and I was basically just trying
to get the two things in sync.  Probably a good place for a 'N/A' or such.

--==_Exmh_1163355526_6400P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFV2WGcC3lWbTT17ARAijEAKDTO77h18m4zWUwC8fPhxr9gYJHOgCgzdOW
OU5CUzG59emQqpwWSN9+6UM=
=o17C
-----END PGP SIGNATURE-----

--==_Exmh_1163355526_6400P--
