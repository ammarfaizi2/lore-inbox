Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265198AbTATB2w>; Sun, 19 Jan 2003 20:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267673AbTATB2w>; Sun, 19 Jan 2003 20:28:52 -0500
Received: from h80ad248b.async.vt.edu ([128.173.36.139]:24194 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S265198AbTATB2v>; Sun, 19 Jan 2003 20:28:51 -0500
Message-Id: <200301200137.h0K1bmIJ012718@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: David Schwartz <davids@webmaster.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is the BitKeeper network protocol documented? 
In-Reply-To: Your message of "Sun, 19 Jan 2003 17:05:02 PST."
             <20030120010504.AAA18836%shell.webmaster.com@whenever> 
From: Valdis.Kletnieks@vt.edu
References: <20030120010504.AAA18836%shell.webmaster.com@whenever>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-43454828P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 19 Jan 2003 20:37:47 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-43454828P
Content-Type: text/plain; charset=us-ascii

On Sun, 19 Jan 2003 17:05:02 PST, David Schwartz said:
> 	Don't blame me. The GPL just says the "preferred" form and leaves us 
> to wonder. As I understand it, however, you cannot ship binaries of a 
> GPL'd project unless you can distribute the source code in the 
> "preferred form .. for making modifications to it".

Hmm... <ponders a bit>

> 	I'm still perplexed what you do if the preferred modification form 
> for a work requires consent to a license more restrictive than the 
> GPL in order to make modifications to it. As I see it, you just can't 
> GPL such a project.

<ponders a bit more>

It's a red herring, folks.

The preferred form for *MAKING* modifications is a /usr/src/linux source
tree.  The form that's in  BitKeeper is in the preferred format for *tracking*
and *managing* changes.  Remember - you have to check the source out of
the repository to do the edit/compile/test loop, and then commit it back
when you're done.  So the BK repository isn't where actual development happens,
because gcc and make can't read the repository.

Of course, having written this, some damn fool will prove me wrong by writing
a  'bkfs' file system (similar to the various 'pgfs' front-ends for Postgres)
so you actually *CAN* do a 'make' of the repository :)

/Valdis


--==_Exmh_-43454828P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+K1LrcC3lWbTT17ARAuz4AJ4+BjDV0P6+3HeUEHfHSykXImpAowCdFOm6
w8yoBgiczSeedCUPLC0jNz8=
=Vd42
-----END PGP SIGNATURE-----

--==_Exmh_-43454828P--
