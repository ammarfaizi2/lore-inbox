Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261369AbVB0IUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbVB0IUh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 03:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261371AbVB0IUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 03:20:37 -0500
Received: from smtp811.mail.sc5.yahoo.com ([66.163.170.81]:22643 "HELO
	smtp811.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261369AbVB0IU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 03:20:29 -0500
Date: Sun, 27 Feb 2005 02:20:25 -0600
From: Peter Samuelson <peter@p12n.org>
To: zippel@linux-m68k.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [uPATCH] cross-compile scripts/lxdialog/ on AIX
Message-ID: <20050227082025.GA31919@p12n.org>
References: <20050227075459.GS3077@p12n.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <20050227075459.GS3077@p12n.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


[Peter Samuelson]
> AIX curses.h defines macros 'clear_screen' and 'color_names' but does
> not define 'scroll()'.

I should mention that 'make menuconfig' on AIX 4.3 also required 'ln -s
libxcurses.a /usr/lib/libncurses.a' but a patch to detect *that* seemed
too intrusive to be worthwhile.  Also, color escapes are all messed up
and I don't know why, but I blame AIX's funky terminfo.

Peter

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCIYLIXk7sIRPQRh0RAloTAKCXFJEptnIad6ELFEas6V2YMFekiACfSVGC
cbs1gftnF38+uG7PD0nTC5g=
=mXiY
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
