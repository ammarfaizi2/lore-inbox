Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262400AbTJTExY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 00:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262403AbTJTExY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 00:53:24 -0400
Received: from h80ad2623.async.vt.edu ([128.173.38.35]:64911 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262400AbTJTExS (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 00:53:18 -0400
Message-Id: <200310200452.h9K4qjN5014945@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Willy Tarreau <willy@w.ods.org>
Cc: Rob Landley <rob@landley.net>, Michael Buesch <mbuesch@freenet.de>,
       Nick Piggin <piggin@cyberone.com.au>, Daniel Egger <degger@fhm.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: Where's the bzip2 compressed linux-kernel patch? 
In-Reply-To: Your message of "Mon, 20 Oct 2003 06:28:37 +0200."
             <20031020042837.GA4994@alpha.home.local> 
From: Valdis.Kletnieks@vt.edu
References: <200310180018.21818.rob@landley.net> <200310191245.55961.mbuesch@freenet.de> <20031019210453.GE16761@alpha.home.local> <200310191900.47300.rob@landley.net>
            <20031020042837.GA4994@alpha.home.local>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-119847996P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 20 Oct 2003 00:52:45 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-119847996P
Content-Type: text/plain; charset=us-ascii

On Mon, 20 Oct 2003 06:28:37 +0200, Willy Tarreau said:

> I don't know how the tests above were done. But what I know for sure is that
> there are excessive open source zealots who would only download the OSS
> version of UPX which uses the UCL library while the closed source version
> uses the NRV one which is a jewel.

Well.. unfortunately, a closed-source UPX has as much chance of making it into
the mainstream kernel as the NVidia graphics drivers.  Both will have to remain
things that are self-inflicted by end users.

> > And no, gzip -9 does not add anything to decompression time, only
> > compression time.
> 
> Where did you get this interesting idea ? every decompressor needs
> decompression time. 

I think he meant that decompressing a 'gzip -1' and a 'gzip -9' go at basically
the same Mbytes/second - the big CPU hit is at compression time.


--==_Exmh_-119847996P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/k2occC3lWbTT17ARAhK2AJ0Ry07ycaUMOPNOwDym3rDGUYCRcQCgx3ja
dCYflUA099+K2y8oOx2u1c4=
=NoAj
-----END PGP SIGNATURE-----

--==_Exmh_-119847996P--
