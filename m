Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264506AbUADBzR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 20:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264586AbUADBzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 20:55:16 -0500
Received: from h80ad2533.async.vt.edu ([128.173.37.51]:23432 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S264506AbUADBzJ (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 20:55:09 -0500
Message-Id: <200401040154.i041saXG029539@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Mark Mielke <mark@mark.mielke.cc>
Cc: Andries Brouwer <aebr@win.tue.nl>, Linus Torvalds <torvalds@osdl.org>,
       Rob Love <rml@ximian.com>, rob@landley.net,
       Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word 
In-Reply-To: Your message of "Sat, 03 Jan 2004 20:16:26 EST."
             <20040104011626.GB6398@mark.mielke.cc> 
From: Valdis.Kletnieks@vt.edu
References: <200401010634.28559.rob@landley.net> <1072970573.3975.3.camel@fur> <20040101164831.A2431@pclin040.win.tue.nl> <1072972440.3975.29.camel@fur> <Pine.LNX.4.58.0401021238510.5282@home.osdl.org> <20040103040013.A3100@pclin040.win.tue.nl> <Pine.LNX.4.58.0401022033010.10561@home.osdl.org> <20040103141029.B3393@pclin040.win.tue.nl> <Pine.LNX.4.58.0401031423180.2162@home.osdl.org> <20040104000840.A3625@pclin040.win.tue.nl>
            <20040104011626.GB6398@mark.mielke.cc>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-398179944P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 03 Jan 2004 20:54:36 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-398179944P
Content-Type: text/plain; charset=us-ascii

On Sat, 03 Jan 2004 20:16:26 EST, Mark Mielke said:

> It seems to me that as long as /dev is always a local mount (tmpfs in
> the case of an NFS-root installation), it doesn't really matter. Maintaining
> system-specific information on a remote machine seems dirty, and something
> that shouldn't be *expected* to work. You wouldn't expect /proc to work
> over NFS, would you? :-)

ISTR that SunOS 4.0 handled an NFS-mounted /dev and swap just fine some 15
years ago? (in fact, due to performance differences between the disks on a Sun3/
2xx server and the shoebox disk on a 3/50, you could page faster over the net
than to a local /dev/swap).

So it's more a case of "we have decided to do it differently" than "that's so nuts
that it shouldn't be expected to work"....

--==_Exmh_-398179944P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/93JccC3lWbTT17ARAmBjAJ9dJT99WXTBFFlEJ4m+9hs5S2+Q2gCgzQEF
j+dfxHu7GjY96BhceaufmEI=
=wv2w
-----END PGP SIGNATURE-----

--==_Exmh_-398179944P--
